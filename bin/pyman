#!/usr/bin/env python

import sys

if len(sys.argv) is not 2:
    sys.stderr.write('Expected <python module name> as only argument\n')
    sys.exit(1)

module_parts = sys.argv[1].split('.')
module = __import__(module_parts[0])
help(sys.argv[1])
