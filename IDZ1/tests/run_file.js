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
        let log = "", group_verdict = true, sum_cpu_time = 0;
        for (let i = test_groups[tg].start; i <= test_groups[tg].end; i++)
        {
            execFileSync(`./${executable}`, [ "1", `tests/src/${i}.in`, "1", "tmp.out" ]);
            let output = fs.readFileSync(`tests/src/${i}.out`).toString(), data = fs.readFileSync("tmp.out").toString().replaceAll("\n", "").split("CPU time used: ");
            let answer = data[0], cpu_time = Number(data[1].substring(0, data[1].length - 2));
            if (answer == output)
            {
                if (output.length < 50) log += `    Test ${i}: ✅ OK (received: ${answer}, expected: ${output})\n`;
                else log += `   Test ${i}: ✅ OK\n`;
            }
            else
            {
                group_verdict = false;
                if (output.length < 50) log += `    Test ${i}: ❌ WA (received: ${answer}, expected: ${output})\n`;
                else log += `   Test ${i}: ❌ WA\n`;
            }
            sum_cpu_time += cpu_time;
            fs.rmSync("tmp.out");
        }
        if (group_verdict) console.log(`Group ${tg}: ✅ PASSED. Average CPU time: ${sum_cpu_time / (test_groups[tg].end - test_groups[tg].start + 1)}ns`);
        else console.log(`Group ${tg}: ❌ FAILED. Average CPU time: ${sum_cpu_time / (test_groups[tg].end - test_groups[tg].start + 1)}ns`);
        console.log(log);
    }
}