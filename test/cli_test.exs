defmodule CliTest do
  use ExUnit.Case

  import Issues.CLI, only: [parse_args: 1]

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

end
