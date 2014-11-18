if defined?(Rails)
  module CarrierWave
    class Railtie < Rails::Railtie
      initializer 'carrierwave-data.active_record' do
        ActiveSupport.on_load :active_record do
          require 'carrierwave-data/orm/activerecord'
        end
      end
    end
  end
end

require 'carrierwave-data/version'
