---
title: "Combining a Probability and a Non-Probability Sample in a Capture-Recapture Setting"
tags:
- non-probability sampling
- combining data sources
- capture-recapture sampling
authors: 
- name: "Benjamin Williams"
  orcid: 0000-0001-8474-5066
  affiliation: 1
affiliations:
- name: "Department of Statistical Science, Southern Methodist University"
  index: 1
date: 6 August 2018
bibliography: blendR_bib.bib
...


Statistical sampling plays a vital role in understanding and making inferences with respect to all types of populations and is especially salient in a world where populations are large and big data is the new standard. In an ideal situation, samplers have access to a list of all the units in a population, called a sampling frame, from which to draw a sample. This allows them to select individual population units with known probabilities, producing a probability sample [@lohr_sampling:_2010]. A sample for which probabilities of selection are not known is called a non-probability sample. Probability samples are preferred to non-probability samples because the sampling variance of the estimators calculated from probability samples can be determined using standard sampling theory. The primary disadvantage of non-probability samples is the potential for biased estimation stemming from undercoverage and a lack of representativeness in the samples. Without external sources of information, these sample deficiencies cannot be detected.

It is usually easier to obtain a non-probability sample than a probability sample. For example, a frame may not be available, which complicates the selection of a probability sample. A non-probability sample, such as one using data from volunteers, does not require an expensive nonresponse follow-up. The larger the sample, the more information it may contain. This is an attractive option for analysts working with limited resources while studying elusive populations. As a result, statisticians have begun to investigate methods for improving estimation using data from non-probability samples (for example, @elliott_use_2007). One way to improve such estimation is to combine a non-probability sample with a probability sample.

The [blendR](https://github.com/williamsbenjamin/blendR) package (available on [GitHub](https://github.com/williamsbenjamin/blendR)) provides four statistically valid estimators of total when combining a non-probability sample with a probability sample. These estimators have applications in many areas, such as: the internet of things, where a non-probability sample could be taken from devices connected to the internet; insurance claims, where claims could be voluntarily reported; and estimation of the death toll due to a natural disaster, where survivors could self-report deaths in a family. In each of these situations, the estimators from [blendR](https://github.com/williamsbenjamin/blendR) can combine the information from the respective non-probability samples with a probability sample to make more accurate estimates. The prevalence of non-probability samples continues to grow in both academia and industry, due in large part to technological advances and the availability of big data. [blendR](https://github.com/williamsbenjamin/blendR) is needed to allow analysts from a variety of disciplines to use non-probability samples to improve estimation.

The estimators are taken from @liu_estimation_2017 and @breidt_model-assisted_2018. The sampling program considers the non-probability sample as a capture sample and the probability sample as a recapture sample, meaning units selected into the non-probability sample can be again sampled into the probability sample. Capture-recapture methodology provides powerful tools to estimate the total number of units in a population [@cren_note_1965]. The goal of the four estimators presented is to make valid estimates of the total of some variable of interest gathered in both samples. The values may disagree for units which are part of both samples (due to measurement error, for example).

The estimators from @liu_estimation_2017 are ratio estimators and the one from @breidt_model-assisted_2018 is a difference estimator. One ratio estimator uses whether or not the unit was a part of the non-probability sample as auxiliary information, one uses the value of the variable of interest gathered in the non-probability sample as auxiliary information, and the third is a weighted combination of the first two estimators. The difference estimator adds the total value of the variable of interest gathered in the non-probability sample to the estimated difference between the value of the variable in the probability sample and the value of the variable in the non-probability sample. These estimators can be used in any situation of combining samples via a capture-recapture sampling program and have many exciting possible extensions.

The estimators are currently used to estimate the total catch of the fish in several settings, including the fish Red Snapper by Texas Parks and Wildlife (TPWD). TPWD and other entities, including the National Oceanic and Atmospheric Administration (NOAA) estimate the total fish catch in the Gulf of Mexico. The [blendR](https://github.com/williamsbenjamin/blendR) package provides data from a 2016 TPWD capture-recapture sampling program in which the capture sample was a non-probability sample of captains who reported the number of Red Snapper they caught via a smartphone app. The recapture sample was a dockside intercept sample in which boats were boarded and interviewers collected data about the number of Red Snapper caught (a probability sample).

The National Research Council has advised NOAA to continue experiments with electronic reporting to better estimate the total fish caught in marine waters by recreational anglers [@committee_on_the_review_of_the_marine_recreational_information_program_review_2017]. Accurate estimation is critical to setting approriate fishing seasons and bag limits. As such, this is an important research field. 

This work is part of dissertation research by the author (Benjamin Williams). It is also being used in working papers regarding non-sampling errors and sample size calculations for electronic reporting experiments by a fisheries research team at Southern Methodist University led by [Lynne Stokes](https://www.smu.edu/News/Experts/Lynn-Stokes). Bug reports, contributions, and other useful comments are welcomed as [issue tickets](https://github.com/williamsbenjamin/blendR/issues) on Github and will be attended to in a timely manner.

# References

