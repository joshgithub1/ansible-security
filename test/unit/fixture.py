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
