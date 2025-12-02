import aoc_toolkit.{load_file}
import gleam/int
import gleam/io
import gleam/list
import gleam/result
import gleam/string

pub fn main() -> Nil {
  solve("./data/day1_ex1.txt")
  solve("./data/day1_1.txt")
}

fn solve(path) {
  let res =
    load_file(path)
    |> result.map(list.flatten)
    |> result.map(calculate)

  case res {
    Ok(r) -> io.println({ "Answer: " <> { int.to_string(r) } })
    Error(_e) -> panic as { "Error parsing data" }
  }
}

fn calculate(items: List(String)) -> Int {
  let start_pos = 50
  let #(_, zeroes) = list.fold(items, #(start_pos, 0), calc_next_token)
  zeroes
}

fn calc_next_token(pos_and_num_zeroes, token) -> #(Int, Int) {
  let #(pos, zeroes) = pos_and_num_zeroes
  let assert Ok(dir) = string.first(token)
  let num_str = string.drop_start(token, 1)
  let assert Ok(steps) = int.parse(num_str)

  let rot_op = case dir {
    "L" -> int.subtract
    "R" -> int.add
    e -> panic as { "Invalid turn instruction: " <> e }
  }

  case rot_op(pos, steps) % 100 {
    p if p < 0 -> #(100 + p, zeroes)
    0 -> #(0, zeroes + 1)
    p -> #(p, zeroes)
  }
}
