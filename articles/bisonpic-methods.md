# Analytic Methods for Estimating Wood Bison Ratios, Survival and Fecundity Rates, and Abundance

    #> Registered S3 method overwritten by 'mcmcr':
    #>   method         from 
    #>   as.mcmc.nlists nlist

## Introduction to the Study System

Alberta Environment and Protected Areas wishes to monitor the status of
the Ronald Lake wood bison herd in northern Alberta, Canada. A
combination of annual aerial surveys and camera traps along the herd’s
migration corridor have been used to collect data on the status of the
herd. The aerial surveys take place once a year, usually near the end of
March. These surveys produce estimates of the total herd size, as well
as the proportion of calves in the herd. The camera traps collect data
year-round, recording photographs upon the detection of nearby movement.
Researchers are able to classify the individuals in the photographs
captured during a camera trap “event”, here defined as a series of
photographs of the same group of wood bison in front of the same camera,
into classes by age and sex, as shown in Table 1. In the text to follow,
“bull(s)” will refer to the set of M2, M3, and MA individuals.

| Class | Description                          |
|:------|:-------------------------------------|
| F0    | Female calves                        |
| F1    | Female yearlings                     |
| FA    | Female adults (includes 2+year-olds) |
| M0    | Male calves                          |
| M1    | Male yearlings                       |
| M2    | Male 2-year-olds                     |
| M3    | Male 3-year-olds                     |
| MA    | Male 4+year-olds                     |
| U0    | Unknown sex calves                   |
| U1    | Unknown sex yearlings                |
| UA    | Unknown sex adults                   |
| FU    | Unknown age females                  |
| MU    | Unknown age males                    |
| UU    | Individuals of unknown age and sex   |

Table 1. Classification of wood bison individuals from camera trap
events. {.table}

## Modelling Approach

### Integrated Population Model

An integrated population model (IPM) was chosen to combine
stage-structured population projection matrix models with multiple
sources of data into a unified framework, allowing for estimates of
age-sex class ratios, population vital rates, and abundances, while
maintaining the correct propagation of uncertainty (Schaub and Kéry
2022). The sources of data used in this model include the classified
counts from the camera trap events, and two estimates derived from
aerial surveys of the herd: a “census” estimate of the entire herd size
and an estimate of the proportion of calves in the entire herd.

### Birth-Age Incrementation-Survival (BAS) Population Projection Matrix Model

Population projection matrices provide a simple way to model population
dynamics through time (Newman et al. 2014). The population projection
matrix summarizes the probabilities of transitioning from each stage to
every other stage, using vital rates from demographic processes such as
births, age incrementation, and survival.

In this system, there are 8 stages, corresponding to the first 8 rows in
Table 1. The other classes in Table 1 do not represent true stages,
rather the individuals’ sexes and/or ages are simply unknown. The
abundances of each stage during the t^{th} study year can be described
by a vector, \mathbf{n}\_t, which is composed of the numbers of
individuals in each of the stages during that study year (F0_t, F1_t,
etc.).

\mathbf{n_t} = \begin{bmatrix} F0\_{t} \\ F1\_{t} \\ FA\_{t} \\ M0\_{t}
\\ M1\_{t} \\ M2\_{t} \\ M3\_{t} \\ MA\_{t} \\ \end{bmatrix}

To ease model formulation, the population projection matrix can be
broken up into subprocess matrices (Newman et al. 2014). Each subprocess
has a separate matrix: in this model, the \mathbf{B} matrix describes
the stochastic birth process, the \mathbf{A} matrix describes the
deterministic age incrementation process, and the \mathbf{S} matrix
describes the stochastic survival process.

To get the vector of stage-wise abundances in the next study year,
\mathbf{n}\_{t+1}, we multiply the subprocess matrices together in
reverse chronological order, and then by the vector of stage-wise
abundances in the current study year, \mathbf{n}\_{t}. In this model, we
assume that survival occurs first, then age incrementation, and finally
births, resulting in the \mathbf{BAS} multiplication order. We also
assume that the fecundity rate is fixed and that the survival rates vary
by study year.

\mathbf{n}\_{t+1} = \mathbf{BAS}\_{t}\mathbf{n}\_{t}

With the full population abundance vectors and subprocess matrices, we
arrive at the following:

\begin{split} \begin{bmatrix} F0\_{t+1} \\ F1\_{t+1} \\ FA\_{t+1} \\
M0\_{t+1} \\ M1\_{t+1} \\ M2\_{t+1} \\ M3\_{t+1} \\ MA\_{t+1} \\
\end{bmatrix} = & \begin{bmatrix} 0 & 0 & \frac{fp_f}{2} & 0 & 0 & 0 & 0
& 0 \\ 0 & 1 & 0 & 0 & 0 & 0 & 0 & 0 \\ 0 & 0 & 1 & 0 & 0 & 0 & 0 & 0 \\
0 & 0 & \frac{fp_f}{2} & 0 & 0 & 0 & 0 & 0 \\ 0 & 0 & 0 & 0 & 1 & 0 & 0
& 0 \\ 0 & 0 & 0 & 0 & 0 & 1 & 0 & 0 \\ 0 & 0 & 0 & 0 & 0 & 0 & 1 & 0 \\
0 & 0 & 0 & 0 & 0 & 0 & 0 & 1 \\ \end{bmatrix} \times \begin{bmatrix} 0
& 0 & 0 & 0 & 0 & 0 & 0 & 0 \\ 1 & 0 & 0 & 0 & 0 & 0 & 0 & 0 \\ 0 & 1 &
1 & 0 & 0 & 0 & 0 & 0 \\ 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 \\ 0 & 0 & 0 & 1
& 0 & 0 & 0 & 0 \\ 0 & 0 & 0 & 0 & 1 & 0 & 0 & 0 \\ 0 & 0 & 0 & 0 & 0 &
1 & 0 & 0 \\ 0 & 0 & 0 & 0 & 0 & 0 & 1 & 1 \\ \end{bmatrix} \times \\ &
\begin{bmatrix} \phi\_{F0_t}&0&0&0&0&0&0&0 \\ 0 & \phi\_{F1_t} & 0 & 0 &
0 & 0 & 0 & 0 \\ 0 & 0 & \phi\_{FA_t} & 0 & 0 & 0 & 0 & 0 \\ 0 & 0 & 0 &
\phi\_{M0_t} & 0 & 0 & 0 & 0 \\ 0 & 0 & 0 & 0 & \phi\_{M1_t} & 0 & 0 & 0
\\ 0 & 0 & 0 & 0 & 0 & \phi\_{Bull_t} & 0 & 0 \\ 0 & 0 & 0 & 0 & 0 & 0 &
\phi\_{Bull_t} & 0 \\ 0 & 0 & 0 & 0 & 0 & 0 & 0 & \phi\_{Bull_t} \\
\end{bmatrix} \times \begin{bmatrix} F0\_{t} \\ F1\_{t} \\ FA\_{t} \\
M0\_{t} \\ M1\_{t} \\ M2\_{t} \\ M3\_{t} \\ MA\_{t} \\ \end{bmatrix}
\end{split}

where f represents the fecundity rate, p_f represents the proportion of
fecund FA individuals, and each of the \phi_t terms represent the annual
survival rate of their respective stage. M2s, M3s, and MAs all share a
survival rate, \phi\_{Bull}. The \mathbf{n}\_t stage-wise abundance
vectors represent the *expected* number of individuals in each stage in
the t^{th} study year.

Diffuse priors were used to provide the model with stage-wise abundances
in the initial study year as a starting point. From there, the
population projection matrix was used to update the stage-wise
abundances in each subsequent study year. The study year was set to
begin on April 1 of each year because that marks the beginning of the
calving season. As such, the above process occurs at midnight on March
31 of each year.

Observations from camera traps occur throughout the study year, but the
above stage-wise abundance and proportion vectors are the expected
values on April 1. To ensure the correct abundances and proportions were
used to model this continuous data, the expected abundances and
proportions were calculated for the day of the study year of each camera
trap event. This involved using an exponential relationship between the
expected annual survival rate for the j^{th} class, \phi\_{j,t}, and the
day of the study year of the i^{th} camera trap event, d_i, to calculate
the expected survival rates for the j^{th} class on day of the i^{th}
event, \phi\_{i,j}:

\phi\_{j,i} = (\phi\_{j,t})^\frac{d_i}{365.25}

These survival rates were used to update the abundances for each camera
trap event using a calculation similar to the projection matrix above:

\mathbf{n_i} = \mathbf{S_in_t}

where \mathbf{n}\_t is the stage-wise abundance vector in the study year
of the i^{th} camera trap event, and \mathbf{S_i} is the survival matrix
with the updated survival rates:

\mathbf{S_i} = \begin{bmatrix} \phi\_{F0_i}&0&0&0&0&0&0&0 \\ 0 &
\phi\_{F1_i} & 0 & 0 & 0 & 0 & 0 & 0 \\ 0 & 0 & \phi\_{FA_i} & 0 & 0 & 0
& 0 & 0 \\ 0 & 0 & 0 & \phi\_{M0_i} & 0 & 0 & 0 & 0 \\ 0 & 0 & 0 & 0 &
\phi\_{M1_i} & 0 & 0 & 0 \\ 0 & 0 & 0 & 0 & 0 & \phi\_{Bull_i} & 0 & 0
\\ 0 & 0 & 0 & 0 & 0 & 0 & \phi\_{Bull_i} & 0 \\ 0 & 0 & 0 & 0 & 0 & 0 &
0 & \phi\_{Bull_i} \\ \end{bmatrix}

By dividing the expected abundance of the j^{th} stage on the date of
the i^{th} camera trap event, \mathbf{n}\_{j,i} by the total expected
abundance on the day of the i^{th} event (i.e., the sum of the
stage-wise abundances), we can derive the expected proportion of
individuals in each stage on that day. The proportion of the population
represented by the j^{th} stage during the i^{th} event, p\_{j,i} is:

p\_{j,i} = \frac{\mathbf{n}\_{j,i}}{\sum\_{j = 1}^J \mathbf{n}\_{j,i}}

where J is the total number of stages (8). The vector of these
proportions, \mathbf{p}\_i, will be used to model the data from camera
trap events and the estimated proportion of calves from aerial surveys.
By rule, each vector of \mathbf{p}\_i values sums to 1.

### Camera Trap Event Data

We assume that each camera trap event represents a random draw from the
entire population, with the same expected proportions in the small mixed
groups captured in the cameras as in the overall population.

Several components of the model include seasonal variation. The three
seasons chosen for this herd are the calving season (April-June), the
summer/fall (July-November), and the winter (December-March).

Camera trap observations that occur during the calving season are
excluded from the analysis to avoid bias associated with uncertainty in
the transition period during which the calves start being classified as
yearlings, and because the herd migrates northward during the calving
season, away from the set of camera traps. To ensure that the survival
rates of the calves, \phi\_{F0} and \phi\_{M0}, represent the true
annual survival rates, an additional probability of initial mortality of
calves was incorporated. This allows the calves to undergo higher
mortality when first born compared to the rest of the study year, which
is more biologically realistic.

MA individuals are known to go off on their own or form small bachelor
groups (Komers et al. 1992). This was accounted for in the model by
assuming that only a proportion of MAs are present in the mixed groups,
and that this proportion varies seasonally. This proportion will be
denoted by r_s for the s^{th} season. The MAs are expected to spend more
time with the other members of the herd in the summer/fall than the
winter (Komers et al. 1992). Camera trap events that detect only bulls
are excluded from the analysis, because they do not represent a random
draw of individuals from the total population.

An ideal way to model the camera trap data would be to use a multinomial
distribution to model the probabilities that the individuals captured
during a camera trap event belong to each of the stages. However, a
considerable percentage of individuals (~20%) were not sexed, and were
only classified as unknown calf (U0), unknown yearling (U1), or unknown
adult (UA). A series of binomial distributions were used instead to
model the count information (including the unsexed individuals) and
ratio information (excluding the unsexed individuals) separately, in
order to incorporate the valuable information contained in these
semi-classified individuals. The individuals that were sexed but not
aged (FU, MU; ~0.01%), or neither sexed nor aged (UU; ~6%), were
excluded from the analysis.

#### Counts

The total group size observed during event i will be referred to as N_i,
excluding individuals with unknown ages.

N_i = F0_i + F1_i + F2_i + M0_i + M1_i + M2_i + M3_i + MA_i + U0_i +
U1_i + UA_i

To incorporate the unsexed individuals in each age class, we add all
individuals of each age class together, getting the expected number of
calves, C_i, the number of yearlings, Y_i, and the number of adults,
A_i, during the i^{th} event:

C_i = F0_i + M0_i + U0_i Y_i = F1_i + M1_i + U1_i A_i = FA_i + M2_i +
M3_i + MA_i + UA_i

The proportion of individuals from each stage expected during the i^{th}
event can also be added together to get the total expected proportions
of calves, p\_{C_i}, yearlings, p\_{Y_i}, and adults, p\_{A_i}:

p\_{C_i} = p\_{F0_i} + p\_{M0_i} p\_{Y_i} = p\_{F1_i} + p\_{M1_i}
p\_{A_i} = p\_{FA_i} + p\_{M2_i} + p\_{M3_i} + (p\_{MA_i}r\_{s_i})

where r\_{s_i} is is the expected proportion of males present, in the
season (s) of the i^{th} camera trap event.

Each of the counts (C_i, Y_i, and A_i) then follow binomial
distributions, with size equal to the group size at event i, N_i, and
the probability equal to the respective proportions described above.

C_i \sim \text{Binomial}(N_i, p\_{C_i}) Y_i \sim \text{Binomial}(N_i,
p\_{Y_i}) A_i \sim \text{Binomial}(N_i, p\_{A_i})

#### Ratios

The ratios of certain stages were also included in the model in order to
incorporate the other information included in the fully-classified
(i.e., known sex and age) count data from the camera trap events.

For calves and yearlings, there are two stages, one for each sex,
allowing us to model the sex ratios with a binomial distribution:

F0_i \sim \text{Binomial}\Biggl(F0_i + M0_i,
\frac{p\_{F0_i}}{p\_{F0_i} + p\_{M0_i}}\Biggr) F1_i \sim
\text{Binomial}\Biggl(F1_i + M1_i, \frac{p\_{F1_i}}{p\_{F1_i} +
p\_{M1_i}}\Biggr)

Three ratios were picked to ensure differences between all four of the
adult stages were accounted for. These were the FA:Bull ratio, the M2:M3
ratio, and the MA:FA ratio:

FA_i \sim \text{Binomial}\Biggl(FA_i + M2_i + M3_i + MA_i,
\frac{p\_{FA_i}}{p\_{FA_i} + p\_{M2_i} + p\_{M3_i} +
(p\_{MA_i}r\_{s_i})}\Biggr) M2_i \sim \text{Binomial}\Biggl(M2_i + M3_i,
\frac{p\_{M2_i}}{p\_{M2_i} + p\_{M3_i}}\Biggr) MA_i \sim
\text{Binomial}\Biggl(MA_i + FA_i,
\frac{p\_{MA_i}r\_{s_i}}{p\_{MA_i}r\_{s_i} + p\_{FA_i}}\Biggr)

#### Covariance Structure

Wood bison often travel in groups across the landscape. As such, the
counts and ratios of the events can be expected to be correlated through
time and space.

To account for this, a covariance structure was implemented into each of
the binomial distributional statements above. At a high level, this
involved incorporating a random effect for each camera trap location and
week, using a multivariate Normal prior with a covariance matrix that
allows the covariance between observations to decline exponentially with
the squared distance (in space and time) between them. The reader is
referred to Chapter 14.5.1 of McElreath (2020) for more detail.

### Census Data

The census data provided to the model includes the census estimate and
an associated coefficient of variation (CV), and the day, month, and
year of the aerial survey used to inform the census estimate.

To ensure the model relates correctly to the day the census estimate was
completed, a process identical to that described above for the camera
trap event data was done to calculate the expected stage-wise abundances
and proportions for the day of the study year of the a^{th} aerial
survey.

The census data was incorporated using a normal distribution as follows,

C_a \sim \text{Normal} \biggl( \sum\_{j=1}^J \mathbf{n}\_{j,a},
\sigma\_{C_a} \biggr) \text{ T\[0, \]}

where C_a is the census estimate in the a^{th} aerial survey,
\sum\_{j=1}^J \mathbf{n}\_{j,a} is the total expected abundance on the
day of the a^{th} study year, and \sigma\_{C_a} is the standard
deviation of the census estimate (calculated as the product of the
census estimate C_a and its associated CV). The normal distribution is
lower-truncated at 0 to ensure that the abundance estimates remain
positive.

### Calf Proportion Data

The data on the proportion of calves in the herd was incorporated
similarly,

P_a \sim \text{Normal}(p\_{F0,a} + p\_{M0,a}, \sigma\_{P_a}) \text{
T\[0, 1\]}

where P_a is the proportion of calves estimate in the a^{th} aerial
survey, p\_{F0,a} + p\_{M0,a} is the expected proportion of calves on
the day of the a^{th} aerial survey, and \sigma\_{P_a} is the standard
deviation in the estimate of the proportion of calves (calculated as the
product of the proportion of calves estimate P_a and its associated CV).
The normal distribution is truncated at 0 and 1 to ensure that the
estimates remain on the probability scale.

### Model Fitting

The model is fitted in Stan (Carpenter et al. 2017). By default,
[`bisonpictools`](https://github.com/poissonconsulting/bisonpictools)
uses “report” mode and a thinning rate of 10 to save 500 MCMC samples
from each of three chains (after discarding the first halves). To aid
with debugging, other analysis modes (“debug” and “quick”) can be set
(see the [user
guide](https://poissonconsulting.github.io/bisonpicsuite/articles/bisonpic-user-guide.html)
for more detail). The user can increment the thinning rate as required
to achieve convergence. The model-fitting process is automated in the
[`runbisonpic`](https://github.com/poissonconsulting/runbisonpic) Shiny
app.

### Predictions

Predictions of the stage-wise and total abundances, survival and
fecundity rates, and select ratios are derived from the posterior
distributions of the estimated parameters. These predictions are shown
on March 31 of each study year, which is a stable point right before the
aging and birthing processes occur. The
[`runbisonpic`](https://github.com/poissonconsulting/runbisonpic) Shiny
app also facilitates the visualization of these predictions.

### Assumptions and Limitations

Key assumptions of the integrated population model include:

- The survival rates for each stage vary by study year.
- The initial mortality rate of calves varies by study year.
- The fecundity rate is fixed.
- The proportion of MA individuals present with the mixed groups varies
  by season.
- There is no grouping structure beyond what is accounted for by the
  covariance.
- Every stage is equally detectable during a camera trap event.
- Small and large groups are equally detectable.

Key limitations of the integrated population model include:

- A long run time; with ~500 camera trap events, the model takes
  approximately 5 hours to converge.

## References

Carpenter, Bob, Andrew Gelman, Matthew D. Hoffman, et al. 2017. “*Stan*
: A Probabilistic Programming Language.” *Journal of Statistical
Software* 76 (1). <https://doi.org/10.18637/jss.v076.i01>.

Komers, Petr E., François Messier, and Cormack C. Gates. 1992. “Search
or Relax: The Case of Bachelor Wood Bison.” *Behavioral Ecology and
Sociobiology* 31 (3): 192–203. <https://doi.org/10.1007/BF00168647>.

McElreath, Richard. 2020. *Statistical Rethinking: A Bayesian Course
with Examples in R and Stan*. 2nd ed. CRC Texts in Statistical Science.
Taylor; Francis, CRC Press.

Newman, K. B., S. T. Buckland, B. J. T. Morgan, et al. 2014. *Modelling
Population Dynamics: Model Formulation, Fitting and Assessment Using
State-Space Methods*. <http://dx.doi.org/10.1007/978-1-4939-0977-3>.

Schaub, Michael, and Marc Kéry. 2022. *Integrated Population Models:
Theory and Ecological Applications with R and JAGS*. Academic Press.

## Licensing

Copyright 2023 Province of Alberta

Licensed under the Apache License, Version 2.0 (the “License”); you may
not use this file except in compliance with the License. You may obtain
a copy of the License at

<http://www.apache.org/licenses/LICENSE-2.0>

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an “AS IS” BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
