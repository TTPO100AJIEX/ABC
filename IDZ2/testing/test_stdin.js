import fs from 'fs';
import { execFileSync, execSync } from "child_process";
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
            let answer = execSync(`./${executable} 0 0 < testing/tests/${tg + 1}/${i}/in.in`).toString().split("\n")[0];
            let output = fs.readFileSync(`testing/tests/${tg + 1}/${i}/out.out`).toString("utf-8");
            if (answer == output) log += `    Test ${i}: ✅ OK (received: [${answer}], expected: [${output}])\n`;
            else { group_verdict = false; log += `    Test ${i}: ❌ WA (received: [${answer}], expected: [${output}])\n`; }
        }
        if (group_verdict) console.log(`Group ${tg}: ✅ PASSED`);
        else console.log(`Group ${tg}: ❌ FAILED`);
        console.log(log);
    }
}