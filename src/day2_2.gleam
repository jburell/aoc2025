import aoc_toolkit.{load_file}
import gleam/float
import gleam/int
import gleam/io
import gleam/list
import gleam/result
import gleam/string

pub fn main() -> Nil {
  solve("./data/day2_ex1.txt")
  //solve("./data/day2_1.txt")
}

fn solve(path) {
  let res =
    load_file(path, [","])
    |> result.map(fn(v) {
      list.map(v, fn(ranges) {
        list.map(ranges, fn(r) { string.split(r, "-") })
      })
      |> list.flatten()
    })
    |> result.map(calculate)

  case res {
    Ok(r) -> io.println({ "Answer: " <> { int.to_string(r) } })
    Error(_e) -> panic as { "Error parsing data" }
  }
}

pub fn calculate(ranges: List(List(String))) -> Int {
  list.map(ranges, fn(p) {
    case p {
      [a, b] -> check_range_group(a, b)
      c ->
        panic as {
          "Not a valid range (e.g. 11-22)" <> { c |> string.join(",") }
        }
    }
  })
  |> list.fold(0, int.add)
}

fn check_range_group(left: String, right: String) -> Int {
  io.println("left: " <> left)
  io.println("right: " <> right)
  calc_lem(
    int.parse(left) |> result.unwrap(0),
    0,
    int.parse(right) |> result.unwrap(0) |> int.add(1),
  )
}

fn calc_lem(lem: Int, acc: Int, upper_limit: Int) -> Int {
  case lem >= upper_limit {
    True -> {
      io.println("Done calculating acc: " <> int.to_string(acc))
      acc
    }
    False -> {
      let len = num_digits(lem)
      let half_len = len / 2
      io.println("half_len: " <> int.to_string(half_len))
      io.println(
        "lem: "
        <> int.to_string(lem)
        <> " has "
        <> int.to_string(len)
        <> " numbers",
      )
      case len % 2 {
        0 -> {
          let mod =
            int.power(10, int.to_float(half_len))
            |> result.unwrap(1.0)
            |> float.truncate()
          let div = half_len * 10
          io.println(
            "div: " <> int.to_string(div) <> ", mod: " <> int.to_string(mod),
          )
          let lower = lem % mod
          let upper = lem / mod
          io.println(
            "upper: "
            <> int.to_string(upper)
            <> ", lower: "
            <> int.to_string(lower),
          )
          #(lower, upper)
          |> fn(p) {
            case p {
              #(a, b) if a == b && a != 0 -> {
                io.println(
                  "a("
                  <> int.to_string(a)
                  <> ") and ("
                  <> int.to_string(b)
                  <> ") is a pair, acc is currently: "
                  <> int.to_string(acc + 1),
                )
                calc_lem(lem + 1, acc + lem, upper_limit)
              }
              _ -> calc_lem(lem + 1, acc, upper_limit)
            }
          }
        }
        _ -> calc_lem(lem + 1, acc, upper_limit)
      }
    }
  }
}

fn num_digits(value: Int) -> Int {
  let num = value / 10
  let rem = int.remainder(value, 10) |> result.unwrap(0)
  //  io.println(
  //    "value: " <> int.to_string(value) <> ", num: " <> int.to_string(num),
  //  )
  case num {
    0 ->
      case rem > 0 {
        True -> 1
        False -> 0
      }
    v -> 1 + num_digits(v)
  }
}
