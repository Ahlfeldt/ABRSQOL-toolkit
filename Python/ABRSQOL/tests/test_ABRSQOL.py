import pytest
 
from abrsqol.ABRSQOL import main, ABRSQOL

__author__ = "maximylius"
__copyright__ = "Gabriel M Ahlfeldt"
__license__ = "MIT"


def test_fib():
    """API Tests"""
    assert ABRSQOL(df=[[]]) == []
    with pytest.raises(AssertionError):
        ABRSQOL(-10)

def test_ABRSQOL():
    """API Tests"""
    assert ABRSQOL(df=[[]]) == []
    with pytest.raises(AssertionError):
        ABRSQOL(-20)


def test_main(capsys):
    """CLI Tests"""
    # capsys is a pytest fixture that allows asserts against stdout/stderr
    # https://docs.pytest.org/en/stable/capture.html
    main(["7"])
    captured = capsys.readouterr()
    assert "The 7-th Fibonacci number is 13" in captured.out
