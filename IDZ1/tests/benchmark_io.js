import fs from 'fs';
import { execFileSync } from "child_process";

{
    console.time('Iteration 9, input from 101.in');
    execFileSync(`./9/solution-asm.exe`, [ "1", "tests/src/101.in", "1", "tmp.out" ], { input: "1000000" });
    console.timeEnd('Iteration 9, input from 101.in');
    let data = fs.readFileSync("tmp.out").toString().replaceAll("\n", "").split("CPU time used: ");
    let cpu_time = Number(data[1].substring(0, data[1].length - 2));
    fs.rmSync("tmp.out");
    console.log(`CPU time: ${(cpu_time / 1e6).toFixed(5)}ms = ${(cpu_time / 1e9).toFixed(5)}s`);
}
{
    console.time('Iteration 10, input from 101.in');
    execFileSync(`./10/solution-asm.exe`, [ "1", "tests/src/101.in", "1", "tmp.out" ]);
    console.timeEnd('Iteration 10, input from 101.in');
    let data = fs.readFileSync("tmp.out").toString().replaceAll("\n", "").split("CPU time used: ");
    let cpu_time = Number(data[1].substring(0, data[1].length - 2));
    fs.rmSync("tmp.out");
    console.log(`CPU time: ${(cpu_time / 1e6).toFixed(5)}ms = ${(cpu_time / 1e9).toFixed(5)}s`);
}


{
    console.time('Iteration 9, random input');
    execFileSync(`./9/solution-asm.exe`, [ "2", "1", "tmp.out" ], { input: "1000000" });
    console.timeEnd('Iteration 9, random input');
    let data = fs.readFileSync("tmp.out").toString().replaceAll("\n", "").split("CPU time used: ");
    let cpu_time = Number(data[1].substring(0, data[1].length - 2));
    fs.rmSync("tmp.out");
    console.log(`CPU time: ${(cpu_time / 1e6).toFixed(5)}ms = ${(cpu_time / 1e9).toFixed(5)}s`);
}
{
    console.time('Iteration 10, random input');
    execFileSync(`./10/solution-asm.exe`, [ "2", "1", "tmp.out" ], { input: "1000000" });
    console.timeEnd('Iteration 10, random input');
    let data = fs.readFileSync("tmp.out").toString().replaceAll("\n", "").split("CPU time used: ");
    let cpu_time = Number(data[1].substring(0, data[1].length - 2));
    fs.rmSync("tmp.out");
    console.log(`CPU time: ${(cpu_time / 1e6).toFixed(5)}ms = ${(cpu_time / 1e9).toFixed(5)}s`);
}