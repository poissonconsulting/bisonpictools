# quick mode produces an .smb_analysis object with correct thinning rate, names, and expected coefficients

    Code
      print(embr::glance(analysis), n = 100, width = 100)
    Output
      # A tibble: 1 x 8
            n     K nchains niters nthin   ess  rhat converged
        <int> <int>   <int>  <int> <int> <int> <dbl> <lgl>    
      1    11    57       2     10     1     7  1.97 FALSE    

---

    Code
      print(embr::coef(analysis, simplify = TRUE, param_type = "fixed"), n = 100,
      width = 100)
    Output
      # A tibble: 57 x 5
         term                           estimate     lower    upper svalue
         <term>                            <dbl>     <dbl>    <dbl>  <dbl>
       1 bEtaSummerFall                   0.232    0.00955   0.753   4.39 
       2 bEtaWin                          0.101    0.00114   0.484   4.39 
       3 bFecundityReproductiveFA         1.94     1.63      2.69    4.39 
       4 bInitialMortalityCalfAnnual[1]  -3.75    -5.78     -2.12    4.39 
       5 bInitialMortalityCalfAnnual[2]  -4.56    -7.45     -2.35    4.39 
       6 bInitialMortalityCalfAnnual[3]  -2.87    -7.46     -1.60    4.39 
       7 bInitialMortalityCalfAnnual[4]  -1.09    -6.11      3.64    0.485
       8 bKmWeekSummerFall                2.22     0.266     4.42    4.39 
       9 bKmWeekWin                       1.93     1.21      2.63    4.39 
      10 bMAProportion[1]                 0.440    0.258     0.582   4.39 
      11 bMAProportion[2]                 0.173    0.0980    0.286   4.39 
      12 bPopulationAbundanceInit       243.     202.      280.      4.39 
      13 bPopulationF0Init               41.3     27.8      63.3     4.39 
      14 bPopulationF1Init               17.0      6.53     43.2     4.39 
      15 bPopulationFAInit               64.0     51.8      82.0     4.39 
      16 bPopulationM0Init               36.3     19.7      68.9     4.39 
      17 bPopulationM1Init               19.0     10.9      30.7     4.39 
      18 bPopulationM2Init                7.00     1.68     14.8     4.39 
      19 bPopulationM3Init               18.4      4.36     35.0     4.39 
      20 bPopulationMAInit               44.6     11.2      72.8     4.39 
      21 bPropReproductiveFA              0.965    0.888     0.996   4.39 
      22 bPropVecInit[1]                  0.151    0.0880    0.257   4.39 
      23 bPropVecInit[2]                  0.0687   0.00769   0.170   4.39 
      24 bPropVecInit[3]                  0.265    0.216     0.350   4.39 
      25 bPropVecInit[4]                  0.146    0.0762    0.243   4.39 
      26 bPropVecInit[5]                  0.0679   0.0441    0.112   4.39 
      27 bPropVecInit[6]                  0.0431   0.00476   0.0681  4.39 
      28 bPropVecInit[7]                  0.0605   0.0221    0.139   4.39 
      29 bPropVecInit[8]                  0.171    0.0536    0.273   4.39 
      30 bRhoSummerFall                   0.433    0.0352    5.28    4.39 
      31 bRhoWin                          0.550    0.0543    2.65    4.39 
      32 bSigmaSummerFall                 0.280    0.0199    1.23    4.39 
      33 bSigmaWin                        0.138    0.0156    0.399   4.39 
      34 bSurvBullAnnual[1]               2.18     1.61      3.83    4.39 
      35 bSurvBullAnnual[2]               2.20     1.37      3.19    4.39 
      36 bSurvBullAnnual[3]               2.45     1.53      3.17    4.39 
      37 bSurvBullAnnual[4]               2.32     1.68      3.18    4.39 
      38 bSurvF0Annual[1]                -0.118   -0.520     0.648   0.305
      39 bSurvF0Annual[2]                 0.111   -0.789     0.810   0.144
      40 bSurvF0Annual[3]                 0.589    0.0599    0.901   4.39 
      41 bSurvF0Annual[4]                -0.173   -1.14      0.686   0.144
      42 bSurvF1Annual[1]                 1.93     0.748     2.63    4.39 
      43 bSurvF1Annual[2]                 1.74     0.974     2.43    4.39 
      44 bSurvF1Annual[3]                 1.74     0.909     2.74    4.39 
      45 bSurvF1Annual[4]                 1.60     0.713     2.51    4.39 
      46 bSurvFAAnnual[1]                 4.47     3.80      5.28    4.39 
      47 bSurvFAAnnual[2]                 4.46     3.73      5.32    4.39 
      48 bSurvFAAnnual[3]                 4.16     3.49      5.36    4.39 
      49 bSurvFAAnnual[4]                 4.62     3.83      5.27    4.39 
      50 bSurvM0Annual[1]                -0.160   -1.34      0.801   0.485
      51 bSurvM0Annual[2]                 0.354   -0.277     1.19    1.58 
      52 bSurvM0Annual[3]                 0.238   -0.285     0.656   0.692
      53 bSurvM0Annual[4]                -0.0149  -0.411     0.793   0    
      54 bSurvM1Annual[1]                 1.71     0.765     2.19    4.39 
      55 bSurvM1Annual[2]                 1.77     0.813     2.62    4.39 
      56 bSurvM1Annual[3]                 1.75     1.44      2.37    4.39 
      57 bSurvM1Annual[4]                 1.84     0.998     2.53    4.39 

---

    Code
      print(embr::coef(analysis, simplify = TRUE, param_type = "random"), n = 100,
      width = 100)
    Output
      # A tibble: 176 x 5
          term                     estimate  lower upper svalue
          <term>                      <dbl>  <dbl> <dbl>  <dbl>
        1 eZSummerFallAdult[1]     -0.00110 -1.28  1.40   0    
        2 eZSummerFallAdult[2]     -0.200   -1.91  1.59   0.144
        3 eZSummerFallAdult[3]     -0.148   -1.55  0.949  0.144
        4 eZSummerFallAdult[4]     -0.389   -2.23  1.66   0.305
        5 eZSummerFallAdult[5]      0.0896  -1.10  1.10   0    
        6 eZSummerFallAdult[6]     -0.0706  -2.18  2.21   0.144
        7 eZSummerFallAdult[7]     -0.383   -2.10  2.41   0.305
        8 eZSummerFallAdult[8]     -0.0254  -1.28  0.907  0.144
        9 eZSummerFallAdult[9]      0.108   -2.26  1.48   0.144
       10 eZSummerFallAdult[10]    -0.0728  -2.25  1.87   0    
       11 eZSummerFallAdult[11]    -0.0563  -2.27  2.34   0    
       12 eZSummerFallCalf[1]      -0.359   -1.58  0.971  0.933
       13 eZSummerFallCalf[2]      -0.266   -1.88  1.36   0.692
       14 eZSummerFallCalf[3]      -0.230   -0.986 0.837  0.305
       15 eZSummerFallCalf[4]      -0.320   -1.70  1.11   0.692
       16 eZSummerFallCalf[5]      -0.0760  -1.25  1.16   0.144
       17 eZSummerFallCalf[6]      -0.245   -1.45  0.847  0.144
       18 eZSummerFallCalf[7]       0.0918  -1.07  1.33   0.144
       19 eZSummerFallCalf[8]       0.334   -2.40  1.86   0.144
       20 eZSummerFallCalf[9]      -0.103   -1.16  1.09   0.305
       21 eZSummerFallCalf[10]      0.406   -1.17  2.05   0.144
       22 eZSummerFallCalf[11]     -0.0255  -1.38  1.34   0    
       23 eZSummerFallF0M0[1]      -0.337   -1.74  2.04   0.144
       24 eZSummerFallF0M0[2]       0.0835  -1.72  1.74   0    
       25 eZSummerFallF0M0[3]       0.0245  -2.36  2.90   0    
       26 eZSummerFallF0M0[4]      -0.0916  -2.65  2.41   0    
       27 eZSummerFallF0M0[5]      -0.129   -0.955 1.12   0.305
       28 eZSummerFallF0M0[6]      -0.0240  -0.929 1.61   0.144
       29 eZSummerFallF0M0[7]      -0.00986 -1.75  2.11   0    
       30 eZSummerFallF0M0[8]       0.0539  -1.06  1.78   0.144
       31 eZSummerFallF0M0[9]       0.191   -1.73  1.68   0.144
       32 eZSummerFallF0M0[10]      0.106   -1.67  1.62   0.144
       33 eZSummerFallF0M0[11]      0.110   -1.27  1.49   0.144
       34 eZSummerFallF1M1[1]      -0.328   -1.84  2.56   0.144
       35 eZSummerFallF1M1[2]      -0.711   -2.30  1.69   0.485
       36 eZSummerFallF1M1[3]      -0.0523  -1.12  0.988  0    
       37 eZSummerFallF1M1[4]      -0.193   -1.02  0.829  0.485
       38 eZSummerFallF1M1[5]      -0.164   -0.899 0.787  0.305
       39 eZSummerFallF1M1[6]       0.347   -1.55  1.61   0.305
       40 eZSummerFallF1M1[7]      -0.268   -1.43  1.35   0.305
       41 eZSummerFallF1M1[8]       0.107   -1.74  1.30   0.144
       42 eZSummerFallF1M1[9]      -0.0627  -1.47  1.76   0    
       43 eZSummerFallF1M1[10]      0.0139  -2.38  1.75   0    
       44 eZSummerFallF1M1[11]      0.0460  -1.13  1.64   0.144
       45 eZSummerFallFABull[1]     0.136   -1.18  1.98   0.144
       46 eZSummerFallFABull[2]    -0.405   -1.87  1.53   0.692
       47 eZSummerFallFABull[3]    -0.253   -1.19  1.49   0.144
       48 eZSummerFallFABull[4]    -0.346   -1.51  1.39   0.485
       49 eZSummerFallFABull[5]    -0.178   -1.48  1.60   0.144
       50 eZSummerFallFABull[6]     0.359   -2.08  1.52   0.144
       51 eZSummerFallFABull[7]     0.139   -1.49  1.46   0.144
       52 eZSummerFallFABull[8]     0.0207  -1.73  1.26   0    
       53 eZSummerFallFABull[9]    -0.0363  -1.41  1.51   0    
       54 eZSummerFallFABull[10]    0.144   -1.53  1.79   0.144
       55 eZSummerFallFABull[11]    0.0387  -1.93  1.77   0    
       56 eZSummerFallM2M3[1]       0.192   -1.60  1.72   0.485
       57 eZSummerFallM2M3[2]      -0.403   -1.81  0.673  0.692
       58 eZSummerFallM2M3[3]      -0.159   -2.08  2.01   0.144
       59 eZSummerFallM2M3[4]       0.0340  -1.43  1.84   0    
       60 eZSummerFallM2M3[5]       0.0154  -0.971 1.05   0.144
       61 eZSummerFallM2M3[6]       0.200   -0.990 1.19   0.144
       62 eZSummerFallM2M3[7]       0.395   -0.917 1.41   0.485
       63 eZSummerFallM2M3[8]       0.0502  -0.993 1.07   0    
       64 eZSummerFallM2M3[9]       0.237   -1.60  1.95   0.305
       65 eZSummerFallM2M3[10]     -0.00694 -1.88  1.96   0    
       66 eZSummerFallM2M3[11]      0.115   -1.27  0.689  0.485
       67 eZSummerFallMAFA[1]      -0.0374  -1.86  1.55   0    
       68 eZSummerFallMAFA[2]      -0.280   -2.36  1.70   0.692
       69 eZSummerFallMAFA[3]      -0.212   -1.34  0.847  0.305
       70 eZSummerFallMAFA[4]      -0.285   -2.01  1.36   0.485
       71 eZSummerFallMAFA[5]      -0.0367  -0.806 1.36   0    
       72 eZSummerFallMAFA[6]      -0.745   -2.63  2.41   0.485
       73 eZSummerFallMAFA[7]      -0.104   -1.45  1.42   0.144
       74 eZSummerFallMAFA[8]       0.164   -1.57  1.61   0.305
       75 eZSummerFallMAFA[9]       0.170   -1.74  1.88   0.144
       76 eZSummerFallMAFA[10]      0.382   -1.48  1.43   0.305
       77 eZSummerFallMAFA[11]     -0.0485  -2.25  2.24   0    
       78 eZSummerFallYearling[1]   0.249   -0.612 1.37   0.144
       79 eZSummerFallYearling[2]  -0.236   -1.17  1.05   0.305
       80 eZSummerFallYearling[3]  -0.647   -1.44  0.826  0.692
       81 eZSummerFallYearling[4]  -1.36    -2.48  0.428  1.58 
       82 eZSummerFallYearling[5]   0.143   -1.63  1.62   0.144
       83 eZSummerFallYearling[6]  -0.106   -1.61  1.66   0    
       84 eZSummerFallYearling[7]   0.137   -1.91  1.93   0.305
       85 eZSummerFallYearling[8]   0.0330  -2.11  2.16   0    
       86 eZSummerFallYearling[9]   0.0556  -1.37  1.61   0    
       87 eZSummerFallYearling[10]  0.161   -1.84  1.81   0.305
       88 eZSummerFallYearling[11]  0.259   -1.64  1.58   0.144
       89 eZWinAdult[1]            -0.337   -1.93  2.01   0.305
       90 eZWinAdult[2]            -0.0656  -1.33  1.84   0    
       91 eZWinAdult[3]            -0.185   -1.70  1.52   0.144
       92 eZWinAdult[4]            -0.237   -1.53  1.58   0.144
       93 eZWinAdult[5]             0.283   -2.18  2.40   0.144
       94 eZWinAdult[6]             0.145   -1.53  1.27   0    
       95 eZWinAdult[7]            -0.0144  -1.14  1.80   0    
       96 eZWinAdult[8]             0.184   -2.49  2.37   0.305
       97 eZWinAdult[9]             0.148   -1.36  1.76   0.144
       98 eZWinAdult[10]           -0.0433  -1.63  1.67   0    
       99 eZWinAdult[11]            0.00894 -1.50  1.50   0    
      100 eZWinCalf[1]             -0.0230  -1.98  1.62   0    
      # i 76 more rows

---

    Code
      print(embr::coef(analysis, simplify = TRUE, param_type = "derived"), n = 100,
      width = 100)
    Output
      # A tibble: 328 x 5
          term                   estimate    lower    upper svalue
          <term>                    <dbl>    <dbl>    <dbl>  <dbl>
        1 bPopulationAnnual[1,1]  41.3    27.8      63.3      4.39
        2 bPopulationAnnual[2,1]  17.0     6.53     43.2      4.39
        3 bPopulationAnnual[3,1]  64.0    51.8      82.0      4.39
        4 bPopulationAnnual[4,1]  36.3    19.7      68.9      4.39
        5 bPopulationAnnual[5,1]  19.0    10.9      30.7      4.39
        6 bPopulationAnnual[6,1]   7.00    1.68     14.8      4.39
        7 bPopulationAnnual[7,1]  18.4     4.36     35.0      4.39
        8 bPopulationAnnual[8,1]  44.6    11.2      72.8      4.39
        9 bPopulationAnnual[1,2]  32.6    26.2      36.9      4.39
       10 bPopulationAnnual[2,2]  20.1    12.4      31.6      4.39
       11 bPopulationAnnual[3,2]  80.6    65.1      91.5      4.39
       12 bPopulationAnnual[4,2]  32.6    26.2      36.9      4.39
       13 bPopulationAnnual[5,2]  15.5    11.1      22.8      4.39
       14 bPopulationAnnual[6,2]  15.7     9.05     25.0      4.39
       15 bPopulationAnnual[7,2]   6.26    1.61     13.5      4.39
       16 bPopulationAnnual[8,2]  51.8    32.0      83.0      4.39
       17 bPopulationAnnual[1,3]  40.9    35.3      43.0      4.39
       18 bPopulationAnnual[2,3]  17.7     8.95     23.2      4.39
       19 bPopulationAnnual[3,3]  97.3    86.1     116.       4.39
       20 bPopulationAnnual[4,3]  40.9    35.3      43.0      4.39
       21 bPopulationAnnual[5,3]  19.4    12.7      26.7      4.39
       22 bPopulationAnnual[6,3]  13.6     8.46     19.8      4.39
       23 bPopulationAnnual[7,3]  14.0     8.51     22.3      4.39
       24 bPopulationAnnual[8,3]  49.8    33.2      78.2      4.39
       25 bPopulationAnnual[1,4]  44.4    35.0      47.6      4.39
       26 bPopulationAnnual[2,4]  25.0    20.2      30.2      4.39
       27 bPopulationAnnual[3,4] 108.     94.1     126.       4.39
       28 bPopulationAnnual[4,4]  44.4    35.0      47.6      4.39
       29 bPopulationAnnual[5,4]  21.9    18.0      27.5      4.39
       30 bPopulationAnnual[6,4]  16.9    11.0      23.1      4.39
       31 bPopulationAnnual[7,4]  11.9     7.91     18.4      4.39
       32 bPopulationAnnual[8,4]  61.5    46.7      78.4      4.39
       33 bPropVecEvent[1,1]       0.106   0.0831    0.128    4.39
       34 bPropVecEvent[2,1]       0.119   0.111     0.135    4.39
       35 bPropVecEvent[3,1]       0.0998  0.0851    0.116    4.39
       36 bPropVecEvent[4,1]       0.0956  0.0672    0.121    4.39
       37 bPropVecEvent[5,1]       0.112   0.101     0.129    4.39
       38 bPropVecEvent[6,1]       0.0906  0.0598    0.116    4.39
       39 bPropVecEvent[7,1]       0.0835  0.0510    0.111    4.39
       40 bPropVecEvent[8,1]       0.108   0.0936    0.126    4.39
       41 bPropVecEvent[9,1]       0.110   0.0676    0.174    4.39
       42 bPropVecEvent[10,1]      0.0850  0.0528    0.112    4.39
       43 bPropVecEvent[11,1]      0.0845  0.0576    0.107    4.39
       44 bPropVecEvent[1,2]       0.0786  0.0470    0.128    4.39
       45 bPropVecEvent[2,2]       0.0578  0.0325    0.0798   4.39
       46 bPropVecEvent[3,2]       0.0753  0.0621    0.0933   4.39
       47 bPropVecEvent[4,2]       0.0798  0.0470    0.128    4.39
       48 bPropVecEvent[5,2]       0.0583  0.0318    0.0804   4.39
       49 bPropVecEvent[6,2]       0.0803  0.0470    0.127    4.39
       50 bPropVecEvent[7,2]       0.0811  0.0469    0.127    4.39
       51 bPropVecEvent[8,2]       0.0586  0.0313    0.0808   4.39
       52 bPropVecEvent[9,2]       0.0671  0.0292    0.187    4.39
       53 bPropVecEvent[10,2]      0.0809  0.0469    0.127    4.39
       54 bPropVecEvent[11,2]      0.0752  0.0607    0.0963   4.39
       55 bPropVecEvent[1,3]       0.341   0.281     0.379    4.39
       56 bPropVecEvent[2,3]       0.361   0.320     0.413    4.39
       57 bPropVecEvent[3,3]       0.359   0.325     0.405    4.39
       58 bPropVecEvent[4,3]       0.355   0.293     0.397    4.39
       59 bPropVecEvent[5,3]       0.374   0.331     0.429    4.39
       60 bPropVecEvent[6,3]       0.363   0.299     0.406    4.39
       61 bPropVecEvent[7,3]       0.373   0.308     0.418    4.39
       62 bPropVecEvent[8,3]       0.382   0.338     0.438    4.39
       63 bPropVecEvent[9,3]       0.338   0.267     0.417    4.39
       64 bPropVecEvent[10,3]      0.371   0.306     0.416    4.39
       65 bPropVecEvent[11,3]      0.380   0.346     0.431    4.39
       66 bPropVecEvent[1,4]       0.115   0.0915    0.132    4.39
       67 bPropVecEvent[2,4]       0.113   0.103     0.126    4.39
       68 bPropVecEvent[3,4]       0.109   0.0923    0.122    4.39
       69 bPropVecEvent[4,4]       0.105   0.0802    0.129    4.39
       70 bPropVecEvent[5,4]       0.103   0.0913    0.119    4.39
       71 bPropVecEvent[6,4]       0.100   0.0743    0.127    4.39
       72 bPropVecEvent[7,4]       0.0937  0.0669    0.124    4.39
       73 bPropVecEvent[8,4]       0.0950  0.0832    0.114    4.39
       74 bPropVecEvent[9,4]       0.0849  0.0644    0.126    4.39
       75 bPropVecEvent[10,4]      0.0950  0.0684    0.125    4.39
       76 bPropVecEvent[11,4]      0.0944  0.0727    0.110    4.39
       77 bPropVecEvent[1,5]       0.0651  0.0444    0.0877   4.39
       78 bPropVecEvent[2,5]       0.0663  0.0466    0.0901   4.39
       79 bPropVecEvent[3,5]       0.0679  0.0537    0.0829   4.39
       80 bPropVecEvent[4,5]       0.0663  0.0439    0.0880   4.39
       81 bPropVecEvent[5,5]       0.0671  0.0467    0.0905   4.39
       82 bPropVecEvent[6,5]       0.0667  0.0436    0.0882   4.39
       83 bPropVecEvent[7,5]       0.0667  0.0431    0.0883   4.39
       84 bPropVecEvent[8,5]       0.0675  0.0466    0.0907   4.39
       85 bPropVecEvent[9,5]       0.0777  0.0492    0.130    4.39
       86 bPropVecEvent[10,5]      0.0667  0.0432    0.0883   4.39
       87 bPropVecEvent[11,5]      0.0685  0.0514    0.0851   4.39
       88 bPropVecEvent[1,6]       0.0605  0.0377    0.0969   4.39
       89 bPropVecEvent[2,6]       0.0501  0.0322    0.0684   4.39
       90 bPropVecEvent[3,6]       0.0530  0.0365    0.0717   4.39
       91 bPropVecEvent[4,6]       0.0618  0.0387    0.0982   4.39
       92 bPropVecEvent[5,6]       0.0506  0.0329    0.0700   4.39
       93 bPropVecEvent[6,6]       0.0619  0.0392    0.0987   4.39
       94 bPropVecEvent[7,6]       0.0620  0.0395    0.0994   4.39
       95 bPropVecEvent[8,6]       0.0509  0.0333    0.0709   4.39
       96 bPropVecEvent[9,6]       0.0317  0.00848   0.0734   4.39
       97 bPropVecEvent[10,6]      0.0620  0.0394    0.0993   4.39
       98 bPropVecEvent[11,6]      0.0548  0.0378    0.0742   4.39
       99 bPropVecEvent[1,7]       0.0248  0.00666   0.0542   4.39
      100 bPropVecEvent[2,7]       0.0474  0.0303    0.0765   4.39
      # i 228 more rows

# report mode runs

    Code
      print(embr::glance(analysis), n = 100, width = 100)
    Output
      # A tibble: 1 x 8
            n     K nchains niters nthin   ess  rhat converged
        <int> <int>   <int>  <int> <int> <int> <dbl> <lgl>    
      1    11    57       3    500     1   566  1.01 TRUE     

---

    Code
      print(embr::coef(analysis, simplify = TRUE, param_type = "fixed"), n = 100,
      width = 100)
    Output
      # A tibble: 57 x 5
         term                           estimate     lower    upper  svalue
         <term>                            <dbl>     <dbl>    <dbl>   <dbl>
       1 bEtaSummerFall                   0.291    0.0125    1.02   10.6   
       2 bEtaWin                          0.177    0.0105    0.618  10.6   
       3 bFecundityReproductiveFA         2.07     1.32      2.91   10.6   
       4 bInitialMortalityCalfAnnual[1]  -3.53    -7.73     -1.09   10.6   
       5 bInitialMortalityCalfAnnual[2]  -3.95    -7.68     -1.76   10.6   
       6 bInitialMortalityCalfAnnual[3]  -2.95    -7.22     -0.880  10.6   
       7 bInitialMortalityCalfAnnual[4]   0.0486  -5.70      5.58    0.0174
       8 bKmWeekSummerFall                2.06     0.280     3.97   10.6   
       9 bKmWeekWin                       1.94     0.200     4.09   10.6   
      10 bMAProportion[1]                 0.452    0.273     0.634  10.6   
      11 bMAProportion[2]                 0.190    0.0715    0.319  10.6   
      12 bPopulationAbundanceInit       245.     201.      302.     10.6   
      13 bPopulationF0Init               42.4     20.6      78.5    10.6   
      14 bPopulationF1Init               17.3      4.10     39.5    10.6   
      15 bPopulationFAInit               70.0     51.1      88.4    10.6   
      16 bPopulationM0Init               33.8     15.5      63.8    10.6   
      17 bPopulationM1Init               16.7      6.59     33.1    10.6   
      18 bPopulationM2Init                7.78     1.65     20.9    10.6   
      19 bPopulationM3Init               13.6      0.797    40.8    10.6   
      20 bPopulationMAInit               42.8     12.8      71.5    10.6   
      21 bPropReproductiveFA              0.969    0.862     0.999  10.6   
      22 bPropVecInit[1]                  0.169    0.0779    0.283  10.6   
      23 bPropVecInit[2]                  0.0681   0.00621   0.160  10.6   
      24 bPropVecInit[3]                  0.287    0.193     0.390  10.6   
      25 bPropVecInit[4]                  0.133    0.0509    0.235  10.6   
      26 bPropVecInit[5]                  0.0653   0.0111    0.137  10.6   
      27 bPropVecInit[6]                  0.0310   0.00137   0.0902 10.6   
      28 bPropVecInit[7]                  0.0527   0.00228   0.156  10.6   
      29 bPropVecInit[8]                  0.172    0.0473    0.292  10.6   
      30 bRhoSummerFall                   0.673    0.0264    3.68   10.6   
      31 bRhoWin                          0.541    0.0118    3.50   10.6   
      32 bSigmaSummerFall                 0.293    0.0169    1.06   10.6   
      33 bSigmaWin                        0.162    0.00759   0.540  10.6   
      34 bSurvBullAnnual[1]               2.41     1.50      3.33   10.6   
      35 bSurvBullAnnual[2]               2.41     1.45      3.42   10.6   
      36 bSurvBullAnnual[3]               2.31     1.35      3.30   10.6   
      37 bSurvBullAnnual[4]               2.44     1.51      3.40   10.6   
      38 bSurvF0Annual[1]                -0.0414  -0.923     0.905   0.106 
      39 bSurvF0Annual[2]                -0.165   -0.989     0.701   0.599 
      40 bSurvF0Annual[3]                 0.468   -0.313     1.23    2.05  
      41 bSurvF0Annual[4]                -0.148   -0.970     0.663   0.468 
      42 bSurvF1Annual[1]                 1.72     0.729     2.75    8.97  
      43 bSurvF1Annual[2]                 1.74     0.809     2.73   10.6   
      44 bSurvF1Annual[3]                 1.72     0.712     2.68    8.97  
      45 bSurvF1Annual[4]                 1.75     0.734     2.70   10.6   
      46 bSurvFAAnnual[1]                 4.58     3.59      5.55   10.6   
      47 bSurvFAAnnual[2]                 4.56     3.53      5.54   10.6   
      48 bSurvFAAnnual[3]                 4.57     3.59      5.58   10.6   
      49 bSurvFAAnnual[4]                 4.59     3.68      5.56   10.6   
      50 bSurvM0Annual[1]                -0.141   -1.02      0.851   0.391 
      51 bSurvM0Annual[2]                 0.335   -0.402     1.17    1.22  
      52 bSurvM0Annual[3]                 0.266   -0.482     1.01    1.03  
      53 bSurvM0Annual[4]                -0.102   -0.877     0.717   0.314 
      54 bSurvM1Annual[1]                 1.73     0.798     2.70    8.97  
      55 bSurvM1Annual[2]                 1.79     0.779     2.86   10.6   
      56 bSurvM1Annual[3]                 1.76     0.768     2.72   10.6   
      57 bSurvM1Annual[4]                 1.77     0.887     2.78   10.6   

---

    Code
      print(embr::coef(analysis, simplify = TRUE, param_type = "random"), n = 100,
      width = 100)
    Output
      # A tibble: 176 x 5
          term                      estimate lower upper  svalue
          <term>                       <dbl> <dbl> <dbl>   <dbl>
        1 eZSummerFallAdult[1]     -0.0335   -1.98 1.93  0.0429 
        2 eZSummerFallAdult[2]     -0.0582   -2.02 1.75  0.0974 
        3 eZSummerFallAdult[3]     -0.154    -1.98 1.66  0.224  
        4 eZSummerFallAdult[4]     -0.420    -2.21 1.56  0.640  
        5 eZSummerFallAdult[5]      0.00415  -1.94 1.99  0.00385
        6 eZSummerFallAdult[6]     -0.00951  -1.95 1.79  0.0135 
        7 eZSummerFallAdult[7]      0.0382   -1.99 2.01  0.0331 
        8 eZSummerFallAdult[8]      0.00505  -1.91 1.86  0.00964
        9 eZSummerFallAdult[9]      0.0466   -2.02 2.04  0.0390 
       10 eZSummerFallAdult[10]    -0.0261   -1.97 1.86  0.0213 
       11 eZSummerFallAdult[11]    -0.0316   -1.94 1.88  0.0409 
       12 eZSummerFallCalf[1]      -0.363    -2.11 1.28  0.562  
       13 eZSummerFallCalf[2]      -0.298    -1.94 1.19  0.570  
       14 eZSummerFallCalf[3]       0.00954  -1.67 1.42  0.0233 
       15 eZSummerFallCalf[4]      -0.431    -2.06 1.02  0.980  
       16 eZSummerFallCalf[5]      -0.00179  -2.04 1.98  0.00385
       17 eZSummerFallCalf[6]       0.0334   -1.92 2.06  0.0390 
       18 eZSummerFallCalf[7]       0.00278  -2.05 2.00  0.00192
       19 eZSummerFallCalf[8]      -0.00502  -2.01 1.78  0.00578
       20 eZSummerFallCalf[9]      -0.0169   -1.98 1.96  0.0213 
       21 eZSummerFallCalf[10]     -0.0507   -1.97 1.93  0.0609 
       22 eZSummerFallCalf[11]     -0.0248   -1.97 2.02  0.0291 
       23 eZSummerFallF0M0[1]      -0.00416  -2.11 2.03  0.00578
       24 eZSummerFallF0M0[2]       0.0810   -1.80 2.04  0.0770 
       25 eZSummerFallF0M0[3]       0.0244   -1.95 1.87  0.0233 
       26 eZSummerFallF0M0[4]       0.0204   -1.96 1.86  0.0233 
       27 eZSummerFallF0M0[5]       0.0198   -1.92 2.00  0.0311 
       28 eZSummerFallF0M0[6]      -0.00195  -1.94 1.93  0.00385
       29 eZSummerFallF0M0[7]      -0.00190  -2.02 2.07  0      
       30 eZSummerFallF0M0[8]      -0.0551   -2.13 1.99  0.0709 
       31 eZSummerFallF0M0[9]       0.0276   -1.85 1.99  0.0272 
       32 eZSummerFallF0M0[10]     -0.00414  -1.99 1.91  0.00964
       33 eZSummerFallF0M0[11]     -0.0144   -1.83 1.85  0.0135 
       34 eZSummerFallF1M1[1]      -0.0356   -2.02 1.95  0.0311 
       35 eZSummerFallF1M1[2]      -0.00890  -1.93 1.95  0.0135 
       36 eZSummerFallF1M1[3]       0.0101   -1.96 1.95  0.00964
       37 eZSummerFallF1M1[4]      -0.237    -2.07 1.69  0.279  
       38 eZSummerFallF1M1[5]      -0.0319   -1.97 2.04  0.0370 
       39 eZSummerFallF1M1[6]       0.0161   -1.95 1.89  0.0194 
       40 eZSummerFallF1M1[7]       0.0314   -2.05 2.21  0.0350 
       41 eZSummerFallF1M1[8]       0.0387   -2.10 1.99  0.0370 
       42 eZSummerFallF1M1[9]       0.0397   -1.92 1.93  0.0350 
       43 eZSummerFallF1M1[10]      0.0302   -1.82 2.00  0.0449 
       44 eZSummerFallF1M1[11]      0.0460   -1.89 1.86  0.0409 
       45 eZSummerFallFABull[1]     0.0999   -1.97 2.01  0.118  
       46 eZSummerFallFABull[2]    -0.504    -2.21 1.11  0.815  
       47 eZSummerFallFABull[3]    -0.172    -1.93 1.51  0.249  
       48 eZSummerFallFABull[4]    -0.359    -2.07 1.27  0.599  
       49 eZSummerFallFABull[5]    -0.00513  -1.97 1.93  0.00964
       50 eZSummerFallFABull[6]     0.0485   -2.09 2.12  0.0589 
       51 eZSummerFallFABull[7]     0.0297   -2.05 1.97  0.0390 
       52 eZSummerFallFABull[8]    -0.00988  -1.82 1.91  0.0116 
       53 eZSummerFallFABull[9]    -0.0161   -1.89 1.93  0.0311 
       54 eZSummerFallFABull[10]    0.0199   -1.89 1.84  0.0311 
       55 eZSummerFallFABull[11]   -0.0182   -2.06 2.04  0.0311 
       56 eZSummerFallM2M3[1]      -0.0128   -1.95 1.92  0.0135 
       57 eZSummerFallM2M3[2]      -0.367    -2.17 1.52  0.520  
       58 eZSummerFallM2M3[3]      -0.0274   -1.97 1.89  0.0311 
       59 eZSummerFallM2M3[4]       0.141    -2.08 2.22  0.169  
       60 eZSummerFallM2M3[5]      -0.00609  -1.87 1.92  0.0116 
       61 eZSummerFallM2M3[6]       0.0255   -1.92 2.02  0.0252 
       62 eZSummerFallM2M3[7]       0.0114   -2.03 2.02  0.0116 
       63 eZSummerFallM2M3[8]       0.000209 -2.03 2.14  0      
       64 eZSummerFallM2M3[9]       0.0203   -2.14 2.11  0.0213 
       65 eZSummerFallM2M3[10]      0.0196   -1.98 2.02  0.0331 
       66 eZSummerFallM2M3[11]     -0.0106   -1.96 2.03  0.0135 
       67 eZSummerFallMAFA[1]       0.0907   -1.91 2.06  0.110  
       68 eZSummerFallMAFA[2]      -0.250    -2.05 1.45  0.363  
       69 eZSummerFallMAFA[3]      -0.253    -2.08 1.50  0.386  
       70 eZSummerFallMAFA[4]      -0.208    -1.99 1.45  0.277  
       71 eZSummerFallMAFA[5]      -0.00740  -2.10 2.01  0.00578
       72 eZSummerFallMAFA[6]       0.0201   -1.85 2.03  0.0233 
       73 eZSummerFallMAFA[7]      -0.0494   -2.06 1.98  0.0709 
       74 eZSummerFallMAFA[8]       0.0248   -2.04 2.05  0.0311 
       75 eZSummerFallMAFA[9]       0.0423   -1.96 2.06  0.0589 
       76 eZSummerFallMAFA[10]      0.0171   -1.87 1.99  0.0233 
       77 eZSummerFallMAFA[11]     -0.0718   -1.96 1.87  0.0709 
       78 eZSummerFallYearling[1]   0.259    -1.61 2.11  0.322  
       79 eZSummerFallYearling[2]   0.130    -1.38 1.54  0.267  
       80 eZSummerFallYearling[3]  -0.516    -2.08 0.857 1.14   
       81 eZSummerFallYearling[4]  -1.14     -2.59 0.254 3.24   
       82 eZSummerFallYearling[5]   0.0135   -2.04 2.07  0.0194 
       83 eZSummerFallYearling[6]  -0.0420   -2.09 1.97  0.0409 
       84 eZSummerFallYearling[7]  -0.0254   -2.04 2.00  0.0252 
       85 eZSummerFallYearling[8]  -0.0417   -2.01 1.87  0.0409 
       86 eZSummerFallYearling[9]  -0.0260   -1.95 1.99  0.0409 
       87 eZSummerFallYearling[10] -0.0111   -1.94 1.93  0.0116 
       88 eZSummerFallYearling[11]  0.0377   -1.89 1.95  0.0449 
       89 eZWinAdult[1]            -0.0352   -1.99 1.90  0.0569 
       90 eZWinAdult[2]            -0.0169   -1.86 1.90  0.0272 
       91 eZWinAdult[3]             0.0576   -1.87 1.94  0.0350 
       92 eZWinAdult[4]             0.0211   -2.05 1.94  0.0350 
       93 eZWinAdult[5]             0.0227   -2.05 2.11  0.0469 
       94 eZWinAdult[6]            -0.0152   -1.87 1.96  0.0155 
       95 eZWinAdult[7]            -0.0408   -1.87 1.84  0.0449 
       96 eZWinAdult[8]            -0.0542   -1.93 1.73  0.0649 
       97 eZWinAdult[9]            -0.118    -2.02 1.75  0.148  
       98 eZWinAdult[10]           -0.0782   -1.99 1.87  0.0913 
       99 eZWinAdult[11]           -0.0332   -2.09 1.95  0.0370 
      100 eZWinCalf[1]             -0.0651   -2.13 2.03  0.0770 
      # i 76 more rows

---

    Code
      print(embr::coef(analysis, simplify = TRUE, param_type = "derived"), n = 100,
      width = 100)
    Output
      # A tibble: 328 x 5
          term                   estimate    lower    upper svalue
          <term>                    <dbl>    <dbl>    <dbl>  <dbl>
        1 bPopulationAnnual[1,1]  42.4    20.6      78.5      10.6
        2 bPopulationAnnual[2,1]  17.3     4.10     39.5      10.6
        3 bPopulationAnnual[3,1]  70.0    51.1      88.4      10.6
        4 bPopulationAnnual[4,1]  33.8    15.5      63.8      10.6
        5 bPopulationAnnual[5,1]  16.7     6.59     33.1      10.6
        6 bPopulationAnnual[6,1]   7.78    1.65     20.9      10.6
        7 bPopulationAnnual[7,1]  13.6     0.797    40.8      10.6
        8 bPopulationAnnual[8,1]  42.8    12.8      71.5      10.6
        9 bPopulationAnnual[1,2]  33.8    25.0      41.4      10.6
       10 bPopulationAnnual[2,2]  20.5     9.36     36.3      10.6
       11 bPopulationAnnual[3,2]  84.2    69.1      99.5      10.6
       12 bPopulationAnnual[4,2]  33.8    25.0      41.4      10.6
       13 bPopulationAnnual[5,2]  15.1     7.71     26.8      10.6
       14 bPopulationAnnual[6,2]  13.9     5.61     28.1      10.6
       15 bPopulationAnnual[7,2]   7.09    1.56     18.8      10.6
       16 bPopulationAnnual[8,2]  52.0    29.4      75.8      10.6
       17 bPopulationAnnual[1,3]  41.3    34.6      48.8      10.6
       18 bPopulationAnnual[2,3]  15.3     8.71     23.2      10.6
       19 bPopulationAnnual[3,3] 101.     86.9     116.       10.6
       20 bPopulationAnnual[4,3]  41.3    34.6      48.8      10.6
       21 bPopulationAnnual[5,3]  19.4    12.5      26.7      10.6
       22 bPopulationAnnual[6,3]  12.7     6.33     22.6      10.6
       23 bPopulationAnnual[7,3]  12.8     5.16     25.4      10.6
       24 bPopulationAnnual[8,3]  54.4    35.0      75.1      10.6
       25 bPopulationAnnual[1,4]  44.0    33.1      53.5      10.6
       26 bPopulationAnnual[2,4]  24.9    18.3      31.5      10.6
       27 bPopulationAnnual[3,4] 113.     97.0     130.       10.6
       28 bPopulationAnnual[4,4]  44.0    33.1      53.5      10.6
       29 bPopulationAnnual[5,4]  23.2    16.4      30.2      10.6
       30 bPopulationAnnual[6,4]  16.4    10.3      23.0      10.6
       31 bPopulationAnnual[7,4]  11.4     5.77     20.2      10.6
       32 bPopulationAnnual[8,4]  61.0    44.2      80.9      10.6
       33 bPropVecEvent[1,1]       0.106   0.0781    0.132    10.6
       34 bPropVecEvent[2,1]       0.120   0.104     0.138    10.6
       35 bPropVecEvent[3,1]       0.103   0.0826    0.125    10.6
       36 bPropVecEvent[4,1]       0.0910  0.0622    0.121    10.6
       37 bPropVecEvent[5,1]       0.111   0.0900    0.132    10.6
       38 bPropVecEvent[6,1]       0.0840  0.0540    0.116    10.6
       39 bPropVecEvent[7,1]       0.0750  0.0447    0.110    10.6
       40 bPropVecEvent[8,1]       0.106   0.0821    0.129    10.6
       41 bPropVecEvent[9,1]       0.109   0.0527    0.184    10.6
       42 bPropVecEvent[10,1]      0.0769  0.0469    0.111    10.6
       43 bPropVecEvent[11,1]      0.0850  0.0597    0.112    10.6
       44 bPropVecEvent[1,2]       0.0791  0.0367    0.138    10.6
       45 bPropVecEvent[2,2]       0.0512  0.0288    0.0772   10.6
       46 bPropVecEvent[3,2]       0.0756  0.0543    0.0961   10.6
       47 bPropVecEvent[4,2]       0.0794  0.0363    0.140    10.6
       48 bPropVecEvent[5,2]       0.0512  0.0288    0.0775   10.6
       49 bPropVecEvent[6,2]       0.0794  0.0364    0.139    10.6
       50 bPropVecEvent[7,2]       0.0792  0.0366    0.139    10.6
       51 bPropVecEvent[8,2]       0.0510  0.0286    0.0777   10.6
       52 bPropVecEvent[9,2]       0.0737  0.0183    0.162    10.6
       53 bPropVecEvent[10,2]      0.0792  0.0365    0.139    10.6
       54 bPropVecEvent[11,2]      0.0761  0.0531    0.0981   10.6
       55 bPropVecEvent[1,3]       0.343   0.287     0.400    10.6
       56 bPropVecEvent[2,3]       0.364   0.322     0.411    10.6
       57 bPropVecEvent[3,3]       0.364   0.323     0.407    10.6
       58 bPropVecEvent[4,3]       0.359   0.299     0.419    10.6
       59 bPropVecEvent[5,3]       0.379   0.333     0.428    10.6
       60 bPropVecEvent[6,3]       0.367   0.305     0.429    10.6
       61 bPropVecEvent[7,3]       0.378   0.313     0.443    10.6
       62 bPropVecEvent[8,3]       0.388   0.340     0.439    10.6
       63 bPropVecEvent[9,3]       0.349   0.246     0.447    10.6
       64 bPropVecEvent[10,3]      0.376   0.312     0.440    10.6
       65 bPropVecEvent[11,3]      0.389   0.340     0.435    10.6
       66 bPropVecEvent[1,4]       0.115   0.0859    0.139    10.6
       67 bPropVecEvent[2,4]       0.116   0.100     0.134    10.6
       68 bPropVecEvent[3,4]       0.105   0.0849    0.124    10.6
       69 bPropVecEvent[4,4]       0.105   0.0755    0.132    10.6
       70 bPropVecEvent[5,4]       0.106   0.0846    0.127    10.6
       71 bPropVecEvent[6,4]       0.100   0.0706    0.128    10.6
       72 bPropVecEvent[7,4]       0.0935  0.0629    0.123    10.6
       73 bPropVecEvent[8,4]       0.0993  0.0752    0.123    10.6
       74 bPropVecEvent[9,4]       0.0813  0.0424    0.137    10.6
       75 bPropVecEvent[10,4]      0.0951  0.0643    0.124    10.6
       76 bPropVecEvent[11,4]      0.0874  0.0633    0.112    10.6
       77 bPropVecEvent[1,5]       0.0584  0.0298    0.101    10.6
       78 bPropVecEvent[2,5]       0.0654  0.0425    0.0897   10.6
       79 bPropVecEvent[3,5]       0.0703  0.0503    0.0915   10.6
       80 bPropVecEvent[4,5]       0.0589  0.0300    0.101    10.6
       81 bPropVecEvent[5,5]       0.0655  0.0420    0.0895   10.6
       82 bPropVecEvent[6,5]       0.0590  0.0299    0.102    10.6
       83 bPropVecEvent[7,5]       0.0589  0.0294    0.103    10.6
       84 bPropVecEvent[8,5]       0.0655  0.0419    0.0901   10.6
       85 bPropVecEvent[9,5]       0.0712  0.0296    0.140    10.6
       86 bPropVecEvent[10,5]      0.0589  0.0294    0.103    10.6
       87 bPropVecEvent[11,5]      0.0712  0.0501    0.0926   10.6
       88 bPropVecEvent[1,6]       0.0552  0.0228    0.109    10.6
       89 bPropVecEvent[2,6]       0.0442  0.0223    0.0768   10.6
       90 bPropVecEvent[3,6]       0.0513  0.0324    0.0718   10.6
       91 bPropVecEvent[4,6]       0.0568  0.0234    0.112    10.6
       92 bPropVecEvent[5,6]       0.0450  0.0227    0.0785   10.6
       93 bPropVecEvent[6,6]       0.0575  0.0237    0.113    10.6
       94 bPropVecEvent[7,6]       0.0583  0.0239    0.114    10.6
       95 bPropVecEvent[8,6]       0.0453  0.0231    0.0796   10.6
       96 bPropVecEvent[9,6]       0.0361  0.00780   0.0923   10.6
       97 bPropVecEvent[10,6]      0.0581  0.0239    0.114    10.6
       98 bPropVecEvent[11,6]      0.0531  0.0334    0.0747   10.6
       99 bPropVecEvent[1,7]       0.0281  0.00613   0.0738   10.6
      100 bPropVecEvent[2,7]       0.0442  0.0179    0.0870   10.6
      # i 228 more rows

# analysis has warning messages with debug analysis mode, and debug snapshots

    Code
      print(embr::glance(analysis), n = 100, width = 100)
    Output
      # A tibble: 1 x 8
            n     K nchains niters nthin   ess  rhat converged
        <int> <int>   <int>  <int> <int> <int> <dbl> <lgl>    
      1    11    57       2     10     1     8  4.22 FALSE    

---

    Code
      print(embr::coef(analysis, simplify = TRUE, param_type = "fixed"), n = 100,
      width = 100)
    Output
      # A tibble: 57 x 5
         term                           estimate      lower   upper svalue
         <term>                            <dbl>      <dbl>   <dbl>  <dbl>
       1 bEtaSummerFall                   0.0904  0.00622     0.809  4.39 
       2 bEtaWin                          0.0727  0.0159      0.473  4.39 
       3 bFecundityReproductiveFA         2.37    1.30        2.88   4.39 
       4 bInitialMortalityCalfAnnual[1]  -4.26   -8.85       -0.944  4.39 
       5 bInitialMortalityCalfAnnual[2]  -3.45   -6.76       -1.60   4.39 
       6 bInitialMortalityCalfAnnual[3]  -3.32   -6.02       -1.73   4.39 
       7 bInitialMortalityCalfAnnual[4]   0.266  -2.81        1.28   0.305
       8 bKmWeekSummerFall                2.08    0.951       3.25   4.39 
       9 bKmWeekWin                       1.47    0.627       3.17   4.39 
      10 bMAProportion[1]                 0.497   0.281       0.567  4.39 
      11 bMAProportion[2]                 0.113   0.0190      0.379  4.39 
      12 bPopulationAbundanceInit       209.      0.225     280.     4.39 
      13 bPopulationF0Init               30.1    14.8        66.5    4.39 
      14 bPopulationF1Init               24.2     1.42       32.0    4.39 
      15 bPopulationFAInit               71.4    30.1        84.2    4.39 
      16 bPopulationM0Init               24.1    14.5        39.0    4.39 
      17 bPopulationM1Init               15.5     8.51       29.3    4.39 
      18 bPopulationM2Init               12.4     1.83       38.1    4.39 
      19 bPopulationM3Init               14.5     1.15       24.2    4.39 
      20 bPopulationMAInit               16.0     0.0000154  66.2    4.39 
      21 bPropReproductiveFA              0.965   0.866       0.998  4.39 
      22 bPropVecInit[1]                  0.141   0.0521      0.251  4.39 
      23 bPropVecInit[2]                  0.0706  0.0170      0.174  4.39 
      24 bPropVecInit[3]                  0.354   0.268       0.478  4.39 
      25 bPropVecInit[4]                  0.122   0.0565      0.192  4.39 
      26 bPropVecInit[5]                  0.0261  0.00117     0.112  4.39 
      27 bPropVecInit[6]                  0.0891  0.00484     0.235  4.39 
      28 bPropVecInit[7]                  0.0305  0.00345     0.167  4.39 
      29 bPropVecInit[8]                  0.128   0.000140    0.279  4.39 
      30 bRhoSummerFall                   0.688   0.107       3.10   4.39 
      31 bRhoWin                          0.921   0.0313      3.83   4.39 
      32 bSigmaSummerFall                 0.191   0.0775      0.673  4.39 
      33 bSigmaWin                        0.371   0.0768      0.951  4.39 
      34 bSurvBullAnnual[1]               2.48    1.90        3.47   4.39 
      35 bSurvBullAnnual[2]               2.54    1.44        3.38   4.39 
      36 bSurvBullAnnual[3]               2.58    1.70        3.97   4.39 
      37 bSurvBullAnnual[4]               2.79    1.77        3.55   4.39 
      38 bSurvF0Annual[1]                 0.338  -0.724       1.20   0.692
      39 bSurvF0Annual[2]                 0.211  -1.22        1.30   0.305
      40 bSurvF0Annual[3]                 0.609  -0.0207      1.10   2.81 
      41 bSurvF0Annual[4]                -0.284  -0.603       0.339  0.933
      42 bSurvF1Annual[1]                 2.10    1.52        3.04   4.39 
      43 bSurvF1Annual[2]                 1.62    1.22        2.20   4.39 
      44 bSurvF1Annual[3]                 2.07    1.07        2.59   4.39 
      45 bSurvF1Annual[4]                 1.59    1.01        2.27   4.39 
      46 bSurvFAAnnual[1]                 4.63    3.88        5.46   4.39 
      47 bSurvFAAnnual[2]                 4.75    4.17        5.23   4.39 
      48 bSurvFAAnnual[3]                 4.39    3.27        5.51   4.39 
      49 bSurvFAAnnual[4]                 4.55    3.56        5.12   4.39 
      50 bSurvM0Annual[1]                 0.218  -0.771       1.20   0.485
      51 bSurvM0Annual[2]                 0.251  -0.273       1.14   1.22 
      52 bSurvM0Annual[3]                 0.359  -0.557       0.938  1.58 
      53 bSurvM0Annual[4]                -0.0936 -0.799       0.533  0.485
      54 bSurvM1Annual[1]                 2.01    0.800       2.94   4.39 
      55 bSurvM1Annual[2]                 1.93    1.50        2.33   4.39 
      56 bSurvM1Annual[3]                 1.74    1.08        2.51   4.39 
      57 bSurvM1Annual[4]                 1.90    1.08        2.46   4.39 

---

    Code
      print(embr::coef(analysis, simplify = TRUE, param_type = "random"), n = 100,
      width = 100)
    Output
      # A tibble: 176 x 5
          term                     estimate  lower  upper svalue
          <term>                      <dbl>  <dbl>  <dbl>  <dbl>
        1 eZSummerFallAdult[1]      0.326   -1.63   1.38   0.144
        2 eZSummerFallAdult[2]     -0.428   -1.99   1.86   0.485
        3 eZSummerFallAdult[3]     -0.475   -1.59   0.719  0.692
        4 eZSummerFallAdult[4]     -0.421   -1.59   0.664  0.933
        5 eZSummerFallAdult[5]      0.191   -1.18   0.983  0.485
        6 eZSummerFallAdult[6]      0.383   -2.02   1.03   0.305
        7 eZSummerFallAdult[7]     -0.692   -1.29   1.32   0.692
        8 eZSummerFallAdult[8]      0.326   -1.68   1.77   0.305
        9 eZSummerFallAdult[9]     -0.277   -1.01   1.36   0.144
       10 eZSummerFallAdult[10]     0.521   -0.704  1.36   0.933
       11 eZSummerFallAdult[11]     0.393   -1.71   1.49   0.144
       12 eZSummerFallCalf[1]      -0.638   -2.04   0.485  0.692
       13 eZSummerFallCalf[2]      -0.770   -2.12   0.939  0.933
       14 eZSummerFallCalf[3]       0.260   -1.12   0.604  0.485
       15 eZSummerFallCalf[4]      -0.346   -2.28   0.943  0.692
       16 eZSummerFallCalf[5]      -0.288   -1.26   0.739  0.692
       17 eZSummerFallCalf[6]       0.669   -1.83   1.34   0.485
       18 eZSummerFallCalf[7]       0.452   -1.24   1.69   0.305
       19 eZSummerFallCalf[8]      -0.298   -0.823  1.14   0.933
       20 eZSummerFallCalf[9]       0.365   -0.533  2.57   0.485
       21 eZSummerFallCalf[10]      0.141   -1.92   1.41   0.305
       22 eZSummerFallCalf[11]     -0.0537  -1.03   1.78   0.144
       23 eZSummerFallF0M0[1]      -0.491   -1.90   1.18   0.933
       24 eZSummerFallF0M0[2]      -0.439   -2.26   1.02   0.692
       25 eZSummerFallF0M0[3]       0.563   -1.93   1.71   0.692
       26 eZSummerFallF0M0[4]      -0.368   -1.78   1.88   0.144
       27 eZSummerFallF0M0[5]      -0.424   -1.89   1.51   0.305
       28 eZSummerFallF0M0[6]      -0.312   -1.31   1.65   0.485
       29 eZSummerFallF0M0[7]      -0.0680  -1.91   1.08   0    
       30 eZSummerFallF0M0[8]      -0.745   -1.99   1.18   0.485
       31 eZSummerFallF0M0[9]      -0.273   -1.06   1.94   0.305
       32 eZSummerFallF0M0[10]     -0.595   -1.82   0.750  0.933
       33 eZSummerFallF0M0[11]      0.163   -1.45   0.706  0.305
       34 eZSummerFallF1M1[1]      -0.867   -1.71   1.91   0.692
       35 eZSummerFallF1M1[2]       0.0255  -1.11   3.08   0.485
       36 eZSummerFallF1M1[3]       0.00695 -1.43   1.03   0    
       37 eZSummerFallF1M1[4]      -0.548   -1.83   1.55   0.692
       38 eZSummerFallF1M1[5]      -0.0421  -2.12   0.727  0    
       39 eZSummerFallF1M1[6]       0.0541  -1.40   1.11   0    
       40 eZSummerFallF1M1[7]       0.698   -2.33   2.00   0.933
       41 eZSummerFallF1M1[8]       0.707   -1.39   1.99   0.144
       42 eZSummerFallF1M1[9]      -0.272   -1.22   1.36   0.305
       43 eZSummerFallF1M1[10]      0.195   -1.36   1.14   0    
       44 eZSummerFallF1M1[11]      0.278   -1.14   1.48   0.933
       45 eZSummerFallFABull[1]     0.206   -0.480  0.905  0.933
       46 eZSummerFallFABull[2]    -0.330   -2.33   1.81   0.692
       47 eZSummerFallFABull[3]     0.411   -1.58   1.62   0.485
       48 eZSummerFallFABull[4]     0.452   -1.66   1.60   0.305
       49 eZSummerFallFABull[5]     0.127   -1.92   1.33   0.305
       50 eZSummerFallFABull[6]     0.157   -1.74   1.70   0.305
       51 eZSummerFallFABull[7]    -0.632   -2.09   0.585  0.692
       52 eZSummerFallFABull[8]    -0.0998  -1.65   0.736  0.305
       53 eZSummerFallFABull[9]     0.202   -3.09   2.52   0.305
       54 eZSummerFallFABull[10]   -0.330   -1.71   1.35   0.692
       55 eZSummerFallFABull[11]    0.458   -1.34   1.61   0.933
       56 eZSummerFallM2M3[1]      -0.439   -1.26   0.853  0.933
       57 eZSummerFallM2M3[2]      -0.462   -1.28   0.695  0.485
       58 eZSummerFallM2M3[3]       0.383   -0.976  0.918  0.305
       59 eZSummerFallM2M3[4]      -0.0966  -1.35   1.47   0.144
       60 eZSummerFallM2M3[5]      -0.420   -1.38   1.49   0.305
       61 eZSummerFallM2M3[6]      -0.0854  -1.73   1.97   0.144
       62 eZSummerFallM2M3[7]      -0.115   -1.65   1.60   0.144
       63 eZSummerFallM2M3[8]      -0.893   -2.76   1.21   0.692
       64 eZSummerFallM2M3[9]       0.425   -1.21   1.90   0.305
       65 eZSummerFallM2M3[10]     -0.480   -1.84   1.08   1.22 
       66 eZSummerFallM2M3[11]     -0.0766  -1.53   1.91   0.144
       67 eZSummerFallMAFA[1]      -0.202   -1.33   2.50   0.305
       68 eZSummerFallMAFA[2]       0.0546  -1.13   1.54   0.144
       69 eZSummerFallMAFA[3]       0.178   -1.64   1.61   0.305
       70 eZSummerFallMAFA[4]      -1.01    -1.78   0.727  1.58 
       71 eZSummerFallMAFA[5]       0.344   -1.52   1.61   0.692
       72 eZSummerFallMAFA[6]      -0.368   -1.27   0.913  0.692
       73 eZSummerFallMAFA[7]      -0.351   -1.67   1.47   0.692
       74 eZSummerFallMAFA[8]      -0.166   -1.63   1.57   0.144
       75 eZSummerFallMAFA[9]       0.414   -1.27   1.23   0.692
       76 eZSummerFallMAFA[10]      0.228   -1.08   1.29   0.485
       77 eZSummerFallMAFA[11]      0.102   -2.50   1.88   0    
       78 eZSummerFallYearling[1]  -0.326   -1.74   1.26   0.305
       79 eZSummerFallYearling[2]   0.494   -0.895  2.09   1.22 
       80 eZSummerFallYearling[3]  -0.766   -1.96   0.235  1.58 
       81 eZSummerFallYearling[4]  -1.60    -2.27  -0.518  4.39 
       82 eZSummerFallYearling[5]   0.169   -2.28   1.88   0.144
       83 eZSummerFallYearling[6]   0.0330  -0.997  1.97   0    
       84 eZSummerFallYearling[7]  -0.453   -2.28   2.51   0.692
       85 eZSummerFallYearling[8]   0.431   -0.849  2.10   0.692
       86 eZSummerFallYearling[9]   0.812   -1.65   1.60   0.485
       87 eZSummerFallYearling[10]  0.477   -1.86   2.12   0.933
       88 eZSummerFallYearling[11] -0.00486 -1.83   1.23   0    
       89 eZWinAdult[1]            -0.707   -1.44   1.32   1.22 
       90 eZWinAdult[2]            -0.250   -0.755  1.27   0.485
       91 eZWinAdult[3]            -0.315   -1.26   1.55   1.22 
       92 eZWinAdult[4]             0.156   -1.41   1.11   0.485
       93 eZWinAdult[5]            -0.368   -1.63   1.00   0.933
       94 eZWinAdult[6]             0.125   -0.765  1.41   0.485
       95 eZWinAdult[7]            -0.551   -1.29   1.68   0.305
       96 eZWinAdult[8]            -0.662   -1.68   1.95   0.485
       97 eZWinAdult[9]             0.273   -0.885  1.36   0.485
       98 eZWinAdult[10]           -1.39    -2.57   1.63   0.933
       99 eZWinAdult[11]           -0.163   -1.14   1.06   0.305
      100 eZWinCalf[1]              0.157   -1.45   1.99   0.144
      # i 76 more rows

---

    Code
      print(embr::coef(analysis, simplify = TRUE, param_type = "derived"), n = 100,
      width = 100)
    Output
      # A tibble: 328 x 5
          term                   estimate      lower    upper svalue
          <term>                    <dbl>      <dbl>    <dbl>  <dbl>
        1 bPopulationAnnual[1,1]  30.1    14.8        66.5      4.39
        2 bPopulationAnnual[2,1]  24.2     1.42       32.0      4.39
        3 bPopulationAnnual[3,1]  71.4    30.1        84.2      4.39
        4 bPopulationAnnual[4,1]  24.1    14.5        39.0      4.39
        5 bPopulationAnnual[5,1]  15.5     8.51       29.3      4.39
        6 bPopulationAnnual[6,1]  12.4     1.83       38.1      4.39
        7 bPopulationAnnual[7,1]  14.5     1.15       24.2      4.39
        8 bPopulationAnnual[8,1]  16.0     0.0000154  66.2      4.39
        9 bPopulationAnnual[1,2]  31.6    23.5        43.2      4.39
       10 bPopulationAnnual[2,2]  15.8     8.63       32.3      4.39
       11 bPopulationAnnual[3,2]  83.7    54.7        98.2      4.39
       12 bPopulationAnnual[4,2]  31.6    23.5        43.2      4.39
       13 bPopulationAnnual[5,2]  12.4     9.04       18.4      4.39
       14 bPopulationAnnual[6,2]  13.2     7.85       23.9      4.39
       15 bPopulationAnnual[7,2]  11.2     1.70       35.0      4.39
       16 bPopulationAnnual[8,2]  30.4     5.59       70.4      4.39
       17 bPopulationAnnual[1,3]  39.8    27.2        49.1      4.39
       18 bPopulationAnnual[2,3]  17.4     7.00       23.8      4.39
       19 bPopulationAnnual[3,3]  99.3    64.9       115.       4.39
       20 bPopulationAnnual[4,3]  39.8    27.2        49.1      4.39
       21 bPopulationAnnual[5,3]  18.6    13.1        24.0      4.39
       22 bPopulationAnnual[6,3]  11.0     7.95       16.0      4.39
       23 bPopulationAnnual[7,3]  12.2     7.41       23.0      4.39
       24 bPopulationAnnual[8,3]  44.8    21.7        65.8      4.39
       25 bPopulationAnnual[1,4]  42.7    34.4        57.6      4.39
       26 bPopulationAnnual[2,4]  23.8    18.6        34.8      4.39
       27 bPopulationAnnual[3,4] 113.     78.8       130.       4.39
       28 bPopulationAnnual[4,4]  42.7    34.4        57.6      4.39
       29 bPopulationAnnual[5,4]  22.0    15.6        28.3      4.39
       30 bPopulationAnnual[6,4]  15.8    10.9        20.3      4.39
       31 bPopulationAnnual[7,4]  10.4     7.27       14.4      4.39
       32 bPopulationAnnual[8,4]  52.1    32.6        69.7      4.39
       33 bPropVecEvent[1,1]       0.121   0.0731      0.147    4.39
       34 bPropVecEvent[2,1]       0.121   0.111       0.145    4.39
       35 bPropVecEvent[3,1]       0.107   0.0902      0.130    4.39
       36 bPropVecEvent[4,1]       0.106   0.0560      0.141    4.39
       37 bPropVecEvent[5,1]       0.113   0.103       0.142    4.39
       38 bPropVecEvent[6,1]       0.100   0.0472      0.139    4.39
       39 bPropVecEvent[7,1]       0.0936  0.0373      0.136    4.39
       40 bPropVecEvent[8,1]       0.108   0.0950      0.139    4.39
       41 bPropVecEvent[9,1]       0.0959  0.0617      0.166    4.39
       42 bPropVecEvent[10,1]      0.0947  0.0392      0.136    4.39
       43 bPropVecEvent[11,1]      0.0874  0.0698      0.113    4.39
       44 bPropVecEvent[1,2]       0.0680  0.0426      0.123    4.39
       45 bPropVecEvent[2,2]       0.0646  0.0227      0.0986   4.39
       46 bPropVecEvent[3,2]       0.0757  0.0644      0.0998   4.39
       47 bPropVecEvent[4,2]       0.0688  0.0426      0.122    4.39
       48 bPropVecEvent[5,2]       0.0641  0.0225      0.0982   4.39
       49 bPropVecEvent[6,2]       0.0690  0.0425      0.121    4.39
       50 bPropVecEvent[7,2]       0.0692  0.0423      0.120    4.39
       51 bPropVecEvent[8,2]       0.0638  0.0224      0.0979   4.39
       52 bPropVecEvent[9,2]       0.116   0.00700     0.224    4.39
       53 bPropVecEvent[10,2]      0.0692  0.0423      0.120    4.39
       54 bPropVecEvent[11,2]      0.0762  0.0650      0.102    4.39
       55 bPropVecEvent[1,3]       0.363   0.320       0.399    4.39
       56 bPropVecEvent[2,3]       0.370   0.323       0.424    4.39
       57 bPropVecEvent[3,3]       0.373   0.331       0.403    4.39
       58 bPropVecEvent[4,3]       0.380   0.332       0.421    4.39
       59 bPropVecEvent[5,3]       0.384   0.332       0.442    4.39
       60 bPropVecEvent[6,3]       0.389   0.338       0.432    4.39
       61 bPropVecEvent[7,3]       0.400   0.346       0.447    4.39
       62 bPropVecEvent[8,3]       0.392   0.338       0.453    4.39
       63 bPropVecEvent[9,3]       0.375   0.240       0.434    4.39
       64 bPropVecEvent[10,3]      0.398   0.344       0.444    4.39
       65 bPropVecEvent[11,3]      0.398   0.351       0.428    4.39
       66 bPropVecEvent[1,4]       0.128   0.0883      0.141    4.39
       67 bPropVecEvent[2,4]       0.118   0.102       0.133    4.39
       68 bPropVecEvent[3,4]       0.108   0.0920      0.125    4.39
       69 bPropVecEvent[4,4]       0.119   0.0795      0.133    4.39
       70 bPropVecEvent[5,4]       0.108   0.0857      0.122    4.39
       71 bPropVecEvent[6,4]       0.113   0.0750      0.129    4.39
       72 bPropVecEvent[7,4]       0.104   0.0677      0.125    4.39
       73 bPropVecEvent[8,4]       0.102   0.0762      0.116    4.39
       74 bPropVecEvent[9,4]       0.0775  0.0536      0.107    4.39
       75 bPropVecEvent[10,4]      0.106   0.0694      0.126    4.39
       76 bPropVecEvent[11,4]      0.0866  0.0703      0.112    4.39
       77 bPropVecEvent[1,5]       0.0552  0.0387      0.0768   4.39
       78 bPropVecEvent[2,5]       0.0712  0.0454      0.0901   4.39
       79 bPropVecEvent[3,5]       0.0718  0.0491      0.0828   4.39
       80 bPropVecEvent[4,5]       0.0563  0.0393      0.0770   4.39
       81 bPropVecEvent[5,5]       0.0714  0.0452      0.0908   4.39
       82 bPropVecEvent[6,5]       0.0564  0.0395      0.0771   4.39
       83 bPropVecEvent[7,5]       0.0565  0.0396      0.0771   4.39
       84 bPropVecEvent[8,5]       0.0712  0.0450      0.0912   4.39
       85 bPropVecEvent[9,5]       0.0745  0.0532      0.182    4.39
       86 bPropVecEvent[10,5]      0.0565  0.0396      0.0771   4.39
       87 bPropVecEvent[11,5]      0.0735  0.0478      0.0863   4.39
       88 bPropVecEvent[1,6]       0.0561  0.0421      0.135    4.39
       89 bPropVecEvent[2,6]       0.0429  0.0297      0.0588   4.39
       90 bPropVecEvent[3,6]       0.0547  0.0356      0.0692   4.39
       91 bPropVecEvent[4,6]       0.0578  0.0434      0.139    4.39
       92 bPropVecEvent[5,6]       0.0439  0.0301      0.0597   4.39
       93 bPropVecEvent[6,6]       0.0586  0.0437      0.141    4.39
       94 bPropVecEvent[7,6]       0.0597  0.0440      0.144    4.39
       95 bPropVecEvent[8,6]       0.0447  0.0304      0.0603   4.39
       96 bPropVecEvent[9,6]       0.0652  0.00830     0.193    4.39
       97 bPropVecEvent[10,6]      0.0595  0.0440      0.143    4.39
       98 bPropVecEvent[11,6]      0.0578  0.0366      0.0720   4.39
       99 bPropVecEvent[1,7]       0.0508  0.00676     0.146    4.39
      100 bPropVecEvent[2,7]       0.0460  0.0337      0.111    4.39
      # i 228 more rows

