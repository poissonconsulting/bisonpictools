---
title: 'bisonpic Software: A suite of R packages to derive wildlife population parameters
  from remote camera image series.'
author: "Ayla Pearson, Nicole Hill, Joe Thorley, Andrea Kortello"
date: "2024-04-25"
output: html_document
bibliography: paper.bib
---

# Statement of Need

Knowledge of population status and trend is integral to the effective conservation and management of wildlife populations. It is particularly advantageous to anticipate future trends. To this end, demographic ratios (i.e Calf:Cow ratios) are routinely used in wildlife management as a readily observable measure of productivity and for forecasting population trajectories [@fuller2007; @wittmer2005; @bender2006]. More complex state-space population modelling approaches [@buckland2004; @paterson2019; @mizuki2020; @newman2023] can be additionally used to derive estimates of survival and fecundity. Both approaches require classified (by age and sex) counts of individuals in a herd.

In remote areas, estimates of herd size and composition are typically obtained from aerial surveys. However, distinguishing animal age and sex can be challenging, particularly in forested environments, if animals flee or hide from aircraft. Remote cameras present an alternative method for obtaining classified counts. Wildlife cameras have been utilized for purposes including species occupancy, density, behaviour, and to identify individuals through district markings [@magoun2011; @steenweg2016; @caravaggi2017; @green2020; @nakashima2020; @singh2022]. Although different age and sex classes can be readily distinguished in remote camera photos for many ungulate species [@laskin2020], we are not aware of any published studies or software using cameras to derive population parameters from classified counts of herds for animals without individual markings.

# Summary

We present a method utilizing classified counts from wildlife cameras to evaluate herd demographics, using wood bison as an example. We modeled demographic ratios, survival and productivity using linked Bayesian models; one model describing the spatial and temporal correlation structure of the camera observations using a Gaussian process regression [@mcelreath2016], and a second population model describing demographic structure, states, and transitions. This novel approach requires an initial population estimate but does not require individual identification and could be applied non-invasively to a wide array of difficult to survey species to estimate the key parameters that drive population dynamics.

![](figures/bisonpicwriteup-diagram.png "Figure 1. Overview of the bisonpic suite of tools.")

*Figure 1. Overview of the bisonpic suite of tools.*

This method is implemented using three connected R packages, bisonpictools provides underlying functionality to clean, process, model, and visualize data. The other two R packages are apps that provide a user-friendly interface to bisonpictools. The first app is shinybisonpic. This web-based app allows users to upload and explore the data by viewing the locations of cameras and the ratios of selected sex-age groups. The second app is runbisonpic which is run locally. This app allows users to run a model to calculate the abundance by class, total abundance, survival, fecundity, and various sex-age ratios. Bisonpictools, shinybisonpic and runbisonpic were developed for Alberta Environment and Parks to enable remote game cameras to monitor the herd composition of wood bison.

# Features

Data Standardization

-   Uploaded data is put through a quality control process which detects values that are not allowed to reduce errors in the following steps.

Location Mapping

-   Users can explore the camera locations on an interactive map which helps to spatially verify location data are accurate.

Demographic Ratios

-   Each sex-age group can be individually selected which gives users the freedom to explore ratios for any combination of sex-age groups.

Abundance Class, Abundance Total, Survival, Fecundity, and Ratios Estimates

-   Complex custom model that only has a single parameter users must learn how to tune which makes the method accessible for users of various skill levels.
-   Downloadable analysis object which allows power users to generate their own plots or perform further analysis.

Documentation

-   User Manual vignette that walks users through the detailed steps and options.
-   Basic instructions are easily accessible within the app.

# Limitations

The model is slow to run and can take over 24 hours to complete running.

# Acknowledgements

This work was funded by Alberta Environment and Protected Areas.

# References
