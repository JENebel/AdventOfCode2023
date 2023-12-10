use rayon::iter::{IntoParallelRefIterator, ParallelIterator};

fn main() {
    part1();
    part2();
}

fn part1() {
    let input = std::fs::read_to_string("../inputs/dec5.input").unwrap();
    let mut lines = input.lines().into_iter();
    let seeds = lines.next().unwrap()
        .split(":")
        .nth(1).unwrap()
        .trim()
        .split_whitespace()
        .map(|i| i.parse::<i64>().unwrap())
        .collect::<Vec<i64>>();

    let _ = lines.next();

    let mut intervals: Vec<Vec<i64>> = Vec::new();
    for phase in 0..7 {
        let _ = lines.next();
        intervals.push(Vec::new());

        while let Some(line) = lines.next() {
            if line == "" { break }

            line.split_whitespace()
                .map(|i| i.parse::<i64>().unwrap())
                .for_each(|i| intervals[phase].push(i));
        }
    }

    let mut min = i64::MAX;
    for seed in seeds {
        let mut temp = seed;
        for i in 0..7 {
            for j in (0..intervals[i].len()).step_by(3) {
                let destination = intervals[i][j];
                let source = intervals[i][j+1];
                let length = intervals[i][j+2];
                let offset = destination - source;

                if temp >= source && temp < source + length {
                    temp = temp + offset;
                    break;
                }
            }
        }
        min = min.min(temp)
    }
    println!("Part 1: {}", min)
}

fn part2() {
    let input = std::fs::read_to_string("../inputs/dec5.input").unwrap();
    let mut lines = input.lines().into_iter();
    let raw_seeds = lines.next().unwrap()
        .split(":")
        .nth(1).unwrap()
        .trim()
        .split_whitespace()
        .map(|i| i.parse::<i64>().unwrap())
        .collect::<Vec<i64>>();

    let _ = lines.next();

    let mut seeds = Vec::new();
    for seed in raw_seeds.chunks(2) {
        for i in 0..seed[1] {
            seeds.push(seed[0] + i)
        }
    }

    let mut intervals: Vec<Vec<i64>> = Vec::new();
    for phase in 0..7 {
        let _ = lines.next();
        intervals.push(Vec::new());

        while let Some(line) = lines.next() {
            if line == "" { break }

            line.split_whitespace()
                .map(|i| i.parse::<i64>().unwrap())
                .for_each(|i| intervals[phase].push(i));
        }
    }

    let min = seeds.par_iter().map(|seed| {
        let mut temp = *seed;
        for i in 0..7 {
            for j in (0..intervals[i].len()).step_by(3) {
                let destination = intervals[i][j];
                let source = intervals[i][j+1];
                let length = intervals[i][j+2];
                let offset = destination - source;

                if temp >= source && temp < source + length {
                    temp = temp + offset;
                    break;
                }
            }
        }
        temp
    }).min().unwrap();
    println!("Part 2: {}", min)
}