

// turtle.inspect block
export interface IBlock {
    name: string;
    state: Record<string, unknown>;
    tags: unknown;
}



export interface IPlantBlock extends IBlock {
    name: string;
    state: {
        age: number;
    };
}

export interface WheatPlant extends IPlantBlock {
    name: 'minecraft:wheat';
    state: {
        age: 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7;
    };
}

export interface PotatoPlant extends IPlantBlock {
    name: 'minecraft:potatoes';
    state: {
        age: 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7;
    };
}
