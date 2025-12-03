import aoc_toolkit.{load_file}
import gleam/int
import gleam/io
import gleam/list
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
  |> find_biggest_joltage_group
  |> combine
  |> int.parse
  |> result.unwrap(0)
}

fn combine(num_arr12: List(Int)) -> String {
  num_arr12
  |> list.map(int.to_string)
  |> list.fold("", fn(acc, s) { acc <> s })
}

fn skip_smaller(value: Int, nums: List(Int), overflow: Int) -> #(List(Int), Int) {
  case nums {
    [] -> #([], overflow)
    [x, ..xs] -> {
      let #(xs2, overflow) = skip_smaller(value, xs, overflow)
      case overflow > 0 && x < value {
        True -> #(xs2, overflow - 1)
        False -> #([x, ..xs2], overflow)
      }
    }
  }
}

fn find_biggest_joltage_group(nums: List(Int)) -> List(Int) {
  let overflow = list.length(nums) - 12
  let #(num_list, resulting_overflow) =
    list.fold(nums, #([], overflow), fn(acc, d) {
      let #(curr_num_list, curr_overflow) = acc
      let #(new_num_list, new_overflow) =
        skip_smaller(d, curr_num_list, curr_overflow)
      #(list.append(new_num_list, [d]), new_overflow)
    })

  case resulting_overflow {
    0 -> num_list
    _ -> {
      let len = list.length(num_list)
      let keep = len - resulting_overflow
      list.take(num_list, keep)
    }
  }
}

fn into_numbers(row: String) -> List(Int) {
  string.to_graphemes(row)
  |> list.map(int.parse)
  |> result.values
}
