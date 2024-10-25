import sys

if sys.version_info[:2] >= (3, 8):
    # TODO: Import directly (no need for conditional) when `python_requires = >= 3.8`
    from importlib.metadata import PackageNotFoundError, version  # pragma: no cover
else:
    from importlib_metadata import PackageNotFoundError, version  # pragma: no cover

#package_data={'ABRSQOL' :['ABRSQOL/resources/data/*']}

try:
    # Change here if project is renamed and does not equal the package name
    dist_name = "ABRSQOL"
    # __version__ = version(dist_name)
    __version__ = "9.9.9"
except PackageNotFoundError:  # pragma: no cover
    __version__ = "unknown"
finally:
    del version, PackageNotFoundError
