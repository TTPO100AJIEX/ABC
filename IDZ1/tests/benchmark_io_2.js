import { test_groups, to_test } from './CONSTS.js';

import fs from 'fs';
import { execFileSync } from "child_process";
for (let executable of to_test)
{
    console.log('------------------------------------------------------------');
    console.log(`-------------------Testing ${executable}-------------------`);
    console.log('------------------------------------------------------------');
    for (let tg = 0; tg < test_groups.length; tg++)
    {
        console.time(`Test ${test_groups[tg].array_length}`);
        execFileSync(`./${executable}`, [ "1", `tests/src/${test_groups[tg].start}.in`, "1", "tmp.out" ]);
        console.timeEnd(`Test ${test_groups[tg].array_length}`);
        let data = fs.readFileSync("tmp.out").toString().replaceAll("\n", "").split("CPU time used: ");
        let cpu_time = Number(data[1].substring(0, data[1].length - 2));
        fs.rmSync("tmp.out");
        console.log(`   CPU time: ${(cpu_time / 1e6).toFixed(5)}ms = ${(cpu_time / 1e9).toFixed(5)}s`);
    }
    {
        console.time(`Test 16777214`);
        execFileSync(`./${executable}`, [ "2", "1", "tmp.out" ], { input: "16777214" });
        console.timeEnd(`Test 16777214`);
        let data = fs.readFileSync("tmp.out").toString().replaceAll("\n", "").split("CPU time used: ");
        let cpu_time = Number(data[1].substring(0, data[1].length - 2));
        fs.rmSync("tmp.out");
        console.log(`   CPU time: ${(cpu_time / 1e6).toFixed(5)}ms = ${(cpu_time / 1e9).toFixed(5)}s`);
    }
    {
        console.time(`Test 33554428`);
        execFileSync(`./${executable}`, [ "2", "1", "tmp.out" ], { input: "33554428" });
        console.timeEnd(`Test 33554428`);
        let data = fs.readFileSync("tmp.out").toString().replaceAll("\n", "").split("CPU time used: ");
        let cpu_time = Number(data[1].substring(0, data[1].length - 2));
        fs.rmSync("tmp.out");
        console.log(`   CPU time: ${(cpu_time / 1e6).toFixed(5)}ms = ${(cpu_time / 1e9).toFixed(5)}s`);
    }
}