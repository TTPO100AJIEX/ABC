import fs from 'fs';
import { execFileSync } from "child_process";
import { test_groups, to_test } from './CONFIG.js';

function print_result(solution_cpu_times, io_cpu_times, type)
{
    let min_solution_cpu = solution_cpu_times.reduce((prev, cur) => Math.min(prev, cur), 1e9);
    let avg_solution_cpu = solution_cpu_times.reduce((prev, cur) => prev + cur, 0) / solution_cpu_times.length;
    let max_solution_cpu = solution_cpu_times.reduce((prev, cur) => Math.max(prev, cur), -1e9);
    
    let min_io_cpu = io_cpu_times.reduce((prev, cur) => Math.min(prev, cur), 1e9);
    let avg_io_cpu = io_cpu_times.reduce((prev, cur) => prev + cur, 0) / io_cpu_times.length;
    let max_io_cpu = io_cpu_times.reduce((prev, cur) => Math.max(prev, cur), -1e9);

    console.log(
`Solution CPU time on ${type}:
    Minimum: ${(min_solution_cpu / 1e6).toFixed(5)}ms = ${(min_solution_cpu / 1e9).toFixed(5)}s
    Average: ${(avg_solution_cpu / 1e6).toFixed(5)}ms = ${(avg_solution_cpu / 1e9).toFixed(5)}s
    Maximum: ${(max_solution_cpu / 1e6).toFixed(5)}ms = ${(max_solution_cpu / 1e9).toFixed(5)}s
Solution IO time on ${type}:
    Minimum: ${(min_io_cpu / 1e6).toFixed(5)}ms = ${(min_io_cpu / 1e9).toFixed(5)}s
    Average: ${(avg_io_cpu / 1e6).toFixed(5)}ms = ${(avg_io_cpu / 1e9).toFixed(5)}s
    Maximum: ${(max_io_cpu / 1e6).toFixed(5)}ms = ${(max_io_cpu / 1e9).toFixed(5)}s`);
}

for (let executable of to_test)
{
    console.log('------------------------------------------------------------');
    console.log(`-------------------Testing ${executable}-------------------`);
    console.log('------------------------------------------------------------');

    {
        // fixed tests
        let solution_cpu_times = [], io_cpu_times = [];
        for (let i = test_groups[1].start; i <= test_groups[1].end; i++)
        {
            let start = performance.now();
            let answer = execFileSync(`./${executable}`, [ "1", "1", `testing/tests/group2/${i}.in`, "2" ]).toString();
            let end = performance.now();
            solution_cpu_times.push(Number(answer.substring(answer.lastIndexOf(" ") + 1, answer.length - 2)));
            io_cpu_times.push((end - start) * 1e6);
        }
        print_result(solution_cpu_times, io_cpu_times, "fixed tests");
    }

    {
        // random tests
        let solution_cpu_times = [], io_cpu_times = [];
        for (let i = 0; i < 50; i++)
        {
            let start = performance.now();
            let answer = execFileSync(`./${executable}`, [ "1", "2", "2" ]).toString();
            let end = performance.now();
            solution_cpu_times.push(Number(answer.substring(answer.lastIndexOf(" ") + 1, answer.length - 2)));
            io_cpu_times.push((end - start) * 1e6);
        }
        print_result(solution_cpu_times, io_cpu_times, "random tests");
    }
}