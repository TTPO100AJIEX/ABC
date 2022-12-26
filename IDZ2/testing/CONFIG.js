const to_test = [ "int/solution-asm_optimized.exe" ];
const test_groups = [
    { "start": 1, "end": 10, "length": 0 },
    { "start": 11, "end": 20, "length": 10 },
    { "start": 21, "end": 35, "length": 100 },
    { "start": 36, "end": 50, "length": 1000 },
    { "start": 51, "end": 65, "length": 10000 },
    { "start": 66, "end": 80, "length": 100000 },
    { "start": 81, "end": 95, "length": 1000000 },
    { "start": 96, "end": 110, "length": 10000000 },
    { "start": 111, "end": 120, "length": 100000000 }
];

export { to_test, test_groups };