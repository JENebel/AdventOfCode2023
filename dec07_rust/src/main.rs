fn main() {
    part1();
    part2();
}

fn part1() {
    fn card_val(c: char) -> u32 {
        match c {
            '2' => 0,
            '3' => 1,
            '4' => 2,
            '5' => 3,
            '6' => 4,
            '7' => 5,
            '8' => 6,
            '9' => 7,
            'T' => 8,
            'J' => 9,
            'Q' => 10,
            'K' => 11,
            'A' => 12,
            _ => panic!("Invalid card value"),
        }
    }

    fn score_hand(hand: &str) -> u32 {
        let mut card_count = [0; 13];
        for c in hand.chars() {
            card_count[card_val(c) as usize] += 1;
        }
    
        let mut score = 0;
    
        // 2 pair
        let mut pair_count = 0;
        for &c in card_count.iter() {
            if c == 2 {
                pair_count += 1;
            }
        }
        
        if card_count.iter().any(|&x| x == 5) { // 5 of a kind
            score = 6_000_000
        } else if card_count.iter().any(|&x| x == 4) { // 4 of a kind
            score = 5_000_000
        } else if card_count.iter().any(|&x| x == 3) 
               && card_count.iter().any(|&x| x == 2) { // Full house
            score = 4_000_000
        } else if card_count.iter().any(|&x| x == 3) { // 3 of a kind
            score = 3_000_000
        } else if pair_count == 2 { // 2 pair
            score = 2_000_000
        } else if card_count.iter().any(|&x| x == 2) { // 2 of a kind
            score = 1_000_000
        }
    
        score += card_val(hand.chars().nth(0).unwrap()) * 50625;
        score += card_val(hand.chars().nth(1).unwrap()) * 3375;
        score += card_val(hand.chars().nth(2).unwrap()) * 225;
        score += card_val(hand.chars().nth(3).unwrap()) * 15;
        score += card_val(hand.chars().nth(4).unwrap());
    
        score
    }
    
    let input = std::fs::read_to_string("../inputs/dec7.input").unwrap();
    let mut hands = Vec::new();
    for line in input.lines() {
        let (hand, bid) = line.split_at(5);
        hands.push((hand, bid.trim().parse::<u64>().unwrap()));
    }

    hands.sort_by(|a, b| score_hand(a.0).cmp(&score_hand(b.0)));

    let mut sum: u64 = 0;
    for (rank, hand) in hands.iter().enumerate() {
        sum += (rank as u64 + 1) * hand.1
    }

    println!("Part 1: {}", sum)
}

fn part2() {
    fn card_val(c: char) -> u32 {
        match c {
            'J' => 0,
            '2' => 1,
            '3' => 2,
            '4' => 3,
            '5' => 4,
            '6' => 5,
            '7' => 6,
            '8' => 7,
            '9' => 8,
            'T' => 9,
            'Q' => 10,
            'K' => 11,
            'A' => 12,
            _ => panic!("Invalid card value"),
        }
    }

    fn score_hand(hand: &str) -> u32 {
        let mut card_count = [0; 13];
        for c in hand.chars() {
            card_count[card_val(c) as usize] += 1;
        }
    
        let mut score = 0;
        let jokers = card_count[0];
        card_count[0] = 0;

        let pairs = card_count.iter().filter(|&x| *x == 2).count();
        let triple = card_count.iter().any(|&x| x == 3);
        let quad = card_count.iter().any(|&x| x == 4);
        let quint = card_count.iter().any(|&x| x == 5);
        
        if quint || quad && jokers == 1 || triple && jokers == 2 || pairs == 1 && jokers == 3 || jokers >= 4 { // 5 of a kind
            score = 6_000_000
        } else if quad || triple && jokers == 1 || pairs == 1 && jokers == 2 || jokers == 3 { // 4 of a kind
            score = 5_000_000
        } else if triple && pairs == 1 || pairs == 2 && jokers == 1 { // Full house
            score = 4_000_000
        } else if triple || pairs == 1 && jokers == 1 || jokers == 2 { // 3 of a kind
            score = 3_000_000
        } else if pairs == 2 || pairs == 1 && jokers == 1  { // 2 pair
            score = 2_000_000
        } else if pairs == 1 || jokers == 1 { // 2 of a kind
            score = 1_000_000
        }
    
        score += card_val(hand.chars().nth(0).unwrap()) * 50625;
        score += card_val(hand.chars().nth(1).unwrap()) * 3375;
        score += card_val(hand.chars().nth(2).unwrap()) * 225;
        score += card_val(hand.chars().nth(3).unwrap()) * 15;
        score += card_val(hand.chars().nth(4).unwrap());
    
        score
    }
    
    let input = std::fs::read_to_string("../inputs/dec7.input").unwrap();
    let mut hands = Vec::new();
    for line in input.lines() {
        let (hand, bid) = line.split_at(5);
        hands.push((hand, bid.trim().parse::<u64>().unwrap()));
    }

    hands.sort_by(|a, b| score_hand(a.0).cmp(&score_hand(b.0)));

    let mut sum: u64 = 0;
    for (rank, hand) in hands.iter().enumerate() {
        sum += (rank as u64 + 1) * hand.1
    }

    println!("Part 2: {}", sum)
}