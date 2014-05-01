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

  it "returns false for group photos" do
    Dir['spec/test_photos/many_faces/*'].each do |path|
      Findaface.has_face?(path).should be_false
    end
  end

  it "returns false for photos with small faces" do
    Dir['spec/test_photos/small_faces/*'].each do |path|
      Findaface.has_face?(path).should be_false if path == 'spec/test_photos/small_faces/small.jpg'
    end
  end
end
