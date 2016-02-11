# basis-data-analysis

Having retrieved biometrics data from Basis via app [Basis Retriever (by Rich Knopman)](http://www.richk.net/wiki/BasisRetriever/BasisRetriever), this code pre-processes the data, and creates some plots for goal tracking.

#### How to Run

- Fork & Clone this repo and set it as your R working directory
- Download your Basis data using app BasisRetriever
- Copy BasisRetriever data to subfolder `data/base`
- Get & Clean Data - Run in R: `source("get_clean_data.R")`
  - Output: RDS files saved in subfolder `data/processed`
- Generate Plots - Run in R: `source("R/plot.steps.R")`
  - Output: plots saved in subfolder `output/figures`

#### Example Plots

##### Quality Control Chart of steps, by day
For info on what this chart means, see [qcc package documentation](https://cran.r-project.org/web/packages/qcc/qcc.pdf)
![](https://raw.githubusercontent.com/bbrewington/basis-data-analysis/master/output/figures/steps_bydate.png)

##### Histogram of steps, by day
![](https://raw.githubusercontent.com/bbrewington/basis-data-analysis/master/output/figures/steps_hist_by_date.png)
