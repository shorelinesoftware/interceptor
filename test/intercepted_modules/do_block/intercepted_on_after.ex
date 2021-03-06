defmodule After.Callback do
  def right_after({_module, _function, _args} = mfa, result) do
    Agent.update(:after_test_process,
      fn messages ->
        [{Interceptor.Utils.timestamp(), result, mfa} | messages]
      end)
    "Doesn't influence the function at all"
  end
end

defmodule InterceptedOnAfter1 do
  require Interceptor, as: I

  I.intercept do
    def to_intercept(), do: Interceptor.Utils.timestamp()
  end
end

defmodule InterceptedOnAfter2 do
  require Interceptor, as: I

  I.intercept do
    def to_intercept(), do: Interceptor.Utils.timestamp()
    def other_to_intercept(), do: "HELLO"

    IO.puts("This statement doesn't interfere in any way")
  end
end

defmodule InterceptedOnAfter3 do
  require Interceptor, as: I

  I.intercept do
    def not_to_intercept(), do: Interceptor.Utils.timestamp()
    def other_to_intercept(w), do: w + private_function(1, 2, 3)

    defp private_function(x, y, z), do: x+y+z
  end
end

defmodule InterceptedOnAfter4 do
  require Interceptor, as: I

  I.intercept do
    def to_intercept_guarded(arg) when is_atom(arg), do: "ATOM #{arg}"
    def to_intercept_guarded(arg), do: "SOMETHING ELSE #{arg}"
  end
end

defmodule InterceptedOnAfter5 do
  require Interceptor, as: I

  I.intercept do
    def it_has_threes(3) do
      "Has one three"
    end

    def it_has_threes(33), do: "Has two threes"

    def its_abc("abc"), do: true

    def its_abc(_else), do: false

    def something(%{abc: xyz}) do
      "something #{xyz}"
    end
  end
end
