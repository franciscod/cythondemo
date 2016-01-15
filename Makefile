PYTHON=python3.4m
PYTHONLIBDIR=/usr/lib/x86_64-gnu
PYTHONINCDIR=/usr/include/$(PYTHON)
CXX=g++
CXXFLAGS=-std=c++11 -Wall -Wextra -pedantic -fPIC -O1 -g -I$(PYTHONINCDIR)
LDFLAGS=--shared
MODLDFLAGS=
CYTHON=cython
CYTHONFLAGS=--gdb --cplus -3 --fast-fail
PXDGEN=python3 pxdgen.py

.PHONY: all
all: libtest.so if_math.so if_main.so if_strings.so

# pure c++ files
%.o: %.cpp main.h py_functions.h
	$(CXX) $(CXXFLAGS) -c $< -o $@

libtest.so: main.o py_functions.o
	$(CXX) $(CXXFLAGS) $(LDFLAGS) $^ -o $@

# cython files

%.pxd: %.h
	$(PXDGEN) $< -o $@

%.so: %.o libtest.so
	$(CXX) $(CXXFLAGS) $(LDFLAGS) $^ -o $@ $(MODLDFLAGS)

if_%.cpp: if_%.pyx main.pxd py_functions.pxd
	$(CYTHON) $(CYTHONFLAGS) $<


.PHONY: clean
clean:
	rm -rf if_*.cpp *.o *.so *.pxd cython_debug
