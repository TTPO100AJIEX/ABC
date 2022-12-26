import fs from 'fs';
import { performance } from 'perf_hooks';
import { execFileSync } from "child_process";
import { test_groups, to_test } from './CONFIG.js';

function print_result(solution_cpu, io_cpu, length)
{
    let avg_solution_cpu = solution_cpu.reduce((prev, cur) => prev + cur, 0) / solution_cpu.length;
    let avg_io_cpu = io_cpu.reduce((prev, cur) => prev + cur, 0) / io_cpu.length;
    let s = `String length: ${length}.`;
    s += `\n    Average solution CPU time: ${(avg_solution_cpu / 1e6).toFixed(5)}ms = ${(avg_solution_cpu / 1e9).toFixed(5)}s`;
    s += `\n    Average IO CPU time: ${(avg_io_cpu / 1e6).toFixed(5)}ms = ${(avg_io_cpu / 1e9).toFixed(5)}s`;
    console.log(s);
}

for (let executable of to_test)
{
    console.log('------------------------------------------------------------');
    console.log(`-------------------Benchmarking ${executable}-------------------`);
    console.log('------------------------------------------------------------');
    for (let tg = 0; tg < test_groups.length; tg++)
    {
        if (test_groups[tg].length == 0) continue;
        let solution_cpu_times = [], io_cpu_times = [];
        for (let i = test_groups[tg].start; i <= test_groups[tg].end; i++)
        {
            let start = performance.now();
            execFileSync(`./${executable}`, [ "1", `testing/tests/${tg + 1}/${i}/in.in`, "1", "int/tmp.out" ]);
            let end = performance.now();
            let answer = fs.readFileSync("int/tmp.out").toString().split("\n"); answer = answer[answer.length - 1];
            solution_cpu_times.push(Number(answer.substring(answer.lastIndexOf(" ") + 1, answer.length - 2)));
            io_cpu_times.push((end - start) * 1e6);
            fs.rmSync("int/tmp.out");
        }
        print_result(solution_cpu_times, io_cpu_times, test_groups[tg].length);
    }

    // maximum allowed input length
    {
        let solution_cpu_times = [], io_cpu_times = [];
        for (let i = 1; i <= 5; i++)
        {
            let start = performance.now();
            execFileSync(`./${executable}`, [ "2", "1", "int/tmp.out" ], { input: "1073741824" });
            let end = performance.now();
            let answer = fs.readFileSync("int/tmp.out").toString().split("\n"); answer = answer[answer.length - 1];
            solution_cpu_times.push(Number(answer.substring(answer.lastIndexOf(" ") + 1, answer.length - 2)));
            io_cpu_times.push((end - start) * 1e6);
            fs.rmSync("int/tmp.out");
        }
        print_result(solution_cpu_times, io_cpu_times, 1073741824);
    }
}