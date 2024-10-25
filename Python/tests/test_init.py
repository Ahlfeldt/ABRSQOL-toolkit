from ABRSQOL import ABRSQOL, ABRSQOL_testdata


def test_ABRSQOL():
    try:
        ABRSQOL(df=ABRSQOL_testdata)
        success=True
    except:
        success=False
    assert success
    
