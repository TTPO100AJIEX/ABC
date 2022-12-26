const to_test = [ "9/solution-asm.exe", "10/solution-asm.exe" ];
const test_groups = [
    { "start": 0, "end": 9, "array_length": 0 },
    { "start": 10, "end": 20, "array_length": 10 },
    { "start": 21, "end": 50, "array_length": 100 },
    { "start": 51, "end": 75, "array_length": 1000 },
    { "start": 76, "end": 100, "array_length": 10000 },
    { "start": 101, "end": 110, "array_length": 100000 },
    { "start": 111, "end": 115, "array_length": 1000000 },
    { "start": 116, "end": 120, "array_length": 10000000 }
];

export { to_test, test_groups };