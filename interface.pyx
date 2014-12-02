from libcpp.string cimport string

from .test cimport main as c_main
from .test cimport Args as c_Args
from .test cimport square as c_square
from .test cimport inputstrings as c_inputstrings

import traceback


def main(args):
    cdef c_Args c_args
    c_args.thatnumber = args.thatnumber
    c_main(c_args)


cdef public void py_interact():
    try:
        from .prompt import interact
        interact()
    except:
        traceback.print_exc()


def square(unsigned number):
    return c_square(number)


cdef public void py_print_square(int thatnumber):
    print("square of {}: {}".format(thatnumber, c_square(thatnumber)))


def get_strings():
    for s in c_inputstrings:
        yield s


def append_string(s):
    c_inputstrings.push_back(s)


callbacks = []


cdef public string py_invoke_callbacks(string s):
    cdef string ret

    for cb in callbacks:
        try:
            ret = cb(s.decode()).encode()
            if ret.size():
                s = ret
        except:
            traceback.print_exc()

    return s
