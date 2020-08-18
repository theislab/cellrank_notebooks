# -*- coding: utf-8 -*-
import json  # noqa
import tempfile
from pathlib import Path
from typing import Callable

import nbformat
from jsonpath_ng import jsonpath  # noqa
from jsonpath_ng.ext import parse

TUTORIALS = Path("tutorials").resolve()
SENTINEL = "SENTINEL REACHED"


def _inject_sentinel(nb) -> None:
    sentinel = nbformat.v4.new_code_cell(source=f"print({SENTINEL!r})")
    nb["cells"].append(sentinel)


def _assert_execute_sentinel(result) -> None:
    match = parse(
        f'$.[*].diff[*].diff[*].diff[*].valuelist[?(@.text = "{SENTINEL}\n")].text'
    )
    found = match.find(result.diff_filtered)

    if not found:
        raise RuntimeError(result.diff_string)


def test():
    def wrapper(func: Callable) -> Callable:
        def decorator(nb_regression) -> None:
            fpath = f"{(TUTORIALS / func.__name__[5:]).resolve()}.ipynb"

            nb = nbformat.read(fpath, as_version=4)
            _inject_sentinel(nb)

            with tempfile.NamedTemporaryFile("w", suffix=".ipynb") as tmpf:
                nbformat.write(nb, tmpf)
                tmpf.flush()
                result = nb_regression.check(tmpf.name, raise_errors=False)

            _assert_execute_sentinel(result)

        return decorator

    return wrapper


@test()
def test_pancreas_basic():
    pass


@test()
def test_pancreas_advanced():
    pass
