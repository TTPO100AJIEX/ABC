import fs from 'fs';
import { execFileSync } from "child_process";
import { test_groups, to_test } from './CONFIG.js';

for (let executable of to_test)
{
    console.log('------------------------------------------------------------');
    console.log(`-------------------Testing ${executable}-------------------`);
    console.log('------------------------------------------------------------');
    for (let tg = 0; tg < test_groups.length; tg++)
    {
        let log = [ ], group_verdict = true;
        for (let i = test_groups[tg].start; i <= test_groups[tg].end; i++)
        {
            let input = fs.readFileSync(`testing/tests/group${tg + 1}/${i}.in`).toString("utf-8"), output = fs.readFileSync(`testing/tests/group${tg + 1}/${i}.out`).toString("utf-8");
            let answer = execFileSync(`./${executable}`, [ "0", "0", "0" ], { input: input }).toString(); answer = answer.substring(0, answer.indexOf("\n"));
            if (isNaN(output))
            {
                if (answer == output) log.push([ `Test ${i}:`, "✅ OK", `(received: ${answer},`, `expected: ${output})`, "" ]);
                else log.push([ `Test ${i}:`, "❌ WA", `(received: ${answer},`, `expected: ${output})`, "" ]);
            }
            else
            {
                if (isNaN(answer)) log.push([ `Test ${i}:`, "❌ WA", `(received: ${answer},`, `expected: ${output})`, "" ]);
                else
                {
                    let error = Math.abs(Number(output) - Number(answer));
                    if (error < 0.0005) log.push([ `Test ${i}:`, "✅ OK", `(received: ${answer},`, `expected: ${output},`, `error: ${error * 1e4}e-4)` ]);
                    else log.push([ `Test ${i}:`, "❌ WA", `(received: ${answer},`, `expected: ${output},`, `error: ${error * 1e4}e-4)` ]);
                }
            }
        }
        if (group_verdict) console.log(`Group ${tg}: ✅ PASSED`);
        else console.log(`Group ${tg}: ❌ FAILED`);

        let colwidths = [ 0, 0, 0, 0, 0 ];
        for (let i = 0; i < log.length; i++)
        {
            for (let j = 0; j < log[i].length; j++) colwidths[j] = Math.max(colwidths[j], log[i][j].length);
        }
        for (let i = 0; i < log.length; i++)
        {
            for (let j = 0; j < log[i].length; j++) log[i][j] = `${log[i][j]}${" ".repeat(colwidths[j] - log[i][j].length)}`;
            log[i] = "    " + log[i].join(' ');
        }
        console.log(log.join("\n"));
    }
}