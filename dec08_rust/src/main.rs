use std::collections::HashMap;
use num::Integer;

fn main() {
    part1();
    part2();
}

fn part1() {
    let input = std::fs::read_to_string("../inputs/dec8.input").unwrap();
    let mut lines = input.lines();
    let dirs = lines.next().unwrap();
    lines.next();

    let mut nodes = HashMap::new();
    for line in lines {
        let elems: Vec<&str> = line.split(['=', '(', ',', ')'])
            .filter(|x| x != &" " && x != &"")
            .map(|s| s.trim())
            .collect();
        nodes.insert(elems[0], (elems[1], elems[2]));
    }

    let mut curr = "AAA";
    let mut steps = 0;
    for d in dirs.chars().cycle() {
        if curr == "ZZZ" { break };
        steps += 1;
        match d {
            'L' => curr = nodes[curr].0,
            'R' => curr = nodes[curr].1,
            _ => panic!("Illegal direction")
        }
    }

    println!("Part 1: {}", steps)
}

fn part2() {
    let input = std::fs::read_to_string("../inputs/dec8.input").unwrap();
    let mut lines = input.lines();
    let dirs = lines.next().unwrap();
    lines.next();

    let mut start_nodes = Vec::new();
    let mut nodes = HashMap::new();
    for line in lines {
        let elems: Vec<&str> = line.split(['=', '(', ',', ')'])
            .filter(|x| x != &" " && x != &"")
            .map(|s| s.trim())
            .collect();
        if elems[0].ends_with("A") {start_nodes.push(elems[0])};
        nodes.insert(elems[0], (elems[1], elems[2]));
    }

    let mut lcm = 1;
    for start_node in start_nodes.iter().cloned() {
        let mut curr = start_node;
        let mut step: u128 = 0;
        for d in dirs.chars().cycle() {
            step += 1;
            match d {
                'L' => curr = nodes[curr].0,
                'R' => curr = nodes[curr].1,
                _ => panic!("Illegal direction")
            }
            if curr.ends_with("Z") {
                lcm = lcm.lcm(&step);
                break
            }
        }
    }

    println!("Part 2: {}", lcm)
}
// 14321394058031