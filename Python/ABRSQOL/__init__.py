from importlib import metadata
# this works, but usually people just write the name as a string here.
# not 100% DRY, but it's not like the package name could ever change
__title__ = __name__
# if you're stuck on python 3.7 or older, importlib-metadata is a 
# third-party package that can be used as a drop-in instead
__version__ = metadata.version(__title__)
from .invert_quality_of_life import *
from .testdata import *
