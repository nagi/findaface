require_relative '../lib/findaface.rb'

describe Findaface, "has_face?" do

  it "finds faces" do
    Dir['spec/test_photos/has_face/*'].each do |path|
      Findaface.has_face?(path).should be_true
    end
  end

  it "doesn't give false positives" do
    Dir['spec/test_photos/no_face/*'].each do |path|
      Findaface.has_face?(path).should be_false
    end
  end

  it "returns false for photos with small faces" do
    Dir['spec/test_photos/small_faces/*'].each do |path|
      Findaface.has_face?(path).should be_false
    end
  end

	context "with multiple cascades" do
		it "can detect a nose, eye, and face" do
			Findaface.add_cascade(
				{
					cascade:'haarcascades/haarcascade_mcs_nose.xml',
					fussyness:7,
					scale_factor: 1.044,
					min_size: 100,
			  }
			)
			Findaface.add_cascade(
				{
					cascade:'haarcascades/haarcascade_eye.xml',
					fussyness:7,
					scale_factor: 1.05,
					min_size: 100,
			  }
			)
			Findaface.add_cascade(
				{
					cascade:'haarcascades/haarcascade_frontalface_detault.xml',
					fussyness:7,
					scale_factor: 1.05,
					min_size: 100,
			  }
			)
			Dir['spec/test_photos/eye_nose_face/*'].each do |path|
				Findaface.has_face?(path).should be_true
			end
		end
	end
end
