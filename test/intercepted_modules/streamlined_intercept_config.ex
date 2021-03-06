defmodule StreamlinedInterceptConfig do
  use Interceptor.Configurator

  intercept "InterceptedOnBefore1.to_intercept/0",
    before: "Before.Callback.before/1"
  intercept "Bla.Ble.Bli.Module.Name.Big.TooBig.to_intercept/0",
    after: "After.Callback.right_after/2"
end


defmodule StreamlinedInterceptConfig2 do
  use Interceptor.Configurator

  intercept "InterceptedOnBefore1.to_intercept/0",
    before: "Before.Callback.before/1",
    after: "After.Callback.right_after/2",
    on_success: "Success.Callback.if_everything_ok/3",
    on_error: "Error.Callback.if_borked/3"
end


defmodule StreamlinedInterceptConfigMixedFormat do
  use Interceptor.Configurator

  intercept "InterceptedOnBefore1.to_intercept/0",
    before: "Before.Callback.before/1",
    after: "After.Callback.right_after/2",
    on_success: "Success.Callback.if_everything_ok/3",
    on_error: "Error.Callback.if_borked/3"
end


defmodule StreamlinedInterceptConfigMixedFormat2 do
  use Interceptor.Configurator

  intercept {InterceptedOnBefore1, :to_intercept, 0},
    before: "Before.Callback.before/1",
    after: {After.Callback, :right_after, 2},
    on_success: "Success.Callback.if_everything_ok/3",
    on_error: {Error.Callback, :if_borked, 3}
end

defmodule StreamlinedInterceptConfigWildcarded do
  use Interceptor.Configurator

  intercept "InterceptedOnBefore1.*/*",
    before: "Before.Callback.before/1",
    after: {After.Callback, :right_after, 2},
    on_success: "Success.Callback.if_everything_ok/3",
    on_error: {Error.Callback, :if_borked, 3}

  intercept "InterceptedOnBefore1.some_function/*",
    before: "Before.Callback.before/1",
    after: {After.Callback, :right_after, 2},
    on_success: "Success.Callback.if_everything_ok/3",
    on_error: {Error.Callback, :if_borked, 3}
end

defmodule StreamlinedInterceptConfigBad do
  use Interceptor.Configurator

  intercept "InterceptedOnBefore1.to_intercept/0",
    before: "A B C D E F G H I J K L M N O P Q R S T U V"
end

defmodule StreamlinedInterceptConfigWildcardedCallbacks1 do
  use Interceptor.Configurator

  intercept "InterceptedOnBefore1.to_intercept/0",
    before: "Kaboom.function/*"
end

defmodule StreamlinedInterceptConfigWildcardedCallbacks2 do
  use Interceptor.Configurator

  intercept "InterceptedOnBefore1.to_intercept/0",
    after: "Kaboom.*/*"
end

defmodule StreamlinedInterceptConfigWildcardedCallbacks3 do
  use Interceptor.Configurator

  intercept "InterceptedOnBefore1.to_intercept/0",
    after: {Kaboom, :function, :*}
end

defmodule StreamlinedInterceptConfigWildcardedCallbacks4 do
  use Interceptor.Configurator

  intercept "InterceptedOnBefore1.to_intercept/0",
    after: {Kaboom, :*, :*}
end
