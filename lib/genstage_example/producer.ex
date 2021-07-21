defmodule GenstageExample.Producer do
  use GenStage

  def start_link(initial \\ 0) do
    GenStage.start_link(__MODULE__, initial, name: __MODULE__)
  end

  def init(counter), do: {:producer, counter}

  def handle_demand(demand, state) do
    :timer.sleep 5000
    events = Enum.to_list(state..(state + demand - 1))
    for event <- events do
      IO.inspect({self(), "producer produced with demand ", demand})
      IO.inspect({self(), event, state})
    end
    {:noreply, events, state + demand}
  end
end
