PROJECT = pygqrx

OBJECTS += freqctrl.o
OBJECTS += meter.o
OBJECTS += plotter.o
OBJECTS += bookmarks.o
OBJECTS += bookmarkstablemodel.o
OBJECTS += bookmarkstaglist.o

HFILES = $(OFILES:.o=.h)

MOC_OBJECTS += moc_freqctrl.o
MOC_OBJECTS += moc_meter.o
MOC_OBJECTS += moc_plotter.o
MOC_OBJECTS += moc_bookmarks.o
MOC_OBJECTS += moc_bookmarkstablemodel.o
MOC_OBJECTS += moc_bookmarkstaglist.o

SIP_OBJECTS += sippygqrxCFreqCtrl.o
SIP_OBJECTS += sippygqrxCMeter.o
SIP_OBJECTS += sippygqrxcmodule.o
SIP_OBJECTS += sippygqrxCPlotter.o

SIP_HFILES = sipAPIpygqrx.h

QT_MODULES = Qt5Core Qt5Widgets

CPPFLAGS  = -Wall -std=c++14 -fPIC -mtune=generic -O2 -fstack-protector-strong
CPPFLAGS += -I. -I/usr/include/python2.7
CPPFLAGS += $(shell pkg-config --cflags $(QT_MODULES)) 

LDFLAGS = -shared -Wl,-O1,--sort-common,--as-needed,-z,relro $(shell pkg-config --libs $(QT_MODULES))

all: $(PROJECT).so

$(PROJECT).so: $(OBJECTS) $(MOC_OBJECTS) $(SIP_OBJECTS)
	g++ -o $@ $(OBJECTS) $(MOC_OBJECTS) $(SIP_OBJECTS) $(LDFLAGS)

$(SIP_OBJECTS:.o=.cpp) $(SIP_HFILES): configure.py
	python2 configure.py

moc_%.cpp: %.h
	moc $< -o $@

%.o: %.cpp
	g++ $(CPPFLAGS) -c $< -o $@

clean:
	rm -f $(PROJECT).so
	rm -f $(OBJECTS)
	rm -f $(MOC_OBJECTS)
	rm -f $(MOC_OBJECTS:.o=.cpp)
	rm -f $(SIP_OBJECTS)
	rm -f $(SIP_OBJECTS:.o=.cpp)
	rm -f $(SIP_HFILES)

.PHONY: clean
