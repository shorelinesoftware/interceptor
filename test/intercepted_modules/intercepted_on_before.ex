defmodule Before.Callback do
  def on_before({module, function, arity} = mfa) do
    Agent.update(:on_before_test_process,
      fn messages ->
        [{Interceptor.Utils.timestamp(), mfa} | messages]
      end)
    "Doesn't influence the function at all"
  end
end

defmodule InterceptedOnBefore1 do
  require Interceptor, as: I

  I.intercept do
    def to_intercept(), do: Interceptor.Utils.timestamp()
  end
end

defmodule InterceptedOnBefore2 do
  require Interceptor, as: I

  I.intercept do
    def to_intercept(), do: Interceptor.Utils.timestamp()
    def other_to_intercept(), do: "HELLO"

    IO.puts("This statement doesn't interfere in any way")
  end
end

defmodule InterceptedOnBefore3 do
  require Interceptor, as: I

  I.intercept do
    def not_to_intercept(), do: Interceptor.Utils.timestamp()
    def other_to_intercept(w), do: w + private_function(1, 2, 3)

    defp private_function(x, y, z), do: x+y+z
  end
end
