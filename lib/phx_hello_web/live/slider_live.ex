defmodule PhxHelloWeb.SliderLive do
  use PhxHelloWeb, :live_view
  require Logger

  def mount(_params, _session, socket) do
    Logger.info("\nmount\n")
    if connected?(socket) do
      Logger.info("connected")
      PhxHelloWeb.Endpoint.subscribe("slider:lobby")
    end
    s = socket |> assign(:value, 0) |> assign(:second, "100")

    {:ok, s}
  end

  def render(assigns) do
    ~H"""
    <%!-- basic form --%>
    <h1><%= @value %></h1>
    <table>
      <thead>
        <tr>
          <th>Value</th>
          <th>Second</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td><%= @value %></td>
          <td><%= @second %></td>
        </tr>
      </tbody>
    </table>
    <br/>
    <form phx-submit="submit" phx-change="update">
      <input type="range" min="0" max="100" name="value" value={@value} />
    </form>
    <br/>
    <br/>
    <br/>
    <br/>
    <h1><%= @second %></h1>
    <form phx-submit="submit" phx-change="update_second">
      <input type="range" min="0" max="100" name="value" value={@second} />
    </form>
    """
  end

  def handle_info(%{event: "input_change", payload: value}, socket) do
    {:noreply, assign(socket, :value, value)}
  end

  def handle_info(%{event: "second_input_change", payload: value}, socket) do
    {:noreply, assign(socket, :second, value)}
  end

  def handle_event("update", %{"value" => value}, socket) do
    PhxHelloWeb.Endpoint.broadcast("slider:lobby", "input_change", value)

    {:noreply, socket}
  end

  def handle_event("update_second", %{"value" => value}, socket) do
    PhxHelloWeb.Endpoint.broadcast("slider:lobby", "second_input_change", value)

    {:noreply, socket}
  end
end
