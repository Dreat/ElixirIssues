defmodule CliTest do
  use ExUnit.Case

  import Issues.CLI, only: [parse_args: 1, sort_into_ascending_order: 1, convert_to_list_of_hashdics: 1]

  test ":help returned by parsing -h and --help" do
    assert parse_args(["-h", "anything"]) == :help
    assert parse_args(["--help", "anything"]) == :help
  end

  test "three values returned when three given" do
    assert parse_args(["user", "project", "25"]) == {"user", "project", 25}
  end

  test "returns default count when two values are given" do
    assert parse_args(["user", "project"]) == {"user", "project", 4}
  end


  test "sort ascending orders the correct way" do
    result = sort_into_ascending_order(fake_created_at_list(["c", "a", "b"]))
    issues = for issue <- result, do: issue["created_at"]
    assert issues == ~w{a b c}
  end

  defp fake_created_at_list(values) do
    data = for value <- values, do: [{"created_at", value}, {"other_data", "xxx"}]
    convert_to_list_of_hashdics data
  end

end
