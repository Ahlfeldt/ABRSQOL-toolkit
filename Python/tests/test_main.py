from ABRSQOL import invert_quality_of_life, testdata


def test_ABRSQOL():
    try:
        invert_quality_of_life(df=testdata)
        success=True
    except:
        success=False
    assert success
    
