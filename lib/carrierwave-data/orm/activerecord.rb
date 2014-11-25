# encoding: utf-8

module CarrierWave
  module ActiveRecord
    module Data
      # See +CarrierWave::Mount#mount_uploader+ for documentation
      def mount_uploader(column, uploader = nil, options = {}, &block)
        super
        
        attr_writer :"#{column}_data"
        
        before_validation :"decode_#{column}_data", if: :"#{column}_data?"
        
        class_eval <<-RUBY, __FILE__, __LINE__+1
          def #{column}_data?
            !!@#{column}_data
          end
          
          def decoded_#{column}_filename
            SecureRandom.hex
          end
          
          def decoded_#{column}_extension
          end
          
        private
          
          def decode_#{column}_data
            file_filename  = decoded_#{column}_filename
            file_extension = decoded_#{column}_extension
            
            if @#{column}_data.is_a?(Hash)
              file_filename   = @#{column}_data[:name] || file_filename
              file_extension  = @#{column}_data[:ext]  || file_extension
              @#{column}_data = @#{column}_data[:data]
            end
            
            file = Tempfile.new('carrierwave-data')
            file.binmode
            file.write(Base64.decode64(@#{column}_data))
            
            filename = [file_filename, file_extension].compact.join('.')
            self.#{column} = ActionDispatch::Http::UploadedFile.new(tempfile: file, filename: filename)
          end
        RUBY
      end
    end # Data
  end # ActiveRecord
end # CarrierWave

ActiveRecord::Base.extend CarrierWave::ActiveRecord::Data
