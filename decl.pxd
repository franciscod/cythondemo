from libcpp.vector cimport vector
from libcpp.string cimport string
from cpython.ref cimport PyObject


cdef extern from "test.h" namespace "test":
    unsigned square(unsigned num)

    struct Args:
        int exit
        int exitcode
        int thatnumber

    vector[string] inputstrings
