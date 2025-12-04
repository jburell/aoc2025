import aoc_toolkit.{load_file}
import gleam/int
import gleam/io
import gleam/list
import gleam/result
import gleam/string

pub fn main() -> Nil {
  solve("./data/day4_ex1.txt")
  solve("./data/day4_1.txt")
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
  calculate_step(rows |> list.map(string.to_graphemes), 0, 0)
}

pub fn calculate_step(rows: List(List(String)), pos_x: Int, pos_y: Int) -> Int {
  let curr_row = list.take(rows, pos_y) |> list.flatten
  let curr_col =
    list_nth(curr_row, pos_x)
    |> fn(p) {
      case p {
        Ok(x) ->
          case x {
            "@" -> {
              let nearest_8 = get_near_8(rows, pos_x, pos_y, curr_col)
            }
            _ -> 0
          }
        _ ->
          panic as {
            "No element at pos: "
            <> int.to_string(pos_x)
            <> ","
            <> int.to_string(pos_y)
          }
      }
    }

  list.fold(nearest_8, 0, fn(acc, p) {
    acc
    + case p == "@" {
      True -> 1
      False -> 0
    }
  })
}

fn get_near_8(
  rows: List(List(String)),
  pos_x: Int,
  pos_y: Int,
  curr_val: String,
) -> List(String) {
  todo
}

pub fn list_nth(list: List(a), index: Int) -> Result(a, Nil) {
  case list, index {
    [x, ..], 0 -> Ok(x)
    [_, ..rest], i if i > 0 -> list_nth(rest, i - 1)
    _, _ -> Error(Nil)
  }
}
