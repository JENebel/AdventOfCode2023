use regex::Regex;

fn main() {
    part1();
    part2();
}

fn part1() {
    let mut sum = 0;
    let input = std::fs::read_to_string("../dec1.input").unwrap();
    for line in input.lines() {
        let digits = line.chars().filter(|c| c.is_digit(10));
        let first = digits.clone().next().unwrap();
        let last = digits.last().unwrap();
        sum += format!("{}{}", first, last).parse::<u32>().unwrap();
    }
    println!("Part 1: {sum}")
}

fn part2() {
    fn to_int(s: &str) -> u32 {
        let strs = vec!["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"];
        match strs.iter().enumerate().find(|(_, a)| **a == s) {
            Some((i, _)) => i as u32 + 1,
            _ => s.parse::<u32>().expect(&format!("{s}"))
        }
    }
    let mut sum = 0;
    let input = std::fs::read_to_string("../dec1.input").unwrap();
    let regex_string = r"1|2|3|4|5|6|7|8|9|one|two|three|four|five|six|seven|eight|nine";
    for line in input.lines() {
        let first = Regex::new(regex_string).unwrap().find(line).unwrap().as_str();
        let rev_line = line.chars().rev().collect::<String>();
        let rev_rule = regex_string.chars().rev().collect::<String>();
        let last = Regex::new(&rev_rule).unwrap().find(&rev_line).unwrap().as_str();
        let rev_last = last.chars().rev().collect::<String>();
        sum += &format!("{}{}", to_int(first), to_int(&rev_last)).parse().unwrap();
    }
    println!("Part 2: {sum}")
}