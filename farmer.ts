import {IInventory} from "./config/inventories";
import {Direction} from "./config/direction";
import {IPlant, PLANT} from "./config/plant";
import {IBlock, IPlantBlock} from "./config/block";

// Helper constant for a 2d env
const NO_Z = 0;

// Chosen fuel item (Should have a drawer in the inventories row)
const FUEL_SOURCE = 'minecraft:charcoal';

// Farmer save data
interface ISaveData {
    farmMaxX: number;
    farmMaxY: number;
    faceDirection: Direction;
    currentLocation: [number, number];
    nextPlant: [number, number];
    state: FARMER_STATE;
    farm: Record<string, string>;
    inventories: IInventory[];
    priorityStorage: Record<string, IInventory>;
}

// Farming states
enum FARMER_STATE {
    INIT,
    CHECK_PLANTS,
    REFUEL,
    INVENTORY,
    SLEEP,
}

/**
 * Automatic farmer.
 * Start turtle one y level above plants, configure like this:
 * P = Plant,
 * I = inventory/drawer/chest,
 * @ = Turtle (Y level above everything else)
 *  Can have infinite rows/columns
 *  [P, P, P, P.....]
 *  [P, P, P, P.....]
 *  [P, P, P, P.....]
 *  [P, P, P, P.....]
 *  [@, I, I, I.....]
 *
 *  Looks for FUEL in inventory (drawer), prioritises drawer storage above all else
 */
export class Farmer {
    // Plant area width
    private farmMaxX;
    // Plant area length
    private farmMaxY;

    private faceDirection: Direction = Direction.North;
    // Current location of turtle
    private currentLocation: Vector = new Vector(0, 0, NO_Z);

    private readonly startPosition: Vector = new Vector(0, 0, NO_Z);

    // Next plant in queue for turtle to check growth stage of
    private nextPlant: [number, number] = [0, 0]

    // Chests to dump loot in
    private inventories: IInventory[];

    // drawers to prioitise storage in
    private priorityStorage: Record<string, IInventory>;

    // The current farm layout
    private farm: Record<string, string>;

    // Current farming state
    private state: FARMER_STATE = FARMER_STATE.INIT;

    constructor() {

        // Check if a savestate exists, attempt to load if it does.
        if (this.fileExists("farmstate.json")) {
            const data = this.getFileData("farmstate.json");
            if (data) {
                const read: ISaveData = textutils.unserialiseJSON(data);
                this.farmMaxY = read.farmMaxY;
                this.farmMaxX = read.farmMaxX;
                this.farm = read.farm;
                this.faceDirection = read.faceDirection;
                this.nextPlant = read.nextPlant;
                this.currentLocation = new Vector(read.currentLocation[0], read.currentLocation[1], NO_Z);
                this.state = read.state;
                this.inventories = read.inventories;
                this.priorityStorage = read.priorityStorage;
                return;
            }
        }

        // Scan inventory row and check for drawers/chests
        if (!this.scanInventories()) {
            return;
        }

        // Find farm dimmensions, stops if there is no (supported) plant, or a wall
        const farmSize = this.getFarmSize();
        if (!farmSize) {
            this.resetTurtle();
            return;
        }

        this.farmMaxX = farmSize[0];
        this.farmMaxY = farmSize[1];

        // Scan every plant on the farm
        this.farm = this.scanFarm()

        // Go back to initial position and face north
        this.resetTurtle();
        return;
    }


    loop(): boolean {
        switch (this.state) {
            case FARMER_STATE.INVENTORY:
                print("INVENTORY MANAGEMENT")
                const slots = this.optimiseInventory();
                if (slots >= 4) {
                    this.state = FARMER_STATE.CHECK_PLANTS;
                    break;
                }

                this.dumpInventory();
                this.state = FARMER_STATE.CHECK_PLANTS;
                break;
            case FARMER_STATE.REFUEL:
                print("REFUEL")
                const itemSlot = this.findItem(FUEL_SOURCE);
                if (itemSlot) {
                    turtle.select(itemSlot + 1);
                    turtle.refuel();
                    this.state = FARMER_STATE.CHECK_PLANTS;
                    break;
                }
                const container = this.priorityStorage[FUEL_SOURCE];
                this.walkTo(container.location);
                turtle.suckDown();
                break;
            case FARMER_STATE.INIT:
                if (!this.farmMaxX || !this.farmMaxY || !this.farm) {
                    this.resetTurtle();
                    return false;
                }
                this.state = FARMER_STATE.CHECK_PLANTS;
                this.nextPlant = [0, 0]
                this.writeState();
                break;
            case FARMER_STATE.SLEEP:
                print("SLEEP")
                sleep(20);
                this.state = FARMER_STATE.CHECK_PLANTS;
                this.nextPlant = [0, 0]
                break;
            case FARMER_STATE.CHECK_PLANTS:
                if (this.maintenanceNeeded()) {
                    break;
                }
                this.walkToPoint([this.nextPlant[0], this.nextPlant[1] + 1]);
                const plantName = this.farm[`${this.nextPlant[0]}_${this.nextPlant[1]}`];
                const plant = plantName && PLANT[this.farm[`${this.nextPlant[0]}_${this.nextPlant[1]}`]];
                print(`${this.nextPlant[0]}_${this.nextPlant[1]}`)
                // print(`standing on ${plantName}`)
                if (plant) {
                    const block = this.getBlockInfo();
                    if (!block) {
                        const seedItem = this.findItem(plant.seed);
                        if (seedItem !== null) {
                            turtle.select(seedItem + 1);
                            turtle.placeDown();
                        }
                    } else if (plant.name === block.name) {
                        const plantBlock = block as IPlantBlock;
                        print(`${plant.name} (${plantBlock.state?.age}/${plant.maxStage})`)
                        if (plantBlock.state?.age === plant.maxStage) {
                            this.replacePlant(plant as IPlant)
                        }
                    }
                }
                const x = this.nextPlant[0];
                const y = this.nextPlant[1];

                if (x % 2 === 1) {
                    if (y == 0) {
                        if (x === this.farmMaxX - 1) {
                            this.state = FARMER_STATE.SLEEP;
                            this.walkTo(this.startPosition);
                            break;
                        }
                        this.nextPlant[0]++;
                        this.nextPlant[1] = 0;
                    } else {
                        this.nextPlant[1]--;
                    }
                } else {
                    if (y == this.farmMaxY - 1) {
                        if (x === this.farmMaxX - 1) {
                            this.state = FARMER_STATE.SLEEP;
                            this.walkTo(this.startPosition);
                            break;
                        }
                        this.nextPlant[0]++;
                        this.nextPlant[1] = this.farmMaxY - 1;
                    } else {
                        this.nextPlant[1]++;
                    }
                }
                break;

        }


        return true;
    }

    private resetTurtle() {
        this.walkTo(this.startPosition);
        this.setFacingDirection(Direction.North);
    }

    private setFacingDirection(direction: Direction) {
        const difference = ((direction - this.faceDirection) + 4) % 4;
        if (difference === 0) {
            return;
        }
        if (difference === 3) {
            turtle.turnLeft();
        } else {
            for (let i = 0; i < difference; i++) {
                turtle.turnRight();
            }
        }
        this.faceDirection = direction;
        this.writeState()
    }

    private findPlantDefinition(name: string): IPlant | null {
        for (const plant of Object.values(PLANT)) {
            if (name === plant.name) {
                return plant;
            }
        }
        return null;
    }

    private walkTo(destination: Vector) {
        print(`Walking To (${destination.x}, ${destination.y})`)
        let vecotriesed = new Vector(destination.x, destination.y, destination.z);
        let difference = vecotriesed.sub(this.currentLocation);
        while (difference.x !== 0 || difference.y !== 0) {
            if (difference.x > 0) {
                this.setFacingDirection(Direction.East);
                if (turtle.forward()) {
                    this.currentLocation = this.currentLocation.add(new Vector(1, 0, NO_Z))
                } else {
                    return false;
                }
            } else if (difference.x < 0) {
                this.setFacingDirection(Direction.West);
                if (turtle.forward()) {
                    this.currentLocation = this.currentLocation.add(new Vector(-1, 0, NO_Z))
                } else {
                    return false;
                }
            } else if (difference.y > 0) {
                this.setFacingDirection(Direction.North);
                if (turtle.forward()) {
                    this.currentLocation = this.currentLocation.add(new Vector(0, 1, NO_Z))
                } else {
                    return false;
                }
            } else if (difference.y < 0) {
                this.setFacingDirection(Direction.South);
                if (turtle.forward()) {
                    this.currentLocation = this.currentLocation.add(new Vector(0, -1, NO_Z))
                } else {
                    return false;
                }
            }
            difference = vecotriesed.sub(this.currentLocation);
            this.writeState();
        }
        return true;
    }


    private dumpInventory() {
        print("DUMPING INVENTORY")
        for (let i = 0; i < 16; i++) {
            turtle.select(i + 1);
            const inventoryItem: null | { name: string, count: number } = turtle.getItemDetail(i + 1) as null | { name: string, count: number };
            if (inventoryItem) {
                let isDone = false;
                const storageInventory = this.priorityStorage[inventoryItem.name];
                if (storageInventory) {
                    print(storageInventory.location);
                    this.walkTo(new Vector(storageInventory.location.x, storageInventory.location.y, storageInventory.location.z));
                    if (turtle.dropDown()) {
                        isDone = true;
                    }
                }
                if (!isDone) {
                    for (const inventory of this.inventories) {
                        this.walkTo(new Vector(inventory.location.x, inventory.location.y, inventory.location.z));
                        if (turtle.dropDown()) {
                            break;
                        }
                    }
                }
            }
        }
    }

    private getBlockInfo(): IBlock {
        const [hasBlock, blockInfo] = turtle.inspectDown() as [boolean, string | IBlock];
        if (hasBlock && typeof blockInfo === 'object') {
            return blockInfo;
        }
    }

    private getPeripheralType(): {
        name: string,
        type: string,
    } | null {
        const [peripheralName, peripheralType] = peripheral.getType("bottom");
        if (peripheralName && peripheralType) {
            return {
                name: peripheralName,
                type: peripheralType
            };
        }
        return null

    }

    private getFarmSize() {
        let farmSize: [number, number] = [1, 1];
        let foundMaxY = false;
        let foundMaxX = false;

        if (!this.walkTo(new Vector(0, 1, NO_Z))) {
            return undefined;
        }

        while (!foundMaxY) {
            const current = this.getBlockInfo();
            if (!current || !this.findPlantDefinition(current.name)) {
                foundMaxY = true;
                farmSize[1] = farmSize[1] - 1;
                break;
            }
            if (!this.walkTo(this.currentLocation.add(new Vector(0, 1, NO_Z)))) {
                foundMaxY = true;
                break;
            }
            farmSize[1]++;
        }

        if (!this.walkTo(new Vector(0, 1, NO_Z))) {
            return undefined;
        }

        while (!foundMaxX) {
            const current = this.getBlockInfo();
            if (!current || !this.findPlantDefinition(current.name)) {
                foundMaxX = true;
                farmSize[0] = farmSize[0] - 1;
                break;
            }
            if (!this.walkTo(this.currentLocation.add(new Vector(1, 0, NO_Z)))) {
                foundMaxX = true;
                break;
            }
            farmSize[0]++;
        }
        return farmSize;
    }

    private scanInventories() {
        const inventories: IInventory[] = [];
        const priorityStorage: Record<string, IInventory> = {};
        if (!this.walkTo(new Vector(0, 0, NO_Z))) {
            return false;
        }
        let foundMax = false;

        while (!foundMax) {
            if (!this.currentLocation.equals(this.startPosition)) {
                const current = this.getPeripheralType();
                if (current && current.type === 'inventory') {
                    if (current.name.includes('drawers')) {
                        const inventoryPeripheral: InventoryPeripheral = peripheral.wrap("bottom") as InventoryPeripheral;
                        for (let i = 1; i < inventoryPeripheral.size() + 1; i++) {
                            const item = inventoryPeripheral.getItemDetail(i);
                            if (item && item.name) {
                                priorityStorage[item.name] = {
                                    items: {
                                        [item.name]: item.count
                                    },
                                    location: this.currentLocation
                                }
                            }

                        }
                    } else {
                        const items = {};
                        const inventoryPeripheral: InventoryPeripheral = peripheral.wrap("bottom") as InventoryPeripheral;
                        for (let i = 1; i < inventoryPeripheral.size() + 1; i++) {
                            const item = inventoryPeripheral.getItemDetail(i);
                            if (item && item.name) {
                                items[item.name] = item.count;
                                // priorityStorage[item.name] = {
                                //     items: {
                                //         [item.name]: item.count
                                //     },
                                //     location: this.currentLocation
                            }
                        }

                        inventories.push({
                            items: items,
                            location: this.currentLocation
                        })

                    }
                } else {
                    foundMax = true;
                }
            }
            if (!this.walkTo(this.currentLocation.add(new Vector(1, 0, NO_Z)))) {
                foundMax = true;
                break;
            }
        }
        this.inventories = inventories;
        this.priorityStorage = priorityStorage;
        return true;

    }


    private scanFarm() {
        const farm: Record<string, string> = {};
        for (let x = 0; x < this.farmMaxX; x++) {
            // farm[x] = [];
            const walkToCheck = (x1, y1) => {
                this.walkTo(new Vector(x1, y1 + 1, NO_Z))

                const block = this.getBlockInfo();
                if (block && this.findPlantDefinition(block.name)) {
                    farm[`${x}_${y1}`] = this.findPlantDefinition(block.name).name;
                    print(`(${x},${y1}): ${farm[`${x}_${y1}`]}`)
                }
            }
            if (x % 2 === 1) {
                for (let y = this.farmMaxY - 1; y >= 0; y--) {
                    walkToCheck(x, y);
                }
            } else {
                for (let y = 0; y < this.farmMaxY; y++) {
                    walkToCheck(x, y);
                }
            }
        }


        return farm;
    }

    private getOpenSlots(): number {
        let openCount = 0;
        for (let i = 0; i < 16; i++) {
            const inventoryItem: null | { name: string, count: number } = turtle.getItemDetail(i + 1) as null | { name: string, count: number };
            if (!inventoryItem) {
                openCount++;
            }
        }
        return openCount;
    }

    private walkToPoint(point: [number, number]) {
        return this.walkTo(new Vector(point[0], point[1], NO_Z));
    }

    private replacePlant(plant: IPlant) {
        let seedItem = this.findItem(plant.seed);
        if (seedItem) {
            turtle.select(seedItem + 1);
        }
        turtle.digDown()
        seedItem = this.findItem(plant.seed);
        if (seedItem === null) {
            return;
        }
        turtle.select(seedItem + 1);
        turtle.placeDown();
    }

    private findItem(itemName: string): number | null {
        for (let i = 0; i < 16; i++) {

            const inventoryItem: null | { name: string, count: number } = turtle.getItemDetail(i + 1) as null | { name: string, count: number };
            if (inventoryItem && inventoryItem.name === itemName) {
                return i;
            }
        }
        return null;

    }

    fileExists(filename): boolean {
        const [file, error] = io.open(filename, "r");
        const exists = file !== null;
        if (exists) {
            io.close(file);
        }
        return exists;

    }

    private optimiseInventory() {
        for (let i = 0; i < 16; i++) {
            const inventoryItem: null | { name: string, count: number } = turtle.getItemDetail(i + 1) as null | { name: string, count: number };
            if (inventoryItem) {
                for (let j = i; j < 16; j++) {
                    const otherItem: null | { name: string, count: number } = turtle.getItemDetail(j + 1) as null | { name: string, count: number };
                    if (otherItem && otherItem.name === inventoryItem.name) {
                        turtle.select(j + 1);
                        turtle.transferTo(i + 1);
                    }
                }
            }
        }
        return this.getOpenSlots();
    }

    getFileData(filename: string): string | null {
        const [file, error] = io.open(filename, "r");
        if (file) {
            let line = file.read();
            let content = ''
            while (line) {
                content = content + '\n' + line;
                line = file.read();
            }
            return content;
        }
        return null
    }

    private writeState() {
        if (this.state === FARMER_STATE.INIT) {
            return;
        }
        const [file, error] = io.open('farmstate.json', "w");
        file.write(textutils.serialiseJSON(
            {
                farmMaxX: this.farmMaxX,
                farmMaxY: this.farmMaxY,
                faceDirection: this.faceDirection,
                currentLocation: [this.currentLocation.x, this.currentLocation.y],
                nextPlant: this.nextPlant,
                state: this.state,
                farm: this.farm,
                inventories: this.inventories,
                priorityStorage: this.priorityStorage,

            } as ISaveData
        ))
        io.close(file);
    }

    private maintenanceNeeded() {
        if (this.getOpenSlots() <= 3) {
            this.state = FARMER_STATE.INVENTORY;
            return true;
        }
        if (turtle.getFuelLevel() <= this.farmMaxY + 1 + this.farmMaxX + 1) {
            this.state = FARMER_STATE.REFUEL;
            return true;
        }
        return false;
    }
}
