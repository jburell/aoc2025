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
    load_file(path, [])
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

pub fn calc_next_token(pos_and_num_zeroes, token) -> #(Int, Int) {
  let #(pos, zeroes) = pos_and_num_zeroes
  let assert Ok(dir) = string.first(token)
  let num_str = string.drop_start(token, 1)
  let assert Ok(steps) = int.parse(num_str)

  let rot_op = case dir {
    "L" -> int.subtract
    "R" -> int.add
    e -> panic as { "Invalid turn instruction: " <> e }
  }

  let calc = rot_op(pos, steps)
  let res = int.absolute_value(calc) / 100
  let zeroes = zeroes + res
  case calc % 100 {
    p if p < 0 ->
      case pos == 0 {
        True -> #(100 + p, zeroes)
        False -> #(100 + p, zeroes + 1)
      }
    0 -> {
      case calc <= 0 {
        True -> #(0, zeroes + 1)
        False -> #(0, zeroes)
      }
    }
    p -> #(p, zeroes)
  }
}
