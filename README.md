# CarrierWave::Data

Allows [CarrierWave](https://github.com/carrierwaveuploader/carrierwave) to process Base64 encoded file uploads.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'carrierwave-data'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install carrierwave-data

## Usage

Assuming you have a `User` model with a `UserAvatarUploader` mounted on an `avatar` attribute.

```ruby
class User < ActiveRecord::Base
  mount_uploader :avatar, UserAvatarUploader
end
```

A `User`'s `avatar` can be set using a Base64 encoded string, as follows.

```ruby
user = User.new
user.avatar_data = 'iVBORw0KGgoAAAANSUhEUgAAAGAAAABgCAIAAABuBvAAAABGdBTUE...kJggg=='
user.save
    
user.avatar? # => true
user.avatar  # => #<UserAvatarUploader:0x007f9575fddc18 @model=#<User id: 1, avatar: "2d45cced04356fcfac278ef06f76d567">, @mounted_as=:avatar, ...>
````

## Customizations

By default, the filename of the decoded uploaded file is set to a random hex string, using `SecureRandom.hex`. To customize this behaviour, override the `decoded_#{mounted_as}_filename` method on your model.

```ruby
class User < ActiveRecord::Base
  mount_uploader :avatar, UserAvatarUploader
  
  def decoded_avatar_filename
    'avatar'
  end
end
```

You can also customize the extension of the decoded uploaded file by overriding the `decoded_#{mounted_as}_extension` method. By default, no extension is set.

```ruby
class User < ActiveRecord::Base
  mount_uploader :avatar, UserAvatarUploader
    
  def decoded_avatar_extension
    :png
  end
end
```

## Contributing

1. Fork it ( https://github.com/RaMin0/carrierwave-data/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
