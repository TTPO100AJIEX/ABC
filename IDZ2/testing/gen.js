function generate_test(length)
{
    let test = "", answer = { "numbers": 0, "letters": 0 };
    for (let i = 0; i < length; i++)
    {
        let symbol = String.fromCharCode(Math.floor(Math.random() * 128));
        if (symbol >= '0' && symbol <= '9') answer.numbers++;
        if ((symbol >= 'a' && symbol <= 'z') || (symbol >= 'A' && symbol <= 'Z')) answer.letters++;
        test += symbol;
    }
    return({
        "input": test,
        "output": `Numbers: ${answer.numbers}, Letters: ${answer.letters}`
    });
}

import fs from 'fs';
import { test_groups } from './CONFIG.js';
for (let tg = 0; tg < test_groups.length; tg++)
{
    if (test_groups[tg].length == 0) continue;
    if (fs.existsSync(`testing/tests/${tg + 1}`)) fs.rmdirSync(`testing/tests/${tg + 1}`, { recursive: true });
    fs.mkdirSync(`testing/tests/${tg + 1}`);
    for (let i = test_groups[tg].start; i <= test_groups[tg].end; i++)
    {
        let test = generate_test(test_groups[tg].length);
        fs.mkdirSync(`testing/tests/${tg + 1}/${i}`);
        fs.writeFileSync(`testing/tests/${tg + 1}/${i}/in.in`, test.input, "utf-8");
        fs.writeFileSync(`testing/tests/${tg + 1}/${i}/out.out`, test.output, "utf-8");
    }
}