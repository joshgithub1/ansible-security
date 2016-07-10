#!/usr/bin/envpython

import flake8.main
import os
from unit.fixture import CleanerBotTestFixture, REPO_DIR


class TestFlake8(CleanerBotTestFixture):
    def setUp(self):
        self.files = self.find_py_files(REPO_DIR)

    def test_flake8(self):
        style_guide = flake8.main.get_style_guide(paths=self.files)
        report = style_guide.check_files()

        if report.total_errors != 0:
            output = "\n".join(report.get_statistics())
            self.fail(output)

    def find_py_files(self, dirname):
        pyfiles = []
        for root, dirs, files in os.walk(dirname):
            for file in files:
                if file.endswith('.py'):
                    pyfiles.append(os.path.join(root, file))
        return pyfiles
