from pathlib import Path


TUTORIALS = Path("tutorials").resolve()


def test_pancreas_basic(nb_regression):
    nb_regression.check(str(TUTORIALS / "pancreas_basic.ipynb"))


def est_pancreas_advanced(nb_regression):
    nb_regression.check(str(TUTORIALS / "pancreas_advanced.ipynb"))


