ALL_CPPFLAGS = $(CPPFLAGS) $(shell pkg-config opencv --cflags)
ALL_CXXFLAGS = $(CXXFLAGS) -Wall
ALL_LDFLAGS = $(shell pkg-config opencv --libs)

findaface: findaface.cc Makefile
		$(CXX) $(ALL_CXXFLAGS) $(ALL_CPPFLAGS) $< $(ALL_LDFLAGS) -o $@
