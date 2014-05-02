# Findaface

When given a path to a picture, this gem attempts to determins whether it contains a single face and thus might be appropriate for a profile image, ID Card etc.

It is a modified then gemified version of George Ogata's [find-face](https://github.com/howaboutwe/find-face). If you want a CLI that indicates where the biggest face in an image is, then use the original.

This gem simply compiles an executable to detect a face then calls it externally, so you won't have to include the humongous OpenCV library into your Ruby process, which can cause memory leak / bloat or even crash. This is what [Paperclip](https://github.com/thoughtbot/paperclip) does for ImageMagick. We also support [posix-spawn](https://github.com/rtomayko/posix-spawn) to mitigate the overhead of fork-exec.

## Installation

There are two steps:

1. Install OpenCV
2. Install Findaface

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

### Install Findaface

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
