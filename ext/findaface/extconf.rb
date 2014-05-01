require 'mkmf'

opencv_headers = ["opencv2/objdetect/objdetect.hpp", "opencv2/highgui/highgui.hpp", "opencv2/imgproc/imgproc_c.h", ]
opencv_libraries = ["opencv_core", "opencv_highgui", "opencv_objdetect"]
opencv_libraries.each { |lib| raise "#{lib} not found." unless have_library(lib) }
opencv_headers.each { |header| raise "#{header} not found." unless have_header(header) }

#Call this if we ever create a propper c-extention instead of a cli
#create_makefile('findaface')
