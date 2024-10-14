import gleam/io
import gleam/result
import tempo/datetime

pub fn main() {
  let dt_result = datetime.parse_any("12-10-2024T00:00:00Z")
  // this shows Error(ParseMissingOffset) even though the above string has an
  // offset (Z)
  let _ = io.debug(dt_result)

  let dt_result = datetime.parse_any("12-10-2024T00:00:00+00:00")
  // this shows Error(ParseMissingTime) on javascript target even though the
  // above string definitely has a time. This one works fine on BEAM, only the
  // js target fails
  let _ = io.debug(dt_result)

  datetime.literal("2024-06-13T23:04:00.009+10:00")
  // this panics on javascript. Fine on BEAM
  |> datetime.format("ddd @ h:mm A (z)")
  |> io.debug

  use dt <- result.try(dt_result)
  // never reaches this on js because of use short circuit
  io.debug(datetime.format(dt, "ddd @ h:mm A (z)"))
  Ok(Nil)
}
