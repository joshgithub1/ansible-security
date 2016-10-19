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
        """
        Function calls class method function to find python files in repo dir
        """
        print
        print
        print "Testing in: %s" % REPO_DIR
        print
        self.files = self.find_py_files(REPO_DIR)

    @classmethod
    def find_py_files(cls, dirname):
        """
        Function iterates through files in dirs to find python files
        """
        pyfiles = []
        for root, _dirs, files in os.walk(dirname):
            for name in files:
                if name.endswith('.py') and not name.startswith('tutorial'):
                    pyfiles.append(os.path.join(root, name))
        return pyfiles
