function generate_test(length)
{
    let input = Math.random() * 2 - 1;
    return({ input: input.toString(), output: Math.asin(input).toString() });
}

import fs from 'fs';
import { test_groups } from './CONFIG.js';

for (let tg = 0; tg < test_groups.length; tg++)
{
    if (tg == 0) continue;
    if (fs.existsSync(`testing/tests/group${tg + 1}`)) fs.rmSync(`testing/tests/group${tg + 1}`, { recursive: true });
    fs.mkdirSync(`testing/tests/group${tg + 1}`);
    for (let i = test_groups[tg].start; i <= test_groups[tg].end; i++)
    {
        let test = generate_test(test_groups[tg].length);
        fs.writeFileSync(`testing/tests/group${tg + 1}/${i}.in`, test.input, "utf-8");
        fs.writeFileSync(`testing/tests/group${tg + 1}/${i}.out`, test.output, "utf-8");
    }
}