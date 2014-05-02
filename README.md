# Findaface

When given a path to a picture, this gem attempts to determins whether it contains
a single face and thus might be appropriate for a profile image, ID Card etc.

It is a modified then gemified version of George Ogata's [find-face](https://github.com/howaboutwe/find-face).

If you want a CLI that indicates where the biggest face in an image is, then use [find-face](https://github.com/howaboutwe/find-face).
If you want a ruby gem that indicates whether an image contains a single face, use this.

## Installation

There are two steps:

1. Install OpenCV
2. Install the Findaface gem

### Install OpenCV

For Mac:

```sh
brew tap homebrew/science
brew install opencv
```

For Linux (Debian/Ubuntu):

```sh
apt-get install libopencv-dev
```

Linux servers don't have a camera, so you might want to fake the device to suppress the warning:

```sh
touch /dev/raw1394
```

### Install the Findaface gem

Add this line to your application's Gemfile:

```ruby
gem 'findaface'
```

Or install it yourself as:

```sh
$ gem install findaface
```

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
