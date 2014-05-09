#include "opencv2/objdetect/objdetect.hpp"
#include "opencv2/highgui/highgui.hpp"
#include "opencv2/imgproc/imgproc.hpp"

#include <iostream>
#include <fstream>
#include <string>
#include <vector>

using namespace cv;

#define USAGE "USAGE: findaface --cascade=PATH.xml [--fussyness=integer] [--scale_factor=1.05] [--min_size=pixels] [--max-size=pixels] [ --resize=SCALE ] IMAGE"

int main(int argc, const char** argv)
{
  std::string cascade_name;
  // This allows you to scale down an image before attemping face detection (to speed things up).
  std::string reSize;
  // This parameter will affect the quality of the detected faces. Higher value results in less
  // detections but with higher quality. 3~6 is a good value for it.
  std::string fussyness;
  // This is the percentate that the image will be scaled up on each iteration of the algorithm
  // to detect smaller faces (1.05 works well). It makes the program slower when this is smaller.
  std::string scale_factor;
  // The minimum size (in pixels) of a detected feature. High values speed up detection
  std::string min_size;
  // The maximum size (in pixels) of a detected feature.
  std::string max_size;
  // Path to image
  std::string input_name;

  int fussyness_number = 3;
  double scale_factor_number = 1.05;
  double resize_number = 1;
  int min_size_number = 80;
  int max_size_number = 2048;

  CascadeClassifier cascade;

  const std::string help_opt = "--help";
  const std::string resize_opt = "--resize=";
  const std::string fussyness_opt = "--fussyness=";
  const std::string scale_factor_opt = "--scale_factor=";
  const std::string min_size_opt = "--min_size=";
  const std::string max_size_opt = "--max_size=";
  const std::string cascade_opt = "--cascade=";

  for (int i = 1; i < argc; i++) {
    if (cascade_opt.compare(0, cascade_opt.length(), argv[i], cascade_opt.length()) == 0) {
      cascade_name.assign(argv[i] + cascade_opt.length());
    } else if (resize_opt.compare(0, resize_opt.length(), argv[i], resize_opt.length()) == 0) {
      reSize.assign(argv[i] + resize_opt.length());
      resize_number = atof(reSize.c_str());
      if (resize_number < 1) resize_number = 1;
    } else if (fussyness_opt.compare(0, fussyness_opt.length(), argv[i], fussyness_opt.length()) == 0) {
      fussyness.assign(argv[i] + fussyness_opt.length());
      fussyness_number = atoi(fussyness.c_str());
    } else if (scale_factor_opt.compare(0, scale_factor_opt.length(), argv[i], scale_factor_opt.length()) == 0) {
      scale_factor.assign(argv[i] + scale_factor_opt.length());
      scale_factor_number = atof(scale_factor.c_str());
    } else if (min_size_opt.compare(0, min_size_opt.length(), argv[i], min_size_opt.length()) == 0) {
      min_size.assign(argv[i] + min_size_opt.length());
      min_size_number = atoi(min_size.c_str());
    } else if (max_size_opt.compare(0, max_size_opt.length(), argv[i], max_size_opt.length()) == 0) {
      max_size.assign(argv[i] + max_size_opt.length());
      max_size_number = atoi(max_size.c_str());
    } else if (help_opt == argv[i]) {
      std::cout << USAGE << std::endl;
      return 0;
    } else {
      input_name.assign(argv[i]);
    }
  }

  if (cascade_name.empty()) {
    std::cerr << "ERROR: --cascade=PATH argument required" << std::endl;
    return -1;
  }

  if (!cascade.load(cascade_name)) {
    std::cerr << "ERROR: could not load classifier cascade: " << cascade_name << std::endl;
    return -1;
  }

  if (input_name.empty()) {
    std::cerr << "ERROR: image name required" << std::endl;
    return -1;
  }

  if (fussyness_number < 0) {
    std::cerr << "ERROR: fussyness must be positive integer. 2 to 7 are sensible trys." << std::endl;
    return -1;
  }

  if (min_size_number < 0) {
    std::cerr << "ERROR: min_size must be positive integer" << std::endl;
    return -1;
  }

  if (max_size_number < 0 || max_size_number <= min_size_number) {
    std::cerr << "ERROR: max_size must be positive integer bigger than min_size" << std::endl;
    return -1;
  }

  if (scale_factor_number <= 1 || scale_factor_number >= 1.5) {
    std::cerr << "ERROR: scale_factor should be around 1.05 (5%)" << std::endl;
    return -1;
  }

  std::ifstream file(input_name.c_str());
  if (!file.good()) {
    std::cerr << "file not found or not readable: " << input_name << std::endl;
    return -1;
  }

  Mat image = imread(input_name, 1);
  if (!image.empty()) {
    Mat gray, small_image(cvRound(image.rows/resize_number), cvRound(image.cols/resize_number), CV_8UC1);
    cvtColor(image, gray, CV_BGR2GRAY);
    resize(gray, small_image, small_image.size(), 0, 0, INTER_LINEAR);
    equalizeHist(small_image, small_image);

    std::vector<Rect> faces;

    cascade.detectMultiScale(small_image, faces, scale_factor_number, fussyness_number, 0,
				Size(min_size_number, min_size_number), Size(max_size_number, max_size_number));

    std::cout << faces.size() << "\tface(s) found\n";
    if(faces.size() >= 1) {
      return 0;
    } else {
      return 1;
    }
  }
  return 1; //should be unreachable
}
