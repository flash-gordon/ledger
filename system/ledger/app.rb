require 'dry/system/container'
require 'dry/system/components'

module Ledger
  class App < Dry::System::Container
    use :env, inferrer: -> { ENV.fetch('APP_ENV', 'development').to_sym }

    load_paths! 'lib', 'app'
  end
end
