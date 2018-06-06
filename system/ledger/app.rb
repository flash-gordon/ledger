require 'dry/system/container'
require 'dry/system/components'

module Ledger
  class App < Dry::System::Container
    use :env, inferrer: -> { ENV.fetch('APP_ENV', 'development').to_sym }

    configure do |config|
      config.default_namespace = 'ledger'
      config.inflector = Dry::Inflector.new do |inflections|
        inflections.acronym('API')
      end
      config.auto_register = %w(lib app)
    end

    load_paths! 'lib', 'app'
  end

  Import = App.injector
  ArgsImport = Import.args
end
