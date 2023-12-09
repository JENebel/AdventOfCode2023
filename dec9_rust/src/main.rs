#![feature(iter_map_windows)]

fn main() {
    let input = std::fs::read_to_string("../inputs/dec9.input").unwrap();
    let (sum_front, sum_back): (i64, i64) = input.lines().map(|line| {
        let readings = line.split_whitespace().map(|s| s.parse::<i64>().expect(s)).collect::<Vec<i64>>();
        fn rec_reading(readings: Vec<i64>) -> (i64, i64) {
            if readings.iter().all(|e| *e == 0) { (0, 0) } else {
                let new_readings: Vec<i64> = readings.iter().map_windows(|[a, b]| **b - **a).collect();
                let (front, back) = rec_reading(new_readings);
                (readings[0] - front, readings.last().unwrap() +  back)
            }
        }
        rec_reading(readings)
    }).reduce(|(f1, b1), (f2, b2)| (f1 + f2, b1 + b2)).unwrap();

    println!("Part 1: {}", sum_back);
    println!("Part 2: {}", sum_front)
}