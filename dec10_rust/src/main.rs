use std::collections::HashSet;

fn main() {
    part1();
}

#[derive(Copy, Clone, Debug)]
enum Direction {
    Up, Down, Left, Right
}
use Direction::*;

fn get_next((y, x): (usize, usize), moving_dir: Direction, board: &Vec<Vec<char>>) -> Option<((usize, usize), Direction)> {
    let pipe = board[y][x];
    match (moving_dir, pipe) {
        (Down, 'L') => Some(((y, x + 1), Right)),
        (Down, 'J') => Some(((y, x - 1), Left)),
        (Down, '|') => Some(((y + 1, x), Down)),
        (Up, 'F') => Some(((y, x + 1), Right)),
        (Up, '7') => Some(((y, x - 1), Left)),
        (Up, '|') => Some(((y - 1, x), Up)),
        (Right, '-') => Some(((y, x + 1), Right)),
        (Right, 'J') => Some(((y - 1, x), Up)),
        (Right, '7') => Some(((y + 1, x), Down)),
        (Left, 'L') => Some(((y - 1, x), Up)),
        (Left, 'F') => Some(((y + 1, x), Down)),
        (Left, '-') => Some(((y, x - 1), Left)),
        _ => None
    }
}

fn part1() {
    let input = include_str!("../../inputs/dec10.input");
    let mut board: Vec<Vec<char>> = Vec::new();
    let lines = input.lines();
    let mut start = (0, 0);
    for line in lines {
        let mut row: Vec<char> = Vec::new();
        for c in line.chars() {
            if c == 'S' {
                start = (board.len(), row.len());
            }
            row.push(c);
        }
        board.push(row);
    }

    let width = board[0].len();
    let height = board.len();

    // Starts
    let mut frontier: Vec<((usize, usize), Direction)> = Vec::new();
    if width > start.1 + 1 && "7J-".contains(board[start.0][start.1 + 1]) {
        frontier.push(((start.0, start.1 + 1), Right))
    }
    if start.1 > 0 && "FL-".contains(board[start.0][start.1 - 1]) {
        frontier.push(((start.0, start.1 - 1), Left))
    }
    if start.0 > 0 && "F7|".contains(board[start.0 - 1][start.1]) {
        frontier.push(((start.0 - 1, start.1), Up))
    }
    if height > start.0 + 1 && "7J|".contains(board[start.0 + 1][start.1]) {
        frontier.push(((start.0 + 1, start.1), Down))
    }

    let start_pipe = match (frontier[0].1, frontier[1].1) {
        (Right, Left) | (Left, Right) => '-',
        (Up, Down) | (Down, Up) => '|',
        (Left, Down) | (Down, Left) => '7',
        (Up, Left) | (Left, Up) => 'J',
        (Right, Down) | (Down, Right) => 'F',
        (Up, Right) | (Right, Up) => 'L',
        _ => panic!("No start pipe")
    };
    //println!("Start pipe: {}", start_pipe);
    board[start.0][start.1] = start_pipe;

    let mut pipes = HashSet::new();

    'outer: for _start in frontier {
        let mut head = _start;
        pipes.insert(head.0);
        while let Some(next) = get_next(head.0, head.1, &board) {
            head = next;
            pipes.insert(head.0);
            //println!("{:?}", head.0);
            if head.0 == start {
                break 'outer
            }
        }
        pipes = HashSet::new();
    }

    // Part 2
    let mut surrounded = 0;
    for y in 0..height {
        let mut inside = false;
        let mut x = 0;
        while x < width {
            if pipes.contains(&(y, x)) {
                print!("{}", board[y][x]);
                if board[y][x] == '|' {
                    inside = !inside;
                } else {
                    let entry = board[y][x];
                    for b in x + 1..width {
                        x += 1;
                        print!("{}", board[y][b]);
                        match (entry, board[y][b]) {
                            ('F', 'J') => {
                                inside = !inside;
                                break
                            },
                            ('F', '7') => break,
                            ('L', '7') => {
                                inside = !inside;
                                break
                            },
                            ('L', 'J') => break,
                            _ => ()
                        }
                    }
                }
            }
            else if inside {
                print!("X");
                surrounded += 1;
            } else {
                print!("O");
            }
            x += 1;
        }
        println!()
    }

    println!("Part 1: {}", (pipes.len() + 1) / 2);
    println!("Part 2: {}", surrounded);
}