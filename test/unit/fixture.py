import os
import unittest

UNIT_DIR = os.path.abspath(os.path.dirname(__file__))
REPO_DIR = os.path.join(UNIT_DIR, '..', '..')
REPO_DIR = os.path.abspath(REPO_DIR)


class CleanerBotTestFixture(unittest.TestCase):
    """
    Fixture providing setup/teardown and utilities for unit tests.
    """
    def setUp(self):
        print
        print
        print("Testing in: %s" % REPO_DIR)
        print
        self.files = self.find_py_files(REPO_DIR)

    def find_py_files(self, dirname):
        pyfiles = []
        for root, dirs, files in os.walk(dirname):
            for file in files:
                if file.endswith('.py'):
                    pyfiles.append(os.path.join(root, file))
        return pyfiles
