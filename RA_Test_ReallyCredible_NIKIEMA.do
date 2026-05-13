****************************************************
* ERC Really Credible RA Test
* Selected Exercises
* Candidate: NIKIEMA Pengd-Wende Richard
****************************************************

clear all
set more off

****************************************************
* 0. Working directory and folders
****************************************************

global root "C:\Users\richm\Desktop\Test_RA"

cd "$root"

cap mkdir "Code"
cap mkdir "Graphs"
cap mkdir "Tables"
cap mkdir "Logs"

capture log close
log using "$root\Logs\RA_test_results.log", replace text


****************************************************
* 1. Required packages
****************************************************

cap which did_multiplegt_dyn
if _rc ssc install did_multiplegt_dyn, replace

cap which esttab
if _rc ssc install estout, replace

*****************************************************
*****************************************************
* 2. Exercise 1: Super-consistent estimator
*****************************************************
*****************************************************

clear all
set seed 12345

capture program drop mc_uniform
program define mc_uniform, rclass

    drop _all
    set obs 1000

    gen y = uniform()

    summarize y, meanonly
    return scalar theta_MM = 2*r(mean)
    return scalar theta_ML = r(max)

end

simulate theta_MM=r(theta_MM) ///
         theta_ML=r(theta_ML), ///
         reps(1000): mc_uniform

gen err_MM = abs(theta_MM - 1)
gen err_ML = abs(theta_ML - 1)

summarize err_MM err_ML

* Save Monte Carlo results
save "$root\Tables\exercise1_monte_carlo_results.dta", replace

* Export summary statistics to Excel
preserve
collapse (mean) mean_abs_error_MM=err_MM mean_abs_error_ML=err_ML ///
         (sd) sd_abs_error_MM=err_MM sd_abs_error_ML=err_ML
export excel using "$root\Tables\exercise1_monte_carlo_summary.xlsx", ///
    firstrow(variables) replace
restore

****************************************************
****************************************************
* 3. Exercise 3: Burgess et al. (2015)
****************************************************
****************************************************

use "$root\Data\exercise3_data.dta", clear


****************************************************
* 3.1 Preliminary checks
****************************************************

describe
summarize

xtset distnum year

tab year
tab president

bysort distnum: egen ever_coethnic = max(president)
tab ever_coethnic


****************************************************
* 3.2 Baseline dynamic specification
****************************************************

did_multiplegt_dyn exp_dens_share distnum year president, ///
    effects(5) ///
    placebo(5) ///
    cluster(distnum) ///
    graph_off

estimates store dyn_base


****************************************************
* 3.3 Event-study figures
****************************************************

* Main event-study window
did_multiplegt_dyn exp_dens_share distnum year president, ///
    effects(5) ///
    placebo(5) ///
    cluster(distnum)

graph export "$root\Graphs\exercise3_event_study_base.png", ///
    replace width(2400)

* Longer event-study window
did_multiplegt_dyn exp_dens_share distnum year president, ///
    effects(7) ///
    placebo(7) ///
    cluster(distnum)

graph export "$root\Graphs\exercise3_event_study_base7.png", ///
    replace width(2400)


****************************************************
* 3.4 Controls interacted with a linear time trend
****************************************************

gen trend = year - 1963

gen pop1962_trend          = pop1962 * trend
gen area_trend             = area * trend
gen urbrate1962_trend      = urbrate1962 * trend
gen earnings_trend         = earnings * trend
gen wage_employment_trend  = wage_employment * trend
gen value_cashcrops_trend  = value_cashcrops * trend


****************************************************
* 3.5 Robustness: demographic controls
****************************************************

did_multiplegt_dyn exp_dens_share distnum year president, ///
    effects(5) ///
    placebo(5) ///
    controls(pop1962_trend area_trend urbrate1962_trend) ///
    cluster(distnum) ///
    graph_off

estimates store dyn_demo


****************************************************
* 3.6 Robustness: demographic and economic controls
****************************************************

did_multiplegt_dyn exp_dens_share distnum year president, ///
    effects(5) ///
    placebo(5) ///
    controls(pop1962_trend area_trend urbrate1962_trend ///
             earnings_trend wage_employment_trend value_cashcrops_trend) ///
    cluster(distnum) ///
    graph_off

estimates store dyn_full


****************************************************
* 3.7 Stored estimates
****************************************************

estimates dir


****************************************************
* 3.8 Treatment transitions
****************************************************

bysort distnum (year): gen delta_president = president - president[_n-1] if _n > 1
tab delta_president

bysort distnum (year): gen switch_out = president[_n-1] == 1 & president == 0 if _n > 1
tab switch_out

bysort distnum: egen n_switch_out = total(switch_out)
tab n_switch_out


****************************************************
* 3.9 Switching-out specification
****************************************************

capture noisily did_multiplegt_dyn exp_dens_share distnum year president, ///
    effects(5) ///
    placebo(5) ///
    cluster(distnum) ///
    switchers(out) ///
    graph_off

* This specification is not estimable in this dataset because
* the required design restriction is not satisfied for switchers(out).


****************************************************
* 4. Close log
****************************************************

log close