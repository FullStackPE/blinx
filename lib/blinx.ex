defmodule Blinx do
  @moduledoc """
  Documentation for Blinx.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Blinx.hello
      :world

  """
  def hello do
    :world
  end

  # Blinx.pid() |> Blinx.loop(200)

  # Blinx.main(200)
  def main(timeout) do
   spawn fn -> pid() |> loop(timeout) end 
  end
  
  #def listen do
  #  receive do 
  #    {:t, timeout} ->
  #      Process.exit(c, :kill)
  #      main(timeout)
  #  end
  #end

  def loop(pid, timeout) do
      pid 
	|> start() 
	|> sleep(timeout)
	|> stop()
	|> sleep(timeout)
	|> loop(timeout)
  end

  def sleep(pid, time) do
    :timer.sleep(time)
    pid 
  end

  def pid do
    {:ok, pid} = Gpio.start_link(4, :output)
    pid
  end
  
  def start(pid) do
    Gpio.write(pid, 1)
    pid
  end

  def stop(pid) do
    Gpio.write(pid, 0)
    pid
  end
end
