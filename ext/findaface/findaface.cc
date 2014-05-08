#include "opencv2/objdetect/objdetect.hpp"
#include "opencv2/highgui/highgui.hpp"
#include "opencv2/imgproc/imgproc.hpp"

#include <iostream>
#include <fstream>
#include <string>
#include <vector>

using namespace cv;

#define USAGE "USAGE: findaface --cascade=PATH.xml [ --scale=SCALE ] IMAGE"

int main(int argc, const char** argv)
{
  std::string cascade_name;
  std::string input_name;
  CascadeClassifier cascade;
  double scale = 1;

  const std::string help_opt = "--help";
  const std::string scale_opt = "--scale=";
  const std::string cascade_opt = "--cascade=";

  for (int i = 1; i < argc; i++) {
    if (cascade_opt.compare(0, cascade_opt.length(), argv[i], cascade_opt.length()) == 0) {
      cascade_name.assign(argv[i] + cascade_opt.length());
    } else if (scale_opt.compare(0, scale_opt.length(), argv[i], scale_opt.length()) == 0) {
      std::istringstream arg(argv[i] + scale_opt.length());
      double scale;
      arg >> scale;
      if (scale < 1)
        scale = 1;
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

  std::ifstream file(input_name.c_str());
  if (!file.good()) {
    std::cerr << "file not found or not readable: " << input_name << std::endl;
    return -1;
  }

  Mat image = imread(input_name, 1);
  if (!image.empty()) {
    Mat gray, small_image(cvRound(image.rows/scale), cvRound(image.cols/scale), CV_8UC1);
    cvtColor(image, gray, CV_BGR2GRAY);
    resize(gray, small_image, small_image.size(), 0, 0, INTER_LINEAR);
    equalizeHist(small_image, small_image);

    std::vector<Rect> faces;

    // This parameter will affect the quality of the detected faces. Higher value results in less
    // detections but with higher quality. 3~6 is a good value for it.
    int fussyness = 2;
    cascade.detectMultiScale(small_image, faces, 1.05, fussyness, 0, Size(80, 80));

    std::cout << faces.size() << "\tface(s) found\n";

    if(faces.size() >= 1) {
      return 0;
    } else {
      return 1;
    }
  }
  return 1; //should be unreachable
}
