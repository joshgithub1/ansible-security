#!/usr/bin/envpython

import unittest
import pep8
import os
from unit.fixture import CleanerBotTestFixture, REPO_DIR


class TestPep8(CleanerBotTestFixture):
    def test_conformance(self):
        # http://pep8.readthedocs.org/en/latest/intro.html#error-codes
        tests = [
            'E112',  # expected an indented block
            'E113',  # unexpected indentation
            'E121',  # continuation line indentation is not a multiple of four
            'E122',  # continuation line missing indentation or outdented
            'E3',    # blank line errors
            'E4',    # import errors
            'E502',  # the backslash is redundant between brackets
            'E9',    # runtime errors (SyntaxError, IndentationError, IOError)
            'W2',    # whitespace warnings
            'W3',    # blank line warnings
            'W6',    # deprecated features
        ]

        checker = pep8.StyleGuide(select=tests, paths=[REPO_DIR], reporter=pep8.StandardReport)
        report = checker.check_files()
        result = report.total_errors
        output = "\n".join(report.get_statistics())

        if result != 0:
            self.fail("Found PEP8 errors:\n%s" % output)
