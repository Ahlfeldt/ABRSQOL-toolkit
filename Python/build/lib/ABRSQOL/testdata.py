from pandas import DataFrame
"""
    Returns:
    ----------
      testdata : pandas.DataFrame 
        test data set for quality of life inversion.
"""
testdata = DataFrame(
    columns=[
        x for x in 
        "llm_id,w,p_H,P_t,p_n,L,L_b,Name,coord_x,coord_y".split(',')
        ],
    data=[
        x.split(',') for x in 
        """1,1975.3441,2134.219,1,1,724185,689304,Kiel,573646.635133,6020244.30269\n2,1971.5525,2032.8229,1,1,415827,405739,Lübeck,613573.181795,5970716.54198\n3,1707.1901,1249.2167,1,1,132917,129407,Dithmarschen,508570.248839,5973643.61317\n4,1939.4725,1853.2981,1,1,446741,431290,Flensburg,528196.3711099999,6070949.97091\n5,2203.354,5304.5269,1,1,3355293,2871439,Hamburg,592262.4807289999,5921182.52452\n6,2007.0084,2249.2471,1,1,605744,583675,Braunschweig,603989.8109940001,5792750.02725\n7,1995.2524,2051.3789,1,1,389750,346259,Wolfsburg,621411.2929389999,5808220.68519\n8,1709.4065,1233.3097,1,1,565759,618843,Göttingen,571647.204261,5748591.76964\n9,1714.2869,885.12994,1,1,359602,459466,Goslar,607904.754034,5749997.05682\n10,1955.7388,2665.9751,1,1,1718006,1610190,Hannover,552389.524666,5803527.42434\n11,1709.9808,1066.1329,1,1,219940,233897,Hameln,516766.044961,5767350.79847\n12,1850.0875,1248.7775,1,1,177971,164201,Celle,567357.000464,5849125.89278\n13,1947.0114,800.23096,1,1,136292,158018,Lüchow-Dannenberg,665973.816767,5877463.43772\n14,1995.4172,1647.1194,1,1,200054,168333,Stade,545936.671178,5923987.50954\n15,1989.8956,1010.3835,1,1,93131,94652,Uelzen,599275.464071,5888812.82028\n16,1617.8263,1090.6469,1,1,407441,361989,Emden,378925.119423,5913981.30793\n17,2147.2114,2488.1841,1,1,503112,423104,Oldenburg,448119.438732,5888633.08552\n18,1924.1432,1841.0911,1,1,520482,441628,Osnabrück,434980.424558,5792349.89903\n19,1634.4387,1442.2609,1,1,455150,364650,Emsland,385132.878164,5806907.05588\n20,2048.2378,1417.9877,1,1,231068,244233,Wilhelmshaven,439571.219382,5935716.80654\n21,1799.4197,1629.931,1,1,302600,214565,Vechta,418606.775068,5888324.096\n22,1832.8654,2296.2097,1,1,1259240,1127503,Bremen,482286.456345,5856123.80222\n23,1662.1692,1232.4456,1,1,312128,325080,Bremerhaven,479959.257845,5963834.84983\n24,2562.3037,3647.1282,1,1,2328284,2176398,Düsseldorf,347126.753174,5678284.63734\n25,1880.9305,1871.8589,1,1,2033874,2059200,Essen,342559.156655,5701141.63687\n26,2098.5022,1380.3151,1,1,618271,655696,Wuppertal,375875.140406,5671641.33474\n27,1627.8397,1639.2094,1,1,310337,261907,Kleve,307259.251512,5737840.96723\n28,2150.96,2616.728,1,1,1042792,880840,Bonn,366535.122828,5618810.13108\n29,2252.8359,3493.186,1,1,2164620,1883610,Köln,357636.998732,5645730.82125\n30,1738.7493,2347.4971,1,1,1069277,978582,Aachen,296161.224185,5627068.69594\n31,1949.4404,1247.5667,1,1,409817,368745,Olpe,407434.77091,5653838.0263\n32,2051.5979,3064.7966,1,1,1249245,1075803,Münster,405418.593545,5756848.16559\n33,1786.3311,1892.5134,1,1,369666,307162,Borken,360470.232677,5773875.88632\n34,2019.6904,1913.4629,1,1,1044482,909427,Bielefeld,468482.682041,5762354.96406\n35,1675.8801,1007.9559,1,1,144010,140725,Höxter,502643.137691,5730102.21389\n36,1761.6077,1301.3451,1,1,685804,617142,Minden,515725.44403,5832155.46718\n37,1943.0155,1567.8765,1,1,1398768,1461148,Bochum,366280.465796,5713188.17792\n38,1874.8206,1840.6735,1,1,1161613,1129442,Dortmund,394177.597348,5708317.95659\n39,2156.7913,1540.1084,1,1,931169,954153,Hagen,395367.468551,5689599.6688\n40,2107.6921,1604.8619,1,1,280800,278512,Siegen,458248.799716,5656110.85476\n41,1857.8403,2296.4885,1,1,871089,758192,Soest,495681.946598,5731958.78957\n42,2027.0565,2579.0313,1,1,545126,469952,Darmstadt,475918.837672,5525508.64622\n43,2281.312,4666.1387,1,1,2649983,2252639,Frankfurt am Main,474558.791196,5551803.8675\n44,2058.9485,2022.7167,1,1,760913,701797,Gießen,487500.048592,5614298.62315\n45,2066.2678,1378.6356,1,1,356036,317671,Limburg-Weilburg,434650.923269,5566775.48105\n46,2005.3413,1963.2001,1,1,714822,703082,Kassel,532074.47659,5684562.16097\n47,1907.7833,2115.3894,1,1,448554,424508,Fulda,521028.826139,5623637.4066\n48,1909.6559,1049.0784,1,1,157592,153480,Waldeck-Frankenberg,476474.097783,5654607.4588\n49,2019.0251,2063.6682,1,1,993931,886722,Koblenz,398938.329683,5578347.69075\n50,1794.5303,959.69891,1,1,129171,120652,Altenkirchen,402977.563182,5614551.53632\n51,1896.536,1717.6166,1,1,237436,230042,Bad Kreuznach,418628.470453,5521165.4268\n52,1581.0222,1451.6366,1,1,97180,87863,Bitburg,323158.700236,5538666.59698\n53,1866.6375,1361.5385,1,1,60794,56092,Vulkaneifel,339954.128719,5569424.70429\n54,1778.1616,2322.5762,1,1,374741,324951,Trier,331118.807795,5514882.05953\n55,1888.1777,1639.7637,1,1,349713,332745,Kaiserslautern,410146.221696,5476306.46683\n56,2111.1404,1994.9777,1,1,283191,232563,Landau,435159.6838,5449650.0112\n57,2288.9922,2286.1641,1,1,987995,902850,Ludwigshafen,453466.233349,5486916.89392\n58,2316.3457,3770.312,1,1,822020,714358,Mainz,447082.405569,5547697.46433\n59,2389.4197,4126.5605,1,1,2101395,1808448,Stuttgart,512638.584563,5402407.22932\n60,2273.8599,3541.5061,1,1,652873,546969,Böblingen,501452.95144,5392087.74909\n61,2251.5952,2161.0745,1,1,252749,229397,Göppingen,567991.758272,5393114.81537\n62,1900.5349,2226.3086,1,1,710072,575673,Heilbronn,513295.323184,5444451.09365\n63,1715.6874,1737.0375,1,1,191614,151102,Schwäbisch Hall,570238.2508630001,5461634.75605\n64,1925.1349,2022.4921,1,1,537752,478847,Heidenheim,603071.675274,5395464.87086\n65,2133.2854,3080.1482,1,1,1025230,869012,Karlsruhe,443539.29255,5399776.90155\n66,2154.7485,2786.5657,1,1,965054,842011,Heidelberg,484600.385476,5487462.08749\n67,2435.9363,1783.5033,1,1,318313,268488,Pforzheim,478926.888364,5413759.38989\n68,2170.23,3874.2495,1,1,645818,526483,Freiburg,411822.334243,5316161.11624\n69,2149.3979,2525.917,1,1,420106,353537,Ortenaukreis,424717.706377,5378300.47391\n70,2350.2998,1937.1202,1,1,483754,431439,Rottweil,465196.087659,5356101.13437\n71,2219.0537,4253.3901,1,1,280288,232615,Konstanz,482048.549217,5291919.15933\n72,2151.2002,2804.7109,1,1,226708,190827,Lörrach,392445.708834,5280812.20729\n73,2186.1912,2267.4602,1,1,167861,145584,Waldshut,433997.409096,5274700.6476\n74,2273.3733,2712.2131,1,1,503950,420880,Reutlingen,526123.814505,5374892.75148\n75,2308.8667,1276.8279,1,1,188595,170226,Zollernalbkreis,508784.157282,5351241.48349\n76,2043.7196,3156.8564,1,1,608202,509499,Ulm,570328.625369,5360181.30564\n77,2089.3352,2603.2957,1,1,765945,628497,Ravensburg,557787.596294,5336197.62105\n78,1886.3408,1583.4039,1,1,130772,114136,Sigmaringen,526929.409935,5310931.41354\n79,1792.647,3572.2192,1,1,480025,349976,Ingolstadt,676015.265077,5403004.14392\n80,2379.6753,7212.0796,1,1,3072122,2497205,München,689446.2806159999,5336467.00732\n81,1828.7085,1881.2313,1,1,339737,284996,Altötting,772192.784986,5348156.61636\n82,1855.4575,3217.4385,1,1,595987,482101,Traunstein,732621.182624,5303693.32747\n83,1807.3601,4937.6558,1,1,220291,191263,Weilheim-Schongau,655699.7092329999,5281099.94766\n84,1913.3774,2294.8533,1,1,193408,175957,Deggendorf,786465.636131,5405505.239\n85,1768.2487,1052.3689,1,1,78122,73126,Freyung-Grafenau,834006.548374,5417471.29526\n86,2012.0448,2146.0503,1,1,238902,210920,Passau,825590.16677,5390416.6633\n87,2078.3281,3140.3672,1,1,463504,365931,Landshut,733173.264418,5381666.97267\n88,1659.5449,1532.6609,1,1,126359,116693,Cham,777748.258268,5463934.48407\n89,1896.4253,1403.9858,1,1,355876,345589,Amberg,706217.924596,5481476.75195\n90,2062.9063,3627.9187,1,1,598684,484363,Regensburg,709755.012435,5412525.96712\n91,1685.5929,2387.5063,1,1,303482,266558,Bamberg,636403.645167,5527822.2778\n92,1942.1882,2235.2441,1,1,248922,241647,Bayreuth,685464.57255,5534910.89795\n93,1982.0355,1822.6271,1,1,251329,267514,Coburg,640009.8675770001,5569815.8603\n94,1924.4877,1089.4635,1,1,446592,547641,Hof,706279.9844749999,5577201.82588\n95,1971.129,976.57904,1,1,67916,73840,Kronach,666472.978355,5568425.945\n96,1943.0048,3747.928,1,1,456057,386943,Erlangen,650291.243217,5516828.84146\n97,2109.4785,3087.4092,1,1,1212033,1049239,Nürnberg,679994.424892,5443509.39207\n98,1638.9119,1753.45,1,1,222473,192868,Ansbach,613696.943664,5461113.03473\n99,1611.8644,1442.4871,1,1,93342,84128,Weißenburg-Gunzenhausen,625346.520978,5446714.05019\n100,2081.7783,2421.0601,1,1,371127,320688,Aschaffenburg,510460.832286,5534621.83948\n101,1851.4475,1741.1941,1,1,349611,333081,Schweinfurt,587408.238027,5544569.83326\n102,1884.4155,2685.0691,1,1,632910,587616,Würzburg,577436.122367,5478392.05835\n103,2147.5239,2891.1008,1,1,662890,535544,Augsburg,639704.313375,5356427.6849\n104,1867.9213,2206.1355,1,1,183260,152294,Memmingen,586792.050152,5314593.50084\n105,1768.2267,1813.1461,1,1,131345,115332,Donau-Ries,634147.127121,5394315.248\n106,2041.6727,2430.6221,1,1,400059,341542,Kempten,620830.647477,5304219.5335\n107,1867.8837,2453.5005,1,1,851013,895448,Saarbrücken,354920.460193,5456024.28496\n108,1965.7976,1299.481,1,1,315443,327511,Pirmasens,397603.528925,5450324.76959\n109,1839.0436,4504.6729,1,1,4029715,3530106,Berlin,798734.794766,5825933.13539\n110,1788.1943,1085.4708,1,1,240489,280797,Frankfurt (Oder),874034.5743109999,5811363.87332\n111,1502.1644,896.26752,1,1,217123,319730,Elbe-Elster,804398.351267,5713968.45499\n112,1485.7289,1060.6124,1,1,158236,143836,Havelland,768889.886966,5834000.67825\n113,1573.1215,1495.0819,1,1,190714,178642,Märkisch-Oderland,824939.6239520001,5837747.87834\n114,1960.8173,1571.3414,1,1,207524,174524,Oberhavel,790882.578535,5847827.81255\n115,1541.7808,1166.922,1,1,99110,120282,Ostprignitz-Ruppin,755921.423898,5855293.57865\n116,1951.078,1258.0171,1,1,282484,261679,Potsdam-Mittelmark,739395.502681,5811669.80303\n117,1753.0461,923.94397,1,1,77573,110618,Prignitz,705446.970114,5889348.84299\n118,1917.4235,1299.1165,1,1,217322,294527,Cottbus,870137.325372,5749376.636\n119,1863.2502,1712.0282,1,1,163553,154192,Teltow-Fläming,799208.271777,5786343.53867\n120,1513.9869,1210.451,1,1,121014,166384,Uckermark,833111.843918,5888575.16371\n121,1764.25,1828.6846,1,1,467183,541889,Schwerin,659832.895466,5944119.56178\n122,1459.4985,1052.7725,1,1,262517,343334,Mecklenburgische Seenplatte,752655.4601800001,5980733.12636\n123,1655.8848,2660.0107,1,1,419484,464858,Rostock,705269.111152,6004473.56888\n124,1531.2123,1529.0018,1,1,224820,286716,Nordvorpommern,797963.747716,6039673.69145\n125,1364.3137,1739.217,1,1,238358,316233,Südvorpommern,809043.200742,5975552.69839\n126,1631.0765,1189.5084,1,1,1233294,1667511,Chemnitz,775473.188386,5637804.17614\n127,1740.7859,2751.4998,1,1,1036481,1146064,Dresden,835091.853231,5668104.80086\n128,1363.089,1231.988,1,1,566273,802168,Bautzen,848902.021883,5671882.45526\n129,1610.0588,1956.3463,1,1,1016485,1145463,Leipzig,735030.749375,5693285.90235\n130,1638.5323,1022.971,1,1,376183,545513,Dessau-Roßlau,722506.983201,5749700.68142\n131,1688.5958,1424.0626,1,1,697584,893323,Magdeburg,680846.152194,5777288.95667\n132,1584.869,1497.2769,1,1,748911,1019469,Halle,706124.575477,5707359.41324\n133,1655.5383,753.83545,1,1,115262,158639,Stendal,676525.850838,5837161.73665\n134,1790.868,1879.3658,1,1,673427,774449,Erfurt,641802.745805,5649903.02447\n135,1663.7347,1007.1958,1,1,289469,427628,Gera,716781.616479,5642561.62562\n136,1775.8153,2185.8025,1,1,195711,209949,Jena,681810.070944,5644588.08088\n137,1343.0009,1102.7335,1,1,162465,217435,Nordhausen,617843.404158,5717512.48762\n138,1693.1062,1342.2028,1,1,168072,209165,Eisenach,591246.991886,5649479.9669\n139,1509.3569,1178.4253,1,1,105273,131848,Unstrut-Hainich,615413.354259,5662239.38904\n140,1748.7637,1318.8209,1,1,225925,292821,Suhl,621552.296765,5609099.78684\n141,1666.6409,1154.8206,1,1,192229,263403,Saalfeld-Rudolstadt,659058.429546,5616741.55218""".split('\n')
        ], 
)
# set appropriate dtypes
testdata = testdata.astype(dtype= {
    "llm_id": int,
    "w": float,
    "p_H": float,
    "P_t": float,
    "p_n": float,
    "L": int,
    "L_b": int,
    "Name": str,
    "coord_x": float,
    "coord_y": float,
})