use std::collections::HashSet;

fn main() {
    println!("Part 1: {}", solve(2));
    println!("Part 2: {}", solve(1000000));
}

fn solve(scale: usize) -> usize {
    let input = include_str!("../../inputs/dec11.input");

    let mut xs = HashSet::new();
    let mut ys = HashSet::new();
    for (y, line) in input.lines().enumerate() {
        for (x, c) in line.chars().enumerate() {
            if c == '#' {
                xs.insert(x);
                ys.insert(y);
            }
        }
    }

    let mut galaxies = Vec::new();
    let mut y = 0;
    for (ori_y, line) in input.lines().enumerate() {
        let mut x = 0;
        for (ori_x, c) in line.chars().enumerate() {
            if c == '#' {
                galaxies.push((x as usize, y as usize));
            }
            if !xs.contains(&ori_x) {
                x += scale - 1;
            }
            x += 1
        }

        if !ys.contains(&ori_y) {
            y += scale - 1;
        }
        y += 1;
    }

    let mut sum = 0;
    for outer in 0..galaxies.len() {
        for inner in outer + 1..galaxies.len() {
            let g1 = galaxies[outer];
            let g2 = galaxies[inner];
            let dist = g1.0.abs_diff(g2.0) + g1.1.abs_diff(g2.1);
            sum += dist;
        }
    }
    sum
}