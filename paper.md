Statistical sampling plays a vital role in understanding and making
inferences with respect to all types of populations and is especially
salient in a world where populations are large and big data is the new
standard in both academia and industry. In an ideal situation, samplers
have access to a list of all the units in a population, called a
sampling frame, from which to draw a sample. This allows them to select
individual population units with known probabilities, producing a
probability sample Lohr (2010). A sample for which probabilities of
selection are not known is called a non-probability sample. Probability
samples are preferred to non-probability samples because the sampling
variance of the estimators calculated from probability samples can be
determined using standard sampling theory. The primary disadvantage of
non-probability samples is the potential for biased estimation stemming
from undercoverage and a lack of representativeness in the samples.
Without external sources of information, these sample deficiencies
cannot be detected.

It is usually easier to obtain a non-probability sample than a
probability sample. For example, a frame may not be available, which
complicates the selection of a probability sample. A non-probability
sample, such as one using data from volunteers, does not require an
expensive nonresponse follow-up. The larger the sample, the more
information it may contain. This is an attractive option for analysts
working with limited resources while studying elusive populations. As a
result, statisticians have begun to investigate methods for improving
estimation using data from non-probability samples. One way to improve
such estimation is to combine a non-probability sample with a
probability sample.

The [blendR](https://github.com/williamsbenjamin/blendR) package
provides four statistically valid estimators of total when combining a
non-probability sample with a probability sample. The estimators are
taken from Liu et al. (2017) and Breidt, Opsomer, and Huang (2018). The
sampling program considers the non-probability sample as a capture
sample and the probability sample as a recapture sample, meaning units
selected into the non-probability sample can be again sampled into the
probability sample. Capture-recapture methodology provides powerful
tools to estimate the total number of units in a population. The goal of
these estimators is to make valid estimates of the total of some
variable of interest gathered in both samples.

The estimators from Liu et al. (2017) are ratio estimators and the one
from Breidt, Opsomer, and Huang (2018) is a difference estimator. One
ratio estimator uses whether or not the unit was a part of the
non-probability sample as auxiliary information, one uses the value of
the variable of interest gathered in the non-probability sample as
auxiliary information, and the third is a weighted combination of the
first two estimators. The difference estimator adds the total value of
the variable of interest gathered in the non-probability sample to the
estimated difference between the value of the variable in the
probability sample and the value of the variable in the non-probability
sample.

These estimators are currently used to estimate the total catch of the
fish in several settings, including the fish Red Snapper by Texas Parks
and Wildlife (TPWD). TPWD and other entities, including the National
Oceanic and Atmospheric Administration (NOAA) to estimate total fish
catch in the Gulf of Mexico. The
[blendR](https://github.com/williamsbenjamin/blendR) package provides
data from a 2016 TPWD capture-recapture sampling program in which the
capture sample was a non-probability sample of captains who reported the
number of Red Snapper they caught via a smartphone app. The recapture
sample was a dockside intercept sample in which boats were boarded and
interviewers collected data about the number of Red Snapper caught (a
probability sample).

The National Research Council has advised NOAA to continue experiments
with electronic reporting to better estimate the total fish caught in
marine waters by recreational anglers. Accurate estimation is critical
to setting accurate fishing seasons and bag limits. As such, this is an
important research field and extends to many other fields. Having the
estimators widely available in
[blendR](https://github.com/williamsbenjamin/blendR) will allow various
agencies and investigators to make their own valid estimates harnessing
the useful information from non-probability samples.

References
----------

Breidt, Jay F., Jean D. Opsomer, and Chen-Min Huang. 2018.
“Model-Assisted Survey Estimation with Imperfectly Matched Auxiliary
Data.” In *Predictive Econometrics and Big Data*, 753:21–35. Studies in
Computational Intelligence. Springer.

Liu, Bingchen, Lynne Stokes, Tara Topping, and Greg Stunz. 2017.
“Estimation of a Total from a Population of Unknown Size and Application
to Estimating Recreational Red Snapper Catch in Texas.” *Journal of
Survey Statistics and Methodology* 5 (3): 350–71.
doi:[10.1093/jssam/smx006](https://doi.org/10.1093/jssam/smx006).

Lohr, Sharon L. 2010. *Sampling: Design and Analysis*. 2nd ed.
Brooks/Cole.
