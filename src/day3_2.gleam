import aoc_toolkit.{load_file}
import gleam/int
import gleam/io
import gleam/list
import gleam/pair
import gleam/result
import gleam/string

pub fn main() -> Nil {
  solve("./data/day3_ex1.txt")
  solve("./data/day3_1.txt")
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

pub fn calculate(rows: List(String)) -> Int {
  rows
  |> list.map(calculate_row)
  |> list.fold(0, with: fn(acc, p) { acc + p })
}

pub fn calculate_row(row: String) -> Int {
  row
  |> into_numbers
  |> find_biggest_joltage_pair
  |> combine
  |> int.parse
  |> result.unwrap(0)
}

fn combine(num_pair: #(Int, Int)) -> String {
  num_pair
  |> pair.map_first(with: int.to_string)
  |> pair.map_second(with: int.to_string)
  |> fn(p) {
    let #(a, b) = p
    a <> b
  }
}

fn find_biggest_joltage_pair(nums: List(Int)) -> #(Int, Int) {
  let end = nums |> list.length
  list.fold(nums, #(#(0, 0), 0), fn(acc, c) {
    let #(value, idx) = acc
    let #(a, b) = value
    case value, c {
      #(a, _), c if c > a && { idx + 1 } != end -> #(#(c, 0), idx + 1)
      #(a, b), c if c > b -> #(#(a, c), idx + 1)
      _, _ -> #(#(a, b), idx + 1)
    }
  })
  |> fn(result) {
    let #(value, _) = result
    value
  }
}

fn into_numbers(row: String) -> List(Int) {
  string.to_graphemes(row)
  |> list.map(int.parse)
  |> result.values
}
