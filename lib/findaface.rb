require "findaface/version"
require "opencv"

module Findaface
  def self.has_face?(path)
    include OpenCV

    config = File.join(File.dirname(File.expand_path(__FILE__)),
                       '../lib/haarcascades/haarcascade_frontalface_alt.xml')
    detector = CvHaarClassifierCascade::load(config)
    image = IplImage::load(path)
    return detector.detect_objects(image).length == 1
  end
end
