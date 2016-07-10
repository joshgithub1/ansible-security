#!/usr/bin/envpython

import unittest
import pep8
import os
from unit.fixture import CleanerBotTestFixture, REPO_DIR


class TestPep8(CleanerBotTestFixture):
    def test_conformance(self):
        # http://pep8.readthedocs.org/en/latest/intro.html#error-codes
        tests = [
            'E1',    # indentation
            'E2',    # whitespace errors
            'E3',    # blank line errors
            'E4',    # import errors
            'E5',    # line length
            'E7',    # statement errors
            'E9',    # runtime errors (SyntaxError, IndentationError, IOError)
            'W1',    # indentation warnings
            'W2',    # whitespace warnings
            'W3',    # blank line warnings
            'W5',    # line break warnings
            'W6',    # deprecated features
        ]

        checker = pep8.StyleGuide(
            select=tests, paths=[REPO_DIR],
            reporter=pep8.StandardReport
        )
        report = checker.check_files()
        result = report.total_errors
        output = "\n".join(report.get_statistics())

        if result != 0:
            self.fail("Found PEP8 errors:\n%s" % output)
