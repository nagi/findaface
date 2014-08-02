require_relative '../lib/findaface.rb'

describe Findaface, "has_face?" do

  let(:face) { 'spec/photos/face.jpg' }
  let(:eye) { 'spec/photos/eye.jpg' }
  let(:nose) { 'spec/photos/nose.jpg' }
  let(:fruit) { 'spec/photos/fruit.jpg' }

  it "finds faces" do
    Findaface.new.has_face?(face).should be_true
  end

  it "doesn't give false positives" do
    Findaface.new.has_face?(eye).should_not be_true
  end

  context "with custom cascade options" do
    before :each do
      @nose_detecter = Findaface.new
      @nose_detecter.add_cascade({
        cascade:'haarcascades/haarcascade_mcs_nose.xml',
        fussyness: 7,
        scale_factor: 1.05,
        min_size: 80,
        max_size: 512,
      })
    end

    it "finds a nose" do
      @nose_detecter.has_face?(nose).should be_true
    end

    it "doesn't give false positives" do
      @nose_detecter.has_face?(eye).should_not be_true
    end
  end

  context "with multiple cascades" do
    it "can detect a nose, eye, and face" do
      findaface = Findaface.new
      findaface.add_cascade(
        {
        cascade:'haarcascades/haarcascade_eye.xml',
        fussyness: 8,
        scale_factor: 1.05,
        min_size: 100,
        max_size: 512,
      })
      findaface.add_cascade({
        cascade:'haarcascades/haarcascade_mcs_nose.xml',
        fussyness: 8,
        scale_factor: 1.044,
        min_size: 100,
        max_size: 512,
      })
      findaface.add_cascade(
        {
        cascade:'haarcascades/haarcascade_frontalface_alt2.xml',
        fussyness: 8,
        scale_factor: 1.05,
        min_size: 100,
        max_size: 512,
      })
      [eye, nose, face].each do |path|
        findaface.has_face?(path).should be_true
      end
    end
  end
end
