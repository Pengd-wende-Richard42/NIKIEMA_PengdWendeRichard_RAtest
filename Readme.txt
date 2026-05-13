# ERC Really Credible RA Test  
### Candidate: NIKIEMA Pengd-Wende Richard

This repository contains the material produced for the **ERC Really Credible Research Assistant Test (2026)**.

The repository includes:
- Stata code used for the empirical exercises;
- event-study figures and robustness outputs;
- Monte Carlo simulations;
- LaTeX write-up and supporting material.

---

# Repository Structure

```text
├── Code/
│   ├── RA_Test_Selected_Exercises_NIKIEMA.do
│   │
├── Data/
│   └── exercise3_data.dta
│
├── Graphs/
│   ├── exercise3_event_study_base.png
│   └── exercise3_event_study_base7.png
│
├── Tables/
│   ├── exercise1_monte_carlo_results.dta
│   └── exercise1_monte_carlo_summary.xlsx
│
├── Logs/
│   └── RA_test_results.log
│
├── Paper/
│   ├── RA_Test_Writeup.tex
│   ├── RA_Test_Writeup.pdf
│   └── biblio.bib
│
└── README.md
```

---

# Software

The empirical analysis was conducted using:

- Stata
- `did_multiplegt_dyn`
- `estout`

Main Stata packages used:

```stata
ssc install did_multiplegt_dyn
ssc install estout
```

---

# Exercises Covered

## Exercise 1
- Super-consistent estimator
- Monte Carlo simulation
- Asymptotic properties
- Confidence interval construction

## Exercise 3
Replication and extension of:

> Burgess, R., Jedwab, R., Miguel, E., Morjaria, A., & Padró i Miquel, G. (2015).  
> *The Value of Democracy: Evidence from Road Building in Kenya*.  
> American Economic Review, 105(6), 1817–1851.

using:
- dynamic Difference-in-Differences,
- event-study estimation,
- placebo tests,
- robustness checks,
- switching analysis.

## Exercise 4
Conceptual and computational discussion of:
- clustered bootstrap,
- weighted bootstrap,
- random weighting vectors,
- computational implementation in `did_multiplegt_dyn`.

## Exercise 6
Responses to user questions related to:
- multiple treatments,
- event-study sample sizes,
- seasonality controls,
- multiple policy timing.

---

# Reproducibility

To reproduce the results:

1. Open the Stata do-file located in:

```text
Code/RA_Test_Selected_Exercises_NIKIEMA.do
```

2. Update the root directory if necessary.

3. Run the full script.

All figures and outputs will automatically be generated in their corresponding folders.

---

# Notes

This repository was prepared as part of a recruitment exercise and is intended for academic and evaluation purposes only.

Some discussions in the write-up explicitly document interactions with AI tools as requested in the instructions of Exercise 4.

---

# Contact

**NIKIEMA Pengd-Wende Richard**  
PhD Candidate in Development Economics  
LEO-UCA, Université Clermont Auvergne

Email: richmannik@gmail.com