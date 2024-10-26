import ABRSQOL

def test_ABRSQOL():
    """
    test invert_quality_of_life with testdata and default parameters
    """
    try:
        ABRSQOL.invert_quality_of_life(df=ABRSQOL.testdata)
        success=True
    except:
        success=False
    assert success
    
