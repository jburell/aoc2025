import day1_2
import gleeunit

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn day1_2_test() {
  assert day1_2.calc_next_token(#(50, 0), "L30") == #(20, 0)
  assert day1_2.calc_next_token(#(50, 0), "L60") == #(90, 1)
  assert day1_2.calc_next_token(#(50, 0), "L260") == #(90, 3)
  assert day1_2.calc_next_token(#(50, 0), "R30") == #(80, 0)
  assert day1_2.calc_next_token(#(50, 0), "R60") == #(10, 1)
  assert day1_2.calc_next_token(#(50, 0), "R360") == #(10, 4)
  assert day1_2.calc_next_token(#(0, 0), "L10") == #(90, 0)
  assert day1_2.calc_next_token(#(50, 0), "L68") == #(82, 1)
  assert day1_2.calc_next_token(#(82, 0), "L30") == #(52, 0)
  assert day1_2.calc_next_token(#(52, 0), "R48") == #(0, 1)
  assert day1_2.calc_next_token(#(0, 0), "L5") == #(95, 0)
  assert day1_2.calc_next_token(#(95, 0), "R60") == #(55, 1)
  assert day1_2.calc_next_token(#(55, 0), "L55") == #(0, 1)
  assert day1_2.calc_next_token(#(0, 0), "L1") == #(99, 0)
  assert day1_2.calc_next_token(#(99, 0), "L99") == #(0, 1)
  assert day1_2.calc_next_token(#(0, 0), "R14") == #(14, 0)
  assert day1_2.calc_next_token(#(14, 0), "L82") == #(32, 1)
}
