defmodule GenstageExample.Consumer do
  use GenStage

  def start_link(_initial) do
    GenStage.start_link(__MODULE__, :state_doesnt_matter)
  end

  def init(state) do
    {:consumer, state, subscribe_to: [GenstageExample.ProducerConsumer]}
  end

  def handle_events(events, _from, state) do
    :timer.sleep 20000
    for event <- events do
      IO.inspect({self(), "consumer consumed "})
      IO.inspect({self(), event, state})
    end
    # As a consumer we never emit events
    {:noreply, [], state}
  end
end
