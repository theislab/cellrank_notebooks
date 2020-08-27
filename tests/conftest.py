# -*- coding: utf-8 -*-
import pytest


def pytest_addoption(parser):
    parser.addoption(
        "--regenerate",
        action="store_true",
        help="Whether to regenerate notebooks after successful run.",
    )


@pytest.fixture
def regenerate(request):
    return request.config.getoption("--regenerate")
