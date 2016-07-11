#!/usr/bin/envpython

import flake8.main
from unit.fixture import CleanerBotTestFixture


class TestFlake8(CleanerBotTestFixture):
    def test_flake8(self):
        style_guide = flake8.main.get_style_guide(paths=self.files)
        report = style_guide.check_files()

        if report.total_errors != 0:
            output = "\n".join(report.get_statistics())
            self.fail(output)
