function generate_test(length, k)
{
    const item_limit = length * k;

    let input = new Array(length);
    for (let i = 0; i < length; i++) input[i] = (Math.random() < 0.5 ? -1 : 1) * Math.floor(Math.random() * item_limit);
    
    return({
        "input": `${length}\n${input.join(' ')}`,
        "output": input.filter((value, index) => (value >= (input[index - 1] ?? item_limit * 2) || value <= (input[index + 1] ?? -item_limit * 2))).join(' ') + ' '
    });
}

import fs from 'fs';
import { test_groups } from './CONSTS.js';
for (let test_group of test_groups)
{
    if (test_group.array_length == 0) continue;
    test_group.end = test_group.end - test_group.start + 1;
    for (let i = 0; i < test_group.end; i++)
    {
        let test = generate_test(test_group.array_length, (i + 1) / 3);
        fs.writeFileSync(`tests/src/${test_group.start + i}.in`, test.input, "utf-8");
        fs.writeFileSync(`tests/src/${test_group.start + i}.out`, test.output, "utf-8");
    }
}