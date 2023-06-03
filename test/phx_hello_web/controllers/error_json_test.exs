defmodule PhxHelloWeb.ErrorJSONTest do
  use PhxHelloWeb.ConnCase, async: true

  test "renders 404" do
    assert PhxHelloWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert PhxHelloWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
