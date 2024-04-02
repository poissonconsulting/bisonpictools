functions{
  matrix cov_GPL2(matrix x, real eta, real rho, real sigma) {
    int N = dims(x)[1];
    real eta2 = square(eta);
    real sigma2 = square(sigma);
    real rho2 = square(rho);
    matrix[N, N] K;
    for (i in 1:(N-1)) {
      K[i, i] = eta2 + sigma2;
      for (j in (i + 1):N) {
        K[i, j] = eta2 * exp(-rho2 * square(x[i, j]));
        K[j, i] = K[i, j];
      }
    }
    K[N, N] = eta2 + sigma2;
    return K;
  }
}

data {
  int <lower=0> nObs;
  int <lower=0> nclass;
  int <lower=0> nannual;
  int <lower=0> nseason;
  int <lower=0> nseason_annual;
  int <lower=0> nlocation;
  int <lower=0> nlocation_weekfac;
  
  int <lower=0> f0[nObs];
  int <lower=0> m0[nObs];
  int <lower=0> calf[nObs];
  int <lower=0> f1[nObs];
  int <lower=0> m1[nObs];
  int <lower=0> yearling[nObs];
  int <lower=0> m2[nObs];
  int <lower=0> m3[nObs];
  int <lower=0> ma[nObs];
  int <lower=0> fa[nObs];
  int <lower=0> adult[nObs];
  int <lower=0> groupsize_total[nObs]; 
  int <lower=0> annual[nObs];
  int <lower=0> season[nObs];
  int <lower=0> season_annual[nObs];
  int <lower=0, upper=366> doy[nObs];
  int <lower=0> location[nObs];
  int <lower=0> location_weekfac[nObs];
  
  matrix[nlocation, nlocation] location_distance;
  int <lower=0> lookup_location[nlocation_weekfac];
  int <lower=0> lookup_week[nlocation_weekfac];
  
  int <lower=0> ncensus;
  real <lower=0> census[ncensus];
  real <lower=0> sCensus[ncensus];
  int <lower=1, upper=366> doy_census[ncensus];
  int <lower=0> annual_census[ncensus];

  int <lower=0> nprop_calf;
  real <lower=0, upper=1> prop_calf[nprop_calf];
  real <lower=0> sPropCalf[nprop_calf];
  int <lower=1, upper=366> doy_prop_calf[nprop_calf];
  int <lower=0> annual_prop_calf[nprop_calf];
}

// Bull = M2, M3, MA
// FA = reproductive and non-reproductive cows 
// Adult = FA, M2, M3, MA, UA

parameters {
  real bSurvF0Annual[nannual];
  real bSurvF1Annual[nannual];
  real bSurvFAAnnual[nannual];
  real bSurvM0Annual[nannual];
  real bSurvM1Annual[nannual];
  real bSurvBullAnnual[nannual];
  real <lower=0> bPopulationAbundanceInit;
  real <lower=0> bPopulationF0Init; 
  real <lower=0> bPopulationF1Init; 
  real <lower=0> bPopulationFAInit; 
  real <lower=0> bPopulationM0Init; 
  real <lower=0> bPopulationM1Init; 
  real <lower=0> bPopulationM2Init; 
  real <lower=0> bPopulationM3Init; 
  real <lower=0> bPopulationMAInit; 
  simplex [nclass] bPropVecInit;
  real <lower=0, upper=1> bPropReproductiveFA; 
  real bFecundityReproductiveFA; 
  real bInitialMortalityCalfAnnual[nannual]; 
  real <lower=0, upper=1> bMAProportion[nseason]; 
  
  real <lower=0> bKmWeekSummerFall;
  real <lower=0> bKmWeekWin;
  
  real <lower=0> bEtaSummerFall;
  real <lower=0> bRhoSummerFall;
  real <lower=0> bSigmaSummerFall;

  real <lower=0> bEtaWin;
  real <lower=0> bRhoWin;
  real <lower=0> bSigmaWin;
  
  vector[nlocation_weekfac] eZSummerFallF0M0;
  vector[nlocation_weekfac] eZSummerFallF1M1;
  vector[nlocation_weekfac] eZSummerFallFABull;
  vector[nlocation_weekfac] eZSummerFallM2M3;
  vector[nlocation_weekfac] eZSummerFallMAFA;
  vector[nlocation_weekfac] eZSummerFallCalf;
  vector[nlocation_weekfac] eZSummerFallYearling;
  vector[nlocation_weekfac] eZSummerFallAdult;
  
  vector[nlocation_weekfac] eZWinF0M0;
  vector[nlocation_weekfac] eZWinF1M1;
  vector[nlocation_weekfac] eZWinFABull;
  vector[nlocation_weekfac] eZWinM2M3;
  vector[nlocation_weekfac] eZWinMAFA;
  vector[nlocation_weekfac] eZWinCalf;
  vector[nlocation_weekfac] eZWinYearling;
  vector[nlocation_weekfac] eZWinAdult;
}

transformed parameters {
  // Setup holding variables for derived parameters
  // Annual
  simplex[nclass] bPropVecAnnual[nannual];
  matrix <lower=0> [nclass, nannual] bPopulationAnnual; // Population abundances on Apr. 1

  matrix <lower=0, upper=1> [nclass, nclass] eSurvivalMatrixAnnual[nannual];
  matrix <lower=0, upper=1> [nclass, nclass] eBirthMatrixAnnual[nannual];
  matrix <lower=0, upper=1> [nclass, nclass] eAgeMatrix;

  real <lower=0, upper=1> eSurvF0Annual[nannual];
  real <lower=0, upper=1> eSurvF1Annual[nannual];
  real <lower=0, upper=1> eSurvFAAnnual[nannual];
  real <lower=0, upper=1> eSurvM0Annual[nannual];
  real <lower=0, upper=1> eSurvM1Annual[nannual];
  real <lower=0, upper=1> eSurvBullAnnual[nannual];
  
  real <lower=0, upper=1> eFecundityFA;
  real <lower=0, upper=1> eInitialMortalityAnnual[nannual];
  
  // Event
  simplex[nclass] bPropVecEvent[nObs];
  matrix <lower=0> [nclass, nObs] ePopulationEvent;

  real <lower=0, upper=1> eSurvF0Event[nObs];
  real <lower=0, upper=1> eSurvF1Event[nObs];
  real <lower=0, upper=1> eSurvFAEvent[nObs];
  real <lower=0, upper=1> eSurvM0Event[nObs];
  real <lower=0, upper=1> eSurvM1Event[nObs];
  real <lower=0, upper=1> eSurvBullEvent[nObs];

  matrix <lower=0, upper=1> [nclass, nclass] eSurvivalMatrixEvent[nObs];
  
  // Mar 31 - to derive ratios at the stable point at the end of the year.
  simplex[nclass] bPropVecMar31[nannual];
  matrix <lower=0> [nclass, nannual] ePopulationMar31; // Population abundances on Mar 31

  // Incorporate census data
  matrix <lower=0> [nclass, ncensus] ePopulationCensus;

  real <lower=0, upper=1> eSurvF0Census[ncensus];
  real <lower=0, upper=1> eSurvF1Census[ncensus];
  real <lower=0, upper=1> eSurvFACensus[ncensus];
  real <lower=0, upper=1> eSurvM0Census[ncensus];
  real <lower=0, upper=1> eSurvM1Census[ncensus];
  real <lower=0, upper=1> eSurvBullCensus[ncensus];

  matrix <lower=0, upper=1> [nclass, nclass] eSurvivalMatrixCensus[ncensus];

  // Incorporate data on proportion of calves
  simplex[nclass] ePropVecPropCalf[nprop_calf];
  matrix <lower=0> [nclass, nprop_calf] ePopulationPropCalf;

  real <lower=0, upper=1> eSurvF0PropCalf[nprop_calf];
  real <lower=0, upper=1> eSurvF1PropCalf[nprop_calf];
  real <lower=0, upper=1> eSurvFAPropCalf[nprop_calf];
  real <lower=0, upper=1> eSurvM0PropCalf[nprop_calf];
  real <lower=0, upper=1> eSurvM1PropCalf[nprop_calf];
  real <lower=0, upper=1> eSurvBullPropCalf[nprop_calf];

  matrix <lower=0, upper=1> [nclass, nclass] eSurvivalMatrixPropCalf[nprop_calf];
  
  // Covariance structure
  matrix[nlocation_weekfac, nseason] bSpaceTimeF0M0;
  matrix[nlocation_weekfac, nseason] bSpaceTimeF1M1;
  matrix[nlocation_weekfac, nseason] bSpaceTimeFABull;
  matrix[nlocation_weekfac, nseason] bSpaceTimeM2M3;
  matrix[nlocation_weekfac, nseason] bSpaceTimeMAFA;
  matrix[nlocation_weekfac, nseason] bSpaceTimeCalf;
  matrix[nlocation_weekfac, nseason] bSpaceTimeYearling;
  matrix[nlocation_weekfac, nseason] bSpaceTimeAdult;
  
  matrix[nlocation_weekfac, nlocation_weekfac] eDistanceMatSummerFall;
  matrix[nlocation_weekfac, nlocation_weekfac] eCovMatSummerFall;
  matrix[nlocation_weekfac, nlocation_weekfac] eLCovMatSummerFall;
  
  matrix[nlocation_weekfac, nlocation_weekfac] eDistanceMatWin;
  matrix[nlocation_weekfac, nlocation_weekfac] eCovMatWin;
  matrix[nlocation_weekfac, nlocation_weekfac] eLCovMatWin;
  
  // Calculate derived parameters
  bPopulationAnnual[, 1] = [bPopulationF0Init, bPopulationF1Init, bPopulationFAInit, bPopulationM0Init, bPopulationM1Init, bPopulationM2Init, bPopulationM3Init, bPopulationMAInit]';
  
  for (i in 1:nannual) {
    eSurvF0Annual[i] = inv_logit(bSurvF0Annual[i]);
    eSurvM0Annual[i] = inv_logit(bSurvM0Annual[i]);
    eSurvF1Annual[i] = inv_logit(bSurvF1Annual[i]);
    eSurvM1Annual[i] = inv_logit(bSurvM1Annual[i]);
    eSurvFAAnnual[i] = inv_logit(bSurvFAAnnual[i]);
    eSurvBullAnnual[i] = inv_logit(bSurvBullAnnual[i]);

    eSurvivalMatrixAnnual[i] = diag_matrix([eSurvF0Annual[i], eSurvF1Annual[i], eSurvFAAnnual[i], eSurvM0Annual[i], eSurvM1Annual[i], eSurvBullAnnual[i], eSurvBullAnnual[i], eSurvBullAnnual[i]]');
  }
  
  eFecundityFA = inv_logit(bFecundityReproductiveFA);
  
  for (i in 1:nannual) {
    eInitialMortalityAnnual[i] = inv_logit(bInitialMortalityCalfAnnual[i]);
    eBirthMatrixAnnual[i] = diag_matrix(rep_vector(1.0, nclass));
    eBirthMatrixAnnual[i, 1, 1] = 0.0;
    eBirthMatrixAnnual[i, 4, 4] = 0.0;
    eBirthMatrixAnnual[i, 1, 3] = eFecundityFA * 0.5 * bPropReproductiveFA * (1 - eInitialMortalityAnnual[i]);
    eBirthMatrixAnnual[i, 4, 3] = eFecundityFA * 0.5 * bPropReproductiveFA * (1 - eInitialMortalityAnnual[i]);
  }
  
  eAgeMatrix = diag_matrix(rep_vector(0.0, nclass));
  eAgeMatrix[2, 1] = 1.0;
  eAgeMatrix[3, 2] = 1.0;
  eAgeMatrix[3, 3] = 1.0;
  eAgeMatrix[5, 4] = 1.0;
  eAgeMatrix[6, 5] = 1.0;
  eAgeMatrix[7, 6] = 1.0;
  eAgeMatrix[8, 7] = 1.0;
  eAgeMatrix[8, 8] = 1.0;

  // Population model
  for (i in 2:nannual) {
    bPopulationAnnual[, i] = eBirthMatrixAnnual[i - 1] * eAgeMatrix * eSurvivalMatrixAnnual[i - 1] * bPopulationAnnual[, (i - 1)];
  }

  // Derive proportions in age classes
  for (i in 1:nannual) {
    for (j in 1:nclass) {
      bPropVecAnnual[i, j] = bPopulationAnnual[j, i] / sum(bPopulationAnnual[, i]);
    }
  }

  // Update survival for each event by day of year
  for (i in 1:nObs) {
    eSurvF0Event[i] = eSurvF0Annual[annual[i]]^(doy[i] / 365.25);
    eSurvF1Event[i] = eSurvF1Annual[annual[i]]^(doy[i] / 365.25);
    eSurvFAEvent[i] = eSurvFAAnnual[annual[i]]^(doy[i] / 365.25);
    eSurvM0Event[i] = eSurvM0Annual[annual[i]]^(doy[i] / 365.25);
    eSurvM1Event[i] = eSurvM1Annual[annual[i]]^(doy[i] / 365.25);
    eSurvBullEvent[i] = eSurvBullAnnual[annual[i]]^(doy[i] / 365.25);

    eSurvivalMatrixEvent[i] = diag_matrix([eSurvF0Event[i], eSurvF1Event[i], eSurvFAEvent[i], eSurvM0Event[i], eSurvM1Event[i], eSurvBullEvent[i], eSurvBullEvent[i], eSurvBullEvent[i]]');
  }

  // Update population for each event
  for (i in 1:nObs) {
    // Assumes exponential decay in population classes through year
    ePopulationEvent[, i] = eSurvivalMatrixEvent[i] * bPopulationAnnual[, annual[i]]; 
  }

   // Derive proportions in age classes for each event
  for (i in 1:nObs) {
    for (j in 1:nclass) {
      bPropVecEvent[i, j] = ePopulationEvent[j, i] / sum(ePopulationEvent[, i]);
    }
  }

  // Save proportions for March 31
  for (i in 1:nannual) {
    ePopulationMar31[, i] = eSurvivalMatrixAnnual[i] * bPopulationAnnual[, i];
    for (j in 1:nclass) {
      bPropVecMar31[i, j] = ePopulationMar31[j, i] / sum(ePopulationMar31[, i]);
    }
  }

  // Census
  for (i in 1:ncensus) {
    eSurvF0Census[i] = eSurvF0Annual[annual_census[i]]^(doy_census[i] / 365.25);
    eSurvF1Census[i] = eSurvF1Annual[annual_census[i]]^(doy_census[i] / 365.25);
    eSurvFACensus[i] = eSurvFAAnnual[annual_census[i]]^(doy_census[i] / 365.25);
    eSurvM0Census[i] = eSurvM0Annual[annual_census[i]]^(doy_census[i] / 365.25);
    eSurvM1Census[i] = eSurvM1Annual[annual_census[i]]^(doy_census[i] / 365.25);
    eSurvBullCensus[i] = eSurvBullAnnual[annual_census[i]]^(doy_census[i] / 365.25);

    eSurvivalMatrixCensus[i] = diag_matrix([eSurvF0Census[i], eSurvF1Census[i], eSurvFACensus[i], eSurvM0Census[i], eSurvM1Census[i], eSurvBullCensus[i], eSurvBullCensus[i], eSurvBullCensus[i]]');

    ePopulationCensus[, i] = eSurvivalMatrixCensus[i] * bPopulationAnnual[, annual_census[i]];
  }

  // Proportion of calves
  for (i in 1:nprop_calf) {
    eSurvF0PropCalf[i] = eSurvF0Annual[annual_prop_calf[i]]^(doy_prop_calf[i] / 365.25);
    eSurvF1PropCalf[i] = eSurvF1Annual[annual_prop_calf[i]]^(doy_prop_calf[i] / 365.25);
    eSurvFAPropCalf[i] = eSurvFAAnnual[annual_prop_calf[i]]^(doy_prop_calf[i] / 365.25);
    eSurvM0PropCalf[i] = eSurvM0Annual[annual_prop_calf[i]]^(doy_prop_calf[i] / 365.25);
    eSurvM1PropCalf[i] = eSurvM1Annual[annual_prop_calf[i]]^(doy_prop_calf[i] / 365.25);
    eSurvBullPropCalf[i] = eSurvBullAnnual[annual_prop_calf[i]]^(doy_prop_calf[i] / 365.25);

    eSurvivalMatrixPropCalf[i] = diag_matrix([eSurvF0PropCalf[i], eSurvF1PropCalf[i], eSurvFAPropCalf[i], eSurvM0PropCalf[i], eSurvM1PropCalf[i], eSurvBullPropCalf[i], eSurvBullPropCalf[i], eSurvBullPropCalf[i]]');

    ePopulationPropCalf[, i] = eSurvivalMatrixPropCalf[i] * bPopulationAnnual[, annual_prop_calf[i]];

    for (j in 1:nclass) {
      ePropVecPropCalf[i, j] = ePopulationPropCalf[j, i] / sum(ePopulationPropCalf[, i]);
    }
  }
  
  // Covariance structure
  for (i in 1:(nlocation_weekfac - 1)) {
    for (j in (i + 1):nlocation_weekfac) {
      // bKmWeek___ is the scaling factor that converts weeks to km
      eDistanceMatSummerFall[i, j] = sqrt((location_distance[lookup_location[i], lookup_location[j]])^2 +
      (bKmWeekSummerFall * abs(lookup_week[i] - lookup_week[j]))^2);
      eDistanceMatSummerFall[j, i] = eDistanceMatSummerFall[i, j];
      
      eDistanceMatWin[i, j] = sqrt((location_distance[lookup_location[i], lookup_location[j]])^2 +
      (bKmWeekWin * abs(lookup_week[i] - lookup_week[j]))^2);
      eDistanceMatWin[j, i] = eDistanceMatWin[i, j];
    }
  }
  
  for (i in 1:nlocation_weekfac) {
    eDistanceMatSummerFall[i, i] = 0.0;
    eDistanceMatWin[i, i] = 0.0;
  }
  
  eCovMatSummerFall = cov_GPL2(eDistanceMatSummerFall, bEtaSummerFall, bRhoSummerFall, bSigmaSummerFall);
  eLCovMatSummerFall = cholesky_decompose(eCovMatSummerFall);
  
  bSpaceTimeF0M0[, 1] = eLCovMatSummerFall * eZSummerFallF0M0;
  bSpaceTimeF1M1[, 1] = eLCovMatSummerFall * eZSummerFallF1M1;
  bSpaceTimeFABull[, 1] = eLCovMatSummerFall * eZSummerFallFABull;
  bSpaceTimeM2M3[, 1] = eLCovMatSummerFall * eZSummerFallM2M3;
  bSpaceTimeMAFA[, 1] = eLCovMatSummerFall * eZSummerFallMAFA;
  bSpaceTimeCalf[, 1] = eLCovMatSummerFall * eZSummerFallCalf;
  bSpaceTimeYearling[, 1] = eLCovMatSummerFall * eZSummerFallYearling;
  bSpaceTimeAdult[, 1] = eLCovMatSummerFall * eZSummerFallAdult;
  
  eCovMatWin = cov_GPL2(eDistanceMatWin, bEtaWin, bRhoWin, bSigmaWin);
  eLCovMatWin = cholesky_decompose(eCovMatWin);
  
  bSpaceTimeF0M0[, 2] = eLCovMatWin * eZWinF0M0;
  bSpaceTimeF1M1[, 2] = eLCovMatWin * eZWinF1M1;
  bSpaceTimeFABull[, 2] = eLCovMatWin * eZWinFABull;
  bSpaceTimeM2M3[, 2] = eLCovMatWin * eZWinM2M3;
  bSpaceTimeMAFA[, 2] = eLCovMatWin * eZWinMAFA;
  bSpaceTimeCalf[, 2] = eLCovMatWin * eZWinCalf;
  bSpaceTimeYearling[, 2] = eLCovMatWin * eZWinYearling;
  bSpaceTimeAdult[, 2] = eLCovMatWin * eZWinAdult;
}

model {
  real ePropCalf[nObs];
  real ePropYearling[nObs];
  real ePropAdult[nObs];

  real ePropF0M0[nObs];
  real ePropF1M1[nObs];
  real ePropFABull[nObs];
  real ePropM2M3[nObs];
  real ePropMAFA[nObs];

  bMAProportion[1] ~ normal(0.45, 0.1) T[0, 1];
  bMAProportion[2] ~ normal(0.1, 0.1) T[0, 1];

  // Values based on literature
  // SD terms chosen to give moderately informative priors
  bSurvF0Annual ~ normal(logit(0.44), 0.5);
  bSurvM0Annual ~ normal(logit(0.44), 0.5);
  bSurvF1Annual ~ normal(logit(0.85), 0.5);
  bSurvM1Annual ~ normal(logit(0.85), 0.5);
  bSurvFAAnnual ~ normal(logit(0.99), 0.5); # More informative prior from survival analysis
  bSurvBullAnnual ~ normal(logit(0.92), 0.5);

  bInitialMortalityCalfAnnual ~ normal(0, 3);

  bFecundityReproductiveFA ~ normal(logit(0.81), 0.5);
  bPropReproductiveFA ~ normal(0.9, 0.2) T[0, 1];

  bPopulationAbundanceInit ~ normal(300, 100) T[0, ];

  bPropVecInit[1] ~ normal(0.10, 0.1) T[0, 1];
  bPropVecInit[2] ~ normal(0.05, 0.1) T[0, 1];
  bPropVecInit[3] ~ normal(0.40, 0.1) T[0, 1];
  bPropVecInit[4] ~ normal(0.10, 0.1) T[0, 1];
  bPropVecInit[5] ~ normal(0.05, 0.1) T[0, 1];
  bPropVecInit[6] ~ normal(0.05, 0.1) T[0, 1];
  bPropVecInit[7] ~ normal(0.05, 0.1) T[0, 1];
  bPropVecInit[8] ~ normal(0.20, 0.1) T[0, 1];

  bPopulationF0Init ~ normal(bPopulationAbundanceInit * bPropVecInit[1], 5) T[0, ];
  bPopulationF1Init ~ normal(bPopulationAbundanceInit * bPropVecInit[2], 5) T[0, ];
  bPopulationFAInit ~ normal(bPopulationAbundanceInit * bPropVecInit[3], 5) T[0, ];
  bPopulationM0Init ~ normal(bPopulationAbundanceInit * bPropVecInit[4], 5) T[0, ];
  bPopulationM1Init ~ normal(bPopulationAbundanceInit * bPropVecInit[5], 5) T[0, ];
  bPopulationM2Init ~ normal(bPopulationAbundanceInit * bPropVecInit[6], 5) T[0, ];
  bPopulationM3Init ~ normal(bPopulationAbundanceInit * bPropVecInit[7], 5) T[0, ];
  bPopulationMAInit ~ normal(bPopulationAbundanceInit * bPropVecInit[8], 5) T[0, ];

  bKmWeekSummerFall ~ normal(2, 1) T[0, ];
  bKmWeekWin ~ normal(2, 1) T[0, ];
  
  bEtaSummerFall ~ exponential(1);
  bRhoSummerFall ~ exponential(1);
  bSigmaSummerFall ~ exponential(1);
  
  bEtaWin ~ exponential(1);
  bRhoWin ~ exponential(1);
  bSigmaWin ~ exponential(1);

  eZSummerFallF0M0 ~ std_normal();
  eZSummerFallF1M1 ~ std_normal();
  eZSummerFallFABull ~ std_normal();
  eZSummerFallM2M3 ~ std_normal();
  eZSummerFallMAFA ~ std_normal();
  eZSummerFallCalf ~ std_normal();
  eZSummerFallYearling ~ std_normal();
  eZSummerFallAdult ~ std_normal();

  eZWinF0M0 ~ std_normal();
  eZWinF1M1 ~ std_normal();
  eZWinFABull ~ std_normal();
  eZWinM2M3 ~ std_normal();
  eZWinMAFA ~ std_normal();
  eZWinCalf ~ std_normal();
  eZWinYearling ~ std_normal();
  eZWinAdult ~ std_normal();
  
  for (i in 1:ncensus) { 
    census[i] ~ normal(sum(ePopulationCensus[, i]), sCensus[i]) T[0, ];
  }

  for (i in 1:nprop_calf) {
    prop_calf[i] ~ normal(ePropVecPropCalf[i, 1] + ePropVecPropCalf[i, 4], sPropCalf[i]) T[0, 1];
  }

  for (i in 1:nObs) {
    // Calves
    ePropCalf[i] = inv_logit(
      logit(bPropVecEvent[i, 1] + bPropVecEvent[i, 4]) * 
      exp(bSpaceTimeCalf[location_weekfac[i], season[i]])
    );
    calf[i] ~ binomial(groupsize_total[i], ePropCalf[i]);

    // Yearlings
    ePropYearling[i] = inv_logit(
      logit(bPropVecEvent[i, 2] + bPropVecEvent[i, 5]) * 
      exp(bSpaceTimeYearling[location_weekfac[i], season[i]])
    );
    yearling[i] ~ binomial(groupsize_total[i], ePropYearling[i]);
   
    // Adults
    ePropAdult[i] = inv_logit(
      logit(bPropVecEvent[i, 3] + bPropVecEvent[i, 6] + bPropVecEvent[i, 7] + (bPropVecEvent[i, 8] * bMAProportion[season[i]])) * 
      exp(bSpaceTimeAdult[location_weekfac[i], season[i]])
    );
    adult[i] ~ binomial(groupsize_total[i], ePropAdult[i]);
    

    // Ratios of known sex
    // Proportion of female calves
    ePropF0M0[i] = inv_logit(
      logit(bPropVecEvent[i, 1] / (bPropVecEvent[i, 1] + bPropVecEvent[i, 4])) *
      exp(bSpaceTimeF0M0[location_weekfac[i], season[i]])
    );
    f0[i] ~ binomial(f0[i] + m0[i], ePropF0M0[i]);
    
    // Proportion of male calves
    ePropF1M1[i] = inv_logit(
      logit(bPropVecEvent[i, 2] / (bPropVecEvent[i, 2] + bPropVecEvent[i, 5])) *
      exp(bSpaceTimeF1M1[location_weekfac[i], season[i]])
    );
    f1[i] ~ binomial(f1[i] + m1[i], ePropF1M1[i]);

    // Proportion of females in "adults" (fa, m2, m3, ma)
    ePropFABull[i] = inv_logit(
        logit(bPropVecEvent[i, 3] /
        (bPropVecEvent[i, 3] + bPropVecEvent[i, 6] + bPropVecEvent[i, 7] + (bPropVecEvent[i, 8] * bMAProportion[season[i]]))) *
        exp(bSpaceTimeFABull[location_weekfac[i], season[i]])
    );
    fa[i] ~ binomial(fa[i] + m2[i] + m3[i] + ma[i], ePropFABull[i]);

    // M2:M3 Ratio
    ePropM2M3[i] = inv_logit(
        logit(bPropVecEvent[i, 6] / (bPropVecEvent[i, 6] + bPropVecEvent[i, 7])) *
        exp(bSpaceTimeM2M3[location_weekfac[i], season[i]])
    );
    m2[i] ~ binomial(m2[i] + m3[i], ePropM2M3[i]);

    // MA:FA ratio
    ePropMAFA[i] = inv_logit(
        logit((bPropVecEvent[i, 8] * bMAProportion[season[i]]) /
        (bPropVecEvent[i, 3] + (bPropVecEvent[i, 8] * bMAProportion[season[i]]))) *
        exp(bSpaceTimeMAFA[location_weekfac[i], season[i]])
    );
    ma[i] ~ binomial(fa[i] + ma[i], ePropMAFA[i]);
  }
}
