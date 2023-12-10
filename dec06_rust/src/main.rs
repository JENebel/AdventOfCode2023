fn main() {
    part1();
    part2();
}

fn part1() {
    let input = std::fs::read_to_string("../inputs/dec6.input").unwrap();
    let mut lines = input.lines();
    let times = lines.next().unwrap().split_at(11).1.split_whitespace().map(|i| i.parse::<u64>().unwrap());
    let distances = lines.next().unwrap().split_at(11).1.split_whitespace().map(|i| i.parse::<u64>().unwrap());

    let mut product: u64 = 1;
    for (time, dist) in times.zip(distances) {
        let mut wins: u64 = 0;
        for hold_time in 1..time {
            let sail_time = time - hold_time;
            let distance = sail_time * hold_time;
            if distance > dist {
                wins += 1;
            }
        }
        
        if wins > 0 { product *= wins };
    }

    println!("Part 1: {}", product);
}

fn part2() {
    let input = std::fs::read_to_string("../inputs/dec6.input").unwrap();
    let mut lines = input.lines();
    let time = lines.next().unwrap().split_at(11).1.replace(" ", "").parse::<u64>().unwrap();
    let dist = lines.next().unwrap().split_at(11).1.replace(" ", "").parse::<u64>().unwrap();

    let mut wins: u64 = 0;
    for hold_time in 1..time {
        let sail_time = time - hold_time;
        let distance = sail_time * hold_time;
        if distance > dist {
            wins += 1;
        }
    }

    println!("Part 2: {}", wins);
}