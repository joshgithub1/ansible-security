#!/usr/bin/envpython

import flake8.main
import flake8.api.legacy
from unit.fixture import CleanerBotTestFixture


class TestFlake8(CleanerBotTestFixture):
    def test_flake8(self):
        style_guide = flake8.api.legacy.get_style_guide(paths=self.files)
        report = style_guide.check_files()

        if report.total_errors != 0:
            output = "\n".join(report.get_statistics(report))
            self.fail(output)
