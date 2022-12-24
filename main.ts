import * as event from "./event";
import {Farmer} from "./farmer";

xpcall(() => {
    const farmer = new Farmer();

    let running = true;
    while (running) {
        running = farmer.loop();
    }
}, err => print(textutils.serialise(err)))


// function findPeripherals(peripheralName: string) {
//     const peripheralNames = peripheral.getNames();
//     for (const peripheralName of peripheralNames) {
//         const [blockName, peripheralType] = peripheral.getType(peripheralName);
//         print(`Found peripheral ${peripheralName || 'nil'} [${blockName || 'nil'}] [${peripheralType || 'nil'}]`);
//     }
//     return [];
// }
//
// const furnaces = findPeripherals("furnace")
//
// print(furnaces);

//
//
//
//
//
// enum FURNACE_SLOT {
//     INPUT=1,
//     FUEL=2,
//     OUTPUT=3
// }
//
//
// const furnace = peripheral.wrap("front") as InventoryPeripheral;
// const output = peripheral.wrap("left") as InventoryPeripheral;
// const input = peripheral.wrap("right") as InventoryPeripheral;
//
// let hasMore = true;
//
// function findSlot(inventoryPeripheral: InventoryPeripheral, nbtName: string) {
//     for (let i = 1; i < inventoryPeripheral.size()+1; i++) {
//         const item = inventoryPeripheral.getItemDetail(i);
//         // print(`checked slot ${i}, found ${item && item.name || "nil"}`)
//         if(item && item.name === nbtName) {
//             return i;
//         }
//     }
//
//     return null;
// }
//
// while (hasMore) {
//     const furnaceInput = furnace.list()[FURNACE_SLOT.INPUT];
//     const furnaceOutput = furnace.list()[FURNACE_SLOT.OUTPUT];
//     const furnaceFuel = furnace.list()[FURNACE_SLOT.FUEL];
//
//     if(furnaceFuel.count !== 64) {
//         print("need fuel")
//         const slotWithCharcoal = findSlot(output, "minecraft:charcoal");
//         if(slotWithCharcoal) {
//             print("found slot")
//             furnace.pullItems(peripheral.getName(output), slotWithCharcoal, 64, FURNACE_SLOT.FUEL);
//         }
//     }
//     if(furnaceOutput && furnaceOutput.count > 0) {
//         print("Has output")
//         // const slotWithCharcoal = findSlot(output, "minecraft:charcoal");
//             output.pullItems(peripheral.getName(furnace), FURNACE_SLOT.OUTPUT, );
//     }
//     if(!furnaceInput || furnaceInput.count !== 64) {
//         print("has space")
//         const slotWithWood = findSlot(input, "biomesoplenty:fir_log");
//         if(slotWithWood) {
//             print("found slot")
//             furnace.pullItems(peripheral.getName(input), slotWithWood, 64, FURNACE_SLOT.INPUT);
//         }
//     }
//
//     hasMore = Object.keys(input.list()).length !== 0 || !furnaceInput && !furnaceOutput;
//     print("sleep");
//     sleep(10);
// }
