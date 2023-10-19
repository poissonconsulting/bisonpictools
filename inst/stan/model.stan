data {
  int <lower=0> nObs;
  int <lower=0> nclass;
  int <lower=0> nannual;
  int <lower=0> nannual_minus_1;
  int <lower=0> nseason;
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
  int <lower=0, upper=365> doy[nObs];
  
  int <lower=0> ncensus;
  real <lower=0> census[ncensus];
  real <lower=0> sCensus[ncensus];
  int <lower=1, upper=365> doy_census[ncensus];
  int <lower=0> annual_census[ncensus];

  int <lower=0> nprop_calf;
  real <lower=0, upper=1> prop_calf[nprop_calf];
  real <lower=0> sPropCalf[nprop_calf];
  int <lower=1, upper=365> doy_prop_calf[nprop_calf];
  int <lower=0> annual_prop_calf[nprop_calf];
}

// Bull = M2, M3, MA
// FA = reproductive and non-reproductive cows 
// Adult = FA, M2, M3, MA, UA

parameters {
  real bSurvF0Annual[nannual]; // Annual fixed effect of survival on female calves
  real bSurvF1Annual[nannual]; // Annual fixed effect of survival on female yearlings
  real bSurvFAAnnual[nannual]; // Annual fixed effect of survival on cows
  real bSurvM0Annual[nannual]; // Annual fixed effect of survival on male calves
  real bSurvM1Annual[nannual]; // Annual fixed effect of survival on male yearlings
  real bSurvBullAnnual[nannual]; // Annual fixed effect of survival on bulls
  real <lower=0> bPopulationAbundanceInit; // Abundance of entire herd in initial study year
  real <lower=0> bPopulationF0Init; // Abundance of female calves in initial study year
  real <lower=0> bPopulationF1Init; // Abundance of female yearlings in initial study year
  real <lower=0> bPopulationFAInit; // Abundance of female 2+ yo in initial study year
  real <lower=0> bPopulationM0Init; // Abundance of male calves in initial study year
  real <lower=0> bPopulationM1Init; // Abundance of male yearlings in initial study year
  real <lower=0> bPopulationM2Init; // Abundance of male 2yo in initial study year
  real <lower=0> bPopulationM3Init; // Abundance of male 3yo in initial study year
  real <lower=0> bPopulationMAInit; // Abundance of male 4+ yo in initial study year
  simplex [nclass] bPropVecInit; // Simplex describing proportions of individuals in each class in initial study year
  real <lower=0, upper=1> bPropReproductiveFA; // Proportion of cows that are reproductive
  real bFecundityReproductiveFA; // Fecundity of adult females
  real bInitialMortalityCalfAnnual[nannual]; // Annual fixed effect of initial calf mortality
  real <lower=0, upper=1> bMAPresence[nseason]; // Seasonal probability of MAs being present with mixed groups
}

transformed parameters {
  // Setup holding variables for derived parameters
  // Those starting with "b" are saved, those starting with "e" are not
  
  // Annual
  simplex[nclass] bPropVecAnnual[nannual];
  matrix <lower=0> [nclass, nannual] bPopulationAnnual; // Population abundances on Apr. 1

  matrix <lower=0, upper=1> [nclass, nclass] eSurvivalMatrixAnnual[nannual];
  matrix <lower=0, upper=1> [nclass, nclass] eBirthMatrix[nannual];
  matrix <lower=0, upper=1> [nclass, nclass] eAgeMatrix;

  real <lower=0, upper=1> eSurvF0Annual[nannual];
  real <lower=0, upper=1> eSurvF1Annual[nannual];
  real <lower=0, upper=1> eSurvFAAnnual[nannual];
  real <lower=0, upper=1> eSurvM0Annual[nannual];
  real <lower=0, upper=1> eSurvM1Annual[nannual];
  real <lower=0, upper=1> eSurvBullAnnual[nannual];
  
  real <lower=0, upper=1> eFecundityFA;
  real <lower=0, upper=1> eInitialMortalityAnnual[nannual];
  
  // Day of year
  simplex[nclass] bPropVecDoy[nObs];
  matrix <lower=0> [nclass, nObs] ePopulationDoy;

  real <lower=0, upper=1> eSurvF0Doy[nObs];
  real <lower=0, upper=1> eSurvF1Doy[nObs];
  real <lower=0, upper=1> eSurvFADoy[nObs];
  real <lower=0, upper=1> eSurvM0Doy[nObs];
  real <lower=0, upper=1> eSurvM1Doy[nObs];
  real <lower=0, upper=1> eSurvBullDoy[nObs];

  matrix <lower=0, upper=1> [nclass, nclass] eSurvivalMatrixDoy[nObs];
  
  // Mar 31 - to derive ratios at the stable point at the end of the year.
  real <lower=0, upper=1> eSurvF0Mar31[nannual];
  real <lower=0, upper=1> eSurvF1Mar31[nannual];
  real <lower=0, upper=1> eSurvFAMar31[nannual];
  real <lower=0, upper=1> eSurvM0Mar31[nannual];
  real <lower=0, upper=1> eSurvM1Mar31[nannual];
  real <lower=0, upper=1> eSurvBullMar31[nannual];

  matrix <lower=0, upper=1> [nclass, nclass] eSurvivalMatrixMar31[nannual];

  simplex[nclass] bPropVecMar31[nannual];
  matrix <lower=0> [nclass, nannual] ePopulationMar31;

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
    eBirthMatrix[i] = diag_matrix(rep_vector(1.0, nclass));
    eBirthMatrix[i, 1, 1] = 0.0;
    eBirthMatrix[i, 4, 4] = 0.0;
    eBirthMatrix[i, 1, 3] = eFecundityFA * 0.5 * bPropReproductiveFA * (1 - eInitialMortalityAnnual[i]);
    eBirthMatrix[i, 4, 3] = eFecundityFA * 0.5 * bPropReproductiveFA * (1 - eInitialMortalityAnnual[i]);
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
    bPopulationAnnual[, i] = eBirthMatrix[i - 1] * eAgeMatrix * eSurvivalMatrixAnnual[i - 1] * bPopulationAnnual[, (i - 1)];
  }

  // Derive proportions in age classes
  for (i in 1:nannual) {
    for (j in 1:nclass) {
      bPropVecAnnual[i, j] = bPopulationAnnual[j, i] / sum(bPopulationAnnual[, i]);
    }
  }

  // DOY
  for (i in 1:nObs) {
    eSurvF0Doy[i] = eSurvF0Annual[annual[i]]^(doy[i] / 365.0);
    eSurvF1Doy[i] = eSurvF1Annual[annual[i]]^(doy[i] / 365.0);
    eSurvFADoy[i] = eSurvFAAnnual[annual[i]]^(doy[i] / 365.0);
    eSurvM0Doy[i] = eSurvM0Annual[annual[i]]^(doy[i] / 365.0);
    eSurvM1Doy[i] = eSurvM1Annual[annual[i]]^(doy[i] / 365.0);
    eSurvBullDoy[i] = eSurvBullAnnual[annual[i]]^(doy[i] / 365.0);

    eSurvivalMatrixDoy[i] = diag_matrix([eSurvF0Doy[i], eSurvF1Doy[i], eSurvFADoy[i], eSurvM0Doy[i], eSurvM1Doy[i], eSurvBullDoy[i], eSurvBullDoy[i], eSurvBullDoy[i]]');
  }

  // Doy updating
  for (i in 1:nObs) {
    ePopulationDoy[, i] = eSurvivalMatrixDoy[i] * bPopulationAnnual[, annual[i]]; // Assumes exponential decay in popn classes thru year
  }

   // Derive proportions in age classes by day of year
  for (i in 1:nObs) {
    for (j in 1:nclass) {
      bPropVecDoy[i, j] = ePopulationDoy[j, i] / sum(ePopulationDoy[, i]);
    }
  }

  // Save proportions for March 31
  for (i in 1:nannual) {
    eSurvF0Mar31[i] = eSurvF0Annual[i];
    eSurvF1Mar31[i] = eSurvF1Annual[i];
    eSurvFAMar31[i] = eSurvFAAnnual[i];
    eSurvM0Mar31[i] = eSurvM0Annual[i];
    eSurvM1Mar31[i] = eSurvM1Annual[i];
    eSurvBullMar31[i] = eSurvBullAnnual[i];
    
    eSurvivalMatrixMar31[i] = diag_matrix([eSurvF0Mar31[i], eSurvF1Mar31[i], eSurvFAMar31[i], eSurvM0Mar31[i], eSurvM1Mar31[i], eSurvBullMar31[i], eSurvBullMar31[i], eSurvBullMar31[i]]');
    
    ePopulationMar31[, i] = eSurvivalMatrixMar31[i] * bPopulationAnnual[, i];
    
    for (j in 1:nclass) {
      bPropVecMar31[i, j] = ePopulationMar31[j, i] / sum(ePopulationMar31[, i]);
    }
  }

  // Census
  for (i in 1:ncensus) {
    eSurvF0Census[i] = eSurvF0Annual[annual_census[i]]^(doy_census[i] / 365.0);
    eSurvF1Census[i] = eSurvF1Annual[annual_census[i]]^(doy_census[i] / 365.0);
    eSurvFACensus[i] = eSurvFAAnnual[annual_census[i]]^(doy_census[i] / 365.0);
    eSurvM0Census[i] = eSurvM0Annual[annual_census[i]]^(doy_census[i] / 365.0);
    eSurvM1Census[i] = eSurvM1Annual[annual_census[i]]^(doy_census[i] / 365.0);
    eSurvBullCensus[i] = eSurvBullAnnual[annual_census[i]]^(doy_census[i] / 365.0);

    eSurvivalMatrixCensus[i] = diag_matrix([eSurvF0Census[i], eSurvF1Census[i], eSurvFACensus[i], eSurvM0Census[i], eSurvM1Census[i], eSurvBullCensus[i], eSurvBullCensus[i], eSurvBullCensus[i]]');

    ePopulationCensus[, i] = eSurvivalMatrixCensus[i] * bPopulationAnnual[, annual_census[i]];
  }

  // Proportion of calves
  for (i in 1:nprop_calf) {
    eSurvF0PropCalf[i] = eSurvF0Annual[annual_prop_calf[i]]^(doy_prop_calf[i] / 365.0);
    eSurvF1PropCalf[i] = eSurvF1Annual[annual_prop_calf[i]]^(doy_prop_calf[i] / 365.0);
    eSurvFAPropCalf[i] = eSurvFAAnnual[annual_prop_calf[i]]^(doy_prop_calf[i] / 365.0);
    eSurvM0PropCalf[i] = eSurvM0Annual[annual_prop_calf[i]]^(doy_prop_calf[i] / 365.0);
    eSurvM1PropCalf[i] = eSurvM1Annual[annual_prop_calf[i]]^(doy_prop_calf[i] / 365.0);
    eSurvBullPropCalf[i] = eSurvBullAnnual[annual_prop_calf[i]]^(doy_prop_calf[i] / 365.0);

    eSurvivalMatrixPropCalf[i] = diag_matrix([eSurvF0PropCalf[i], eSurvF1PropCalf[i], eSurvFAPropCalf[i], eSurvM0PropCalf[i], eSurvM1PropCalf[i], eSurvBullPropCalf[i], eSurvBullPropCalf[i], eSurvBullPropCalf[i]]');

    ePopulationPropCalf[, i] = eSurvivalMatrixPropCalf[i] * bPopulationAnnual[, annual_prop_calf[i]];

    for (j in 1:nclass) {
      ePropVecPropCalf[i, j] = ePopulationPropCalf[j, i] / sum(ePopulationPropCalf[, i]);
    }
  }
}

model {
  real eF0[nObs];
  real eM0[nObs];
  real eF1[nObs];
  real eM1[nObs];
  real eFA[nObs];
  real eM2[nObs];
  real eM3[nObs];
  real eMA[nObs];
  real eCalf[nObs];
  real eYearling[nObs];
  real eAdult[nObs];
  
  real ePropF0[nObs];
  real ePropF1[nObs];
  real ePropFA[nObs];
  real ePropM2M3[nObs];
  real ePropFAMA[nObs];
  
  // bMAPresence ~ beta(5, 5); // Mildly informative around 0.5
  // Do a sensitivity test on this with a Normal!
  
  bMAPresence[1] ~ normal(0.45, 0.1) T[0, 1];
  bMAPresence[2] ~ normal(0.1, 0.1) T[0, 1];
  
  // Values based on literature
  // SD terms chosen to give moderately informative priors
  bSurvF0Annual ~ normal(logit(0.44), 0.5);
  bSurvM0Annual ~ normal(logit(0.44), 0.5);
  bSurvF1Annual ~ normal(logit(0.85), 0.5);
  bSurvM1Annual ~ normal(logit(0.85), 0.5);
  bSurvFAAnnual ~ normal(logit(0.94), 0.5);
  bSurvBullAnnual ~ normal(logit(0.92), 0.5);
  
  bInitialMortalityCalfAnnual ~ normal(0, 2);
  
  bFecundityReproductiveFA ~ normal(logit(0.81), 0.5);
  bPropReproductiveFA ~ beta(15, 2); // A normal distribution might make more sense here

  bPopulationAbundanceInit ~ normal(300, 100) T[0, ];
  
  bPropVecInit[1] ~ normal(0.15, 0.05) T[0, 1];
  bPropVecInit[2] ~ normal(0.1, 0.05) T[0, 1];
  bPropVecInit[3] ~ normal(0.25, 0.05) T[0, 1];
  bPropVecInit[4] ~ normal(0.15, 0.05) T[0, 1];
  bPropVecInit[5] ~ normal(0.1, 0.05) T[0, 1];
  bPropVecInit[6] ~ normal(0.05, 0.05) T[0, 1];
  bPropVecInit[7] ~ normal(0.05, 0.05) T[0, 1];
  bPropVecInit[8] ~ normal(0.2, 0.05) T[0, 1];
  // bPropVecInit ~ dirichlet(rep_vector(1, nclass)); # Uninformative prior
  // See if we could be more informative about this.
  // Never more calves than females.
  // Could try for an even sex ratio.
    // Calves, yearlings, adults could have same prop. by sex.
  
  bPopulationF0Init ~ normal(bPopulationAbundanceInit * bPropVecInit[1], 5) T[0, ];
  bPopulationF1Init ~ normal(bPopulationAbundanceInit * bPropVecInit[2], 5) T[0, ];
  bPopulationFAInit ~ normal(bPopulationAbundanceInit * bPropVecInit[3], 5) T[0, ];
  bPopulationM0Init ~ normal(bPopulationAbundanceInit * bPropVecInit[4], 5) T[0, ];
  bPopulationM1Init ~ normal(bPopulationAbundanceInit * bPropVecInit[5], 5) T[0, ];
  bPopulationM2Init ~ normal(bPopulationAbundanceInit * bPropVecInit[6], 5) T[0, ];
  bPopulationM3Init ~ normal(bPopulationAbundanceInit * bPropVecInit[7], 5) T[0, ];
  bPopulationMAInit ~ normal(bPopulationAbundanceInit * bPropVecInit[8], 5) T[0, ];
  
  for (i in 1:ncensus) { 
    census[i] ~ normal(sum(ePopulationCensus[, i]), sCensus[i]) T[0, ];
  }

  for (i in 1:nprop_calf) {
    prop_calf[i] ~ normal(ePropVecPropCalf[i, 1] + ePropVecPropCalf[i, 4], sPropCalf[i]) T[0, 1];
  }

  for (i in 1:nObs) {
    eCalf[i] = groupsize_total[i] * bPropVecDoy[i, 1] + groupsize_total[i] * bPropVecDoy[i, 4];
    ePropF0[i] = bPropVecDoy[i, 1] / (bPropVecDoy[i, 1] + bPropVecDoy[i, 4]);
    f0[i] ~ binomial(f0[i] + m0[i], ePropF0[i]);

    eYearling[i] = groupsize_total[i] * bPropVecDoy[i, 2] + groupsize_total[i] * bPropVecDoy[i, 5];
    ePropF1[i] = bPropVecDoy[i, 2] / (bPropVecDoy[i, 2] + bPropVecDoy[i, 5]);
    f1[i] ~ binomial(f1[i] + m1[i], ePropF1[i]);

    eFA[i] = groupsize_total[i] * bPropVecDoy[i, 3];

    eM2[i] = groupsize_total[i] * bPropVecDoy[i, 6];
    eM3[i] = groupsize_total[i] * bPropVecDoy[i, 7];
    eMA[i] = groupsize_total[i] * bPropVecDoy[i, 8] * bMAPresence[season[i]];

    eAdult[i] = eFA[i] + eM2[i] + eM3[i] + eMA[i];

    // Ratios of known sex
    // Proportion of females in "adults" (fa, m2, m3, ma)
    ePropFA[i] = bPropVecDoy[i, 3] / (bPropVecDoy[i, 3] + bPropVecDoy[i, 6] + bPropVecDoy[i, 7] + (bPropVecDoy[i, 8] * bMAPresence[season[i]]));
    fa[i] ~ binomial(fa[i] + m2[i] + m3[i] + ma[i], ePropFA[i]);

    // M2:M3 Ratio
    ePropM2M3[i] = bPropVecDoy[i, 6] / (bPropVecDoy[i, 6] + bPropVecDoy[i, 7]);
    m2[i] ~ binomial(m2[i] + m3[i], ePropM2M3[i]);

    // MA:FA ratio
    ePropFAMA[i] = (bPropVecDoy[i, 8] * bMAPresence[season[i]]) / (bPropVecDoy[i, 3] + bPropVecDoy[i, 8] * bMAPresence[season[i]]);
    ma[i] ~ binomial(fa[i] + ma[i], ePropFAMA[i]);
    
  }
  
  // Multinomial must be **mutually exclusive events**
  calf ~ poisson(eCalf);
  yearling ~ poisson(eYearling);
  adult ~ poisson(eAdult);
}
