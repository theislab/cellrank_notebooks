# -*- coding: utf-8 -*-
from pathlib import Path
import sys

HERE = Path(__file__).parent
sys.path.insert(0, str(HERE.parent.parent))

# Configuration file for the Sphinx documentation builder.
#
# This file only contains a selection of the most common options. For a full
# list see the documentation:
# https://www.sphinx-doc.org/en/master/usage/configuration.html

# -- Path setup --------------------------------------------------------------

# If extensions (or modules to document with autodoc) are in another directory,
# add these directories to sys.path here. If the directory is relative to the
# documentation root, use os.path.abspath to make it absolute, like shown here.
#
# import os
# import sys
# sys.path.insert(0, os.path.abspath('.'))
needs_sphinx = "2.0"


# -- Project information -----------------------------------------------------

project = "CellRank"
copyright = "2019, Marius Lange, Michal Klein, Juan Luis Restrepo Lopez"
author = "Marius Lange, Michal Klein, Juan Luis Restrepo Lopez"


# -- General configuration ---------------------------------------------------

# Add any Sphinx extension module names here, as strings. They can be
# extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
# ones.
extensions = [
    "nbsphinx",
    "sphinx_copybutton",
    "sphinx_last_updated_by_git"
]

# Add any paths that contain templates here, relative to this directory.
templates_path = ["_templates"]
source_suffix = [".rst", ".ipynb"]

# List of patterns, relative to source directory, that match files and
# directories to ignore when looking for source files.
# This pattern also affects html_static_path and html_extra_path.
exclude_patterns = ["**.ipynb_checkpoints"]

nbsphinx_execute_arguments = [
    "--InlineBackend.figure_formats={'svg', 'pdf'}",
    "--InlineBackend.rc={'figure.dpi': 96}",
]

nbsphinx_prolog = r"""
{% set docname = 'docs/source/' + env.doc2path(env.docname, base=None) %}
.. raw:: html

    <div class="note">
      Interactive version
      <a href="https://mybinder.org/v2/gh/theislab/cellrank_notebooks/{{ env.config.release|e }}?filepath={{ docname|e }}"><img alt="Binder badge" src="https://mybinder.org/badge_logo.svg" style="vertical-align:text-bottom"></a>
    </div>
"""

master_doc = "index"

# -- Get version information and date from Git ----------------------------

try:
    from subprocess import check_output
    release = check_output(['git', 'describe', '--tags', '--always'])
    release = release.decode().strip()
    today = check_output(['git', 'show', '-s', '--format=%ad', '--date=short'])
    today = today.decode().strip()
except Exception:
    release = '<unknown>'
    today = '<unknown date>'

#release = "master"
version = release


# -- Options for HTML output -------------------------------------------------

# The theme to use for HTML and HTML Help pages.  See the documentation for
# a list of builtin themes.
#

pygments_style = "sphinx"
html_scaled_image_link = False


# Add any paths that contain custom static files (such as style sheets) here,
# relative to this directory. They are copied after the builtin static files,
# so a file named "default.css" will overwrite the builtin "default.css".
html_theme = "sphinx_rtd_theme"
html_static_path = ["_static"]
html_theme_options = dict(navigation_depth=4, logo_only=True)
html_context = dict(
    display_github=True,  # Integrate GitHub
    github_user="theislab",  # Username
    github_repo="cellrank_notebooks",  # Repo name
    github_version=version,  # Version
    conf_py_path="/docs/source/",
)  # Path in the checkout to the docs root
html_show_sphinx = False


def setup(app):
    app.add_css_file("css/custom.css")
