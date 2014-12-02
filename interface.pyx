from libcpp.string cimport string
from test cimport square as c_square
from test cimport Args as c_Args
from test cimport inputstrings as c_inputstrings


cdef public void py_interact():
    import pymod
    pymod.interact()


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
            ret = cb(s)
            if ret.size():
                s = ret
        except:
            import traceback
            print(traceback.format_exc())

    return s
