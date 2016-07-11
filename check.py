#!/usr/bin/env python

import sys
import os

REPO_DIR = os.path.abspath(os.path.dirname(__file__))

if __name__ == '__main__':
    import nose

    print "Using Python %s" % sys.version[0:3]
    print "Using nose %s" % nose.__version__[0:3]
    print "Running tests against: %s" % REPO_DIR

    nose.main()
