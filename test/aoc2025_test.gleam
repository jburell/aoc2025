import day1_2

//import day2_1
import day3_1
import day3_2
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

//pub fn day2_1_test() {
//  assert day2_1.calculate([["1", "8"]]) == 0
//  assert day2_1.calculate([["11", "22"]]) == 2
//  assert day2_1.calculate([["95", "115"]]) == 1
//  assert day2_1.calculate([["998", "1012"]]) == 1
//  assert day2_1.calculate([["1188511880", "1188511890"]]) == 1
//  assert day2_1.calculate([["222220", "222224"]]) == 1
//  assert day2_1.calculate([["1698522", "1698528"]]) == 0
//  assert day2_1.calculate([["446443", "446449"]]) == 1
//  assert day2_1.calculate([["38593856", "38593862"]]) == 1
//  // 11-22 has two invalid IDs, 11 and 22.
//  // 95-115 has one invalid ID, 99.
//  // 998-1012 has one invalid ID, 1010.
//  // 1188511880-1188511890 has one invalid ID, 1188511885.
//  // 222220-222224 has one invalid ID, 222222.
//  // 1698522-1698528 contains no invalid IDs.
//  // 446443-446449 has one invalid ID, 446446.
//  // 38593856-38593862 has one invalid ID, 38593859.  
//}

pub fn day3_1_test() {
  assert day3_1.calculate_row("987654321111111") == 98
  assert day3_1.calculate_row("811111111111119") == 89
  assert day3_1.calculate_row("234234234234278") == 78
  assert day3_1.calculate_row("818181911112111") == 92
}

pub fn day3_2_test() {
  assert day3_2.calculate_row("987654321111111") == 987_654_321_111
  assert day3_2.calculate_row("811111111111119") == 811_111_111_119
  assert day3_2.calculate_row("234234234234278") == 434_234_234_278
  assert day3_2.calculate_row("818181911112111") == 888_911_112_111
}
