
export interface IPlant {
    name: string;
    products: string[];
    seed: string;
    maxStage: number;
}



export const PLANT: Record<string, IPlant> = {
    'minecraft:potatoes': {
        name: 'minecraft:potatoes',
        products: [
            "minecraft:potato",
            "minecraft:poisonous_potato",

        ],
        seed: 'minecraft:potato',
        maxStage: 7
    },
    'minecraft:wheat': {
        name: 'minecraft:wheat',
        products: [
            "minecraft:wheat",
            "minecraft:wheat_seeds",

        ],
        seed: 'minecraft:wheat_seeds',
        maxStage: 7
    },
    'mysticalagriculture:inferium_crop': {
        name: 'mysticalagriculture:inferium_crop',
        products: [
            "mysticalagriculture:inferium_essence",
            "mysticalagriculture:inferium_seeds",
            "mysticalagriculture:fertilized_essence",
        ],
        seed: 'mysticalagriculture:inferium_seeds',
        maxStage: 7
    },
    'mysticalagriculture:iron_crop': {
        name: 'mysticalagriculture:iron_crop',
        products: [
            "mysticalagriculture:iron_essence",
            "mysticalagriculture:iron_seeds",
        ],
        seed: 'mysticalagriculture:iron_seeds',
        maxStage: 7
    },
    'mysticalagriculture:brass_crop': {
        name: 'mysticalagriculture:brass_crop',
        products: [
            "mysticalagriculture:brass_essence",
            "mysticalagriculture:brass_seeds",
        ],
        seed: 'mysticalagriculture:brass_seeds',
        maxStage: 7
    }
}
