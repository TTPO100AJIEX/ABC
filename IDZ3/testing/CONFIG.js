const to_test = [
    "int/solution-c.exe",
    "int/solution-asm.exe",
    "int/solution-asm-optimized.exe",
    "int/solution-c-O0.exe",
    "int/solution-c-O1.exe",
    "int/solution-c-O2.exe",
    "int/solution-c-O3.exe",
    "int/solution-c-Ofast.exe",
    "int/solution-c-Os.exe"
];
const test_groups = [
    { "start": 0, "end": 10 },
    { "start": 11, "end": 120 }
];

export { to_test, test_groups };