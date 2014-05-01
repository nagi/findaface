# Findaface

When given a path to a picture, this gem attempts to determins whether it contains
a single face and thus might be appropriate for a profile image, ID Card etc.

It is a modified then gemified version of George Ogata's [find-face](https://github.com/howaboutwe/find-face).

If you want a CLI that indicates where the biggest face in an image is, then use [find-face](https://github.com/howaboutwe/find-face).
If you want a ruby gem that indicates whether an image contains a single face, use this.

## Installation

Add this line to your application's Gemfile:

    gem 'findaface'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install findaface

## Usage

```
puts Findaface.has_face?('path/to/me.jpg')
=> true
puts Findaface.has_face?('path/to/me_in_a_group.jpg')
=> false
puts Findaface.has_face?('path/to/my_cat.jpg')
=> false
```

## Contributing

1. Fork it ( http://github.com/<my-github-username>/findaface/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Thanks
OpenCV & George Ogata
