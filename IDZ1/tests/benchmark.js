import { test_groups, to_test } from './CONSTS.js';

import fs from 'fs';
import { execFileSync } from "child_process";
for (let executable of to_test)
{
    console.log('------------------------------------------------------------');
    console.log(`-------------------Testing ${executable}-------------------`);
    console.log('------------------------------------------------------------');
    for (let test_group of test_groups)
    {
        if (test_group.array_length == 0) continue;
        let cpu_times = [];
        for (let i = test_group.start; i <= test_group.end; i++)
        {
            execFileSync(`./${executable}`, [ "1", `tests/src/${i}.in`, "1", "tmp.out" ]);
            let data = fs.readFileSync("tmp.out").toString().replaceAll("\n", "").split("CPU time used: ");
            cpu_times.push(Number(data[1].substring(0, data[1].length - 2)));
            fs.rmSync("tmp.out");
        }
        let avg_cpu = cpu_times.reduce((prev, cur) => prev + cur, 0) / (test_group.end - test_group.start + 1),
            min_cpu = cpu_times.reduce((prev, cur) => Math.min(prev, cur), 1e15),
            max_cpu = cpu_times.reduce((prev, cur) => Math.max(prev, cur), -1e15);
        let s = `Array length ${test_group.array_length}.`;
        s += `\n    Average CPU time: ${(avg_cpu / 1e6).toFixed(5)}ms = ${(avg_cpu / 1e9).toFixed(5)}s`;
        //s += `\n    Min CPU time: ${(min_cpu / 1e6).toFixed(5)}ms = ${(min_cpu / 1e9).toFixed(5)}s`;
        //s += `\n    Max CPU time: ${(max_cpu / 1e6).toFixed(5)}ms = ${(max_cpu / 1e9).toFixed(5)}s`;
        console.log(s);
    }

    {
        let cpu_times = [];
        for (let i = 0; i < 5; i++)
        {
            execFileSync(`./${executable}`, [ "2", "1", "tmp.out" ], { input: "16777214" });
            let data = fs.readFileSync("tmp.out").toString().replaceAll("\n", "").split("CPU time used: ");
            cpu_times.push(Number(data[1].substring(0, data[1].length - 2)));
            fs.rmSync("tmp.out");
        }
        let avg_cpu = cpu_times.reduce((prev, cur) => prev + cur, 0) / 5,
            min_cpu = cpu_times.reduce((prev, cur) => Math.min(prev, cur), 1e15),
            max_cpu = cpu_times.reduce((prev, cur) => Math.max(prev, cur), -1e15);
        let s = `Array length 16777214.`;
        s += `\n    Average CPU time: ${(avg_cpu / 1e6).toFixed(5)}ms = ${(avg_cpu / 1e9).toFixed(5)}s`;
        //s += `\n    Min CPU time: ${(min_cpu / 1e6).toFixed(5)}ms = ${(min_cpu / 1e9).toFixed(5)}s`;
        //s += `\n    Max CPU time: ${(max_cpu / 1e6).toFixed(5)}ms = ${(max_cpu / 1e9).toFixed(5)}s`;
        console.log(s);
    }
    {
        let cpu_times = [];
        for (let i = 0; i < 3; i++)
        {
            execFileSync(`./${executable}`, [ "2", "1", "tmp.out" ], { input: "33554428" });
            let data = fs.readFileSync("tmp.out").toString().replaceAll("\n", "").split("CPU time used: ");
            cpu_times.push(Number(data[1].substring(0, data[1].length - 2)));
            fs.rmSync("tmp.out");
        }
        let avg_cpu = cpu_times.reduce((prev, cur) => prev + cur, 0) / 3,
            min_cpu = cpu_times.reduce((prev, cur) => Math.min(prev, cur), 1e15),
            max_cpu = cpu_times.reduce((prev, cur) => Math.max(prev, cur), -1e15);
        let s = `Array length 33554428.`;
        s += `\n    Average CPU time: ${(avg_cpu / 1e6).toFixed(5)}ms = ${(avg_cpu / 1e9).toFixed(5)}s`;
        //s += `\n    Min CPU time: ${(min_cpu / 1e6).toFixed(5)}ms = ${(min_cpu / 1e9).toFixed(5)}s`;
        //s += `\n    Max CPU time: ${(max_cpu / 1e6).toFixed(5)}ms = ${(max_cpu / 1e9).toFixed(5)}s`;
        console.log(s);
    }
}