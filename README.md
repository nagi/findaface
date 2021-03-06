# Findaface

When given a path to a picture, this gem attempts to determins whether it contains any faces and thus might be appropriate for a profile image. It is looking for faces bigger than 80 pixels squared.

It is a modified then gemified version of George Ogata's [find-face](https://github.com/howaboutwe/find-face). If you want a CLI that indicates where the biggest face in an image is, then use the original.

This gem simply compiles an executable to detect a face then calls it externally, so you won't have to include the humongous OpenCV library into your Ruby process, which can cause a memory leaks / bloat or even a crash. This is what [Paperclip](https://github.com/thoughtbot/paperclip) does for ImageMagick. We also support [posix-spawn](https://github.com/rtomayko/posix-spawn) to mitigate the overhead of fork-exec.

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
puts Findaface.new.has_face?('path/to/me.jpg')
=> true
puts Findaface.new.has_face?('path/to/me_in_a_group.jpg')
=> true
puts Findaface.new.has_face?('path/to/my_cat.jpg')
=> false
```

### Customizing the casscade
Those who need to detect something other than a face can use a different cascade.

```
Findaface.add_cascade(
  {
    cascade:'haarcascades/haarcascade_upperbody.xml',
    fussyness:7,
    scale_factor: 1.05,
    min_size: 100,
    max_size: 512,
	}
)
```

* cascade: A trained classifiers for detecting objects of a particular type
* fussyness: How good a match is required.
* scale_factor: Parameter specifying how much the image size is reduced at each image scale.
Basically the scale factor is used to create your scale pyramid. More explanation can be found
[here](https://sites.google.com/site/5kk73gpu2012/assignment/viola-jones-face-detection#TOC-Image-Pyramid).
* min_size: In pixels. Objects smaller than this size squared are ignored.
* max_size: Objects bigger than this are ignored.

### Using multiple cascades
If you add multiple cascades then they will be applied in turn. If any of the cascades match, then findaface returns true. You should add cascades before the first call to `has_face?` (unless you also want the default cascade to be applied).
```
findaface = Findaface.new
findaface.add_cascade(
  {
    cascade:'haarcascades/haarcascade_mcs_nose.xml',
    fussyness:6,
    scale_factor: 1.05,
    min_size: 100,
    max_size: 512,
	}
)
findaface.add_cascade(
  {
    cascade:'haarcascades/haarcascade_eye.xml',
    fussyness:6,
    scale_factor: 1.05,
    min_size: 100,
    max_size: 512,
  }
)

puts findaface.has_face?('path/to/nose.jpg')
=> true
puts findaface.has_face?('path/to/eye.jpg')
=> true
puts findaface.has_face?('path/to/mouth.jpg')
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
