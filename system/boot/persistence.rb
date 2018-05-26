Ledger::App.boot :persistence, namespace: true do |app|
  init do
    require 'sequel'
    require 'rom'
    require 'rom/sql'

    use :settings

    Sequel.database_timezone = :utc
    Sequel.application_timezone = :utc

    rom_config = ROM::Configuration.new(
      :sql,
      app[:settings].database_url
    )

    rom_config.plugin :sql, relations: :auto_restrictions
    rom_config.auto_registration app.root.join('lib/persistence')

    register 'config', rom_config
    register 'db', rom_config.gateways[:default].connection
  end

  start do
    config = container['persistence.config']

    register 'rom', ROM.container(config)
  end
end
