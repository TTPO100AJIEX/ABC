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
        let log = "", group_verdict = true;
        for (let i = test_groups[tg].start; i <= test_groups[tg].end; i++)
        {
            execFileSync(`./${executable}`, [ "1", `testing/tests/${tg + 1}/${i}/in.in`, "1", "int/tmp.out" ]);
            let answer = fs.readFileSync("int/tmp.out").toString().split("\n")[0];
            let output = fs.readFileSync(`testing/tests/${tg + 1}/${i}/out.out`).toString();
            if (answer == output) log += `    Test ${i}: ✅ OK (received: [${answer}], expected: [${output}])\n`;
            else { group_verdict = false; log += `    Test ${i}: ❌ WA (received: [${answer}], expected: [${output}])\n`; }
            fs.rmSync("int/tmp.out");
        }
        if (group_verdict) console.log(`Group ${tg}: ✅ PASSED`);
        else console.log(`Group ${tg}: ❌ FAILED`);
        console.log(log);
    }
}