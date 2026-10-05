# probability_population_growth_detection

## Overview

This repository provides code for modeling the **probability of bacterial population growth detection** using the **exponential single-hit model**. The model estimates, for a given inoculum size *n* (CFU/well), the probability that at least one cell initiates detectable growth:

$$P(\text{growth} \mid n) = 1 - \exp(-np)$$

where *p* is the per-cell probability of initiating growth under a given stress condition.

**Objective:** To quantify the inoculum effect on bacterial growth detectability in 96-well plate assays, and to characterize how antimicrobial stress (additive type and concentration) shifts the growth-probability curve as a function of inoculum size.

## Repository Structure

```
probability_population_growth_detection/
├── data/
│   └── data.csv                    # Experimental data (288 records)
├── scripts/
│   └── code_all.ipynb              # Model fitting and visualization (Figures 2 and 3)
├── results/
│   └── df_model_fit_results.csv    # Estimated p, standard error (SE), 95% CI, and RMSE per condition (see Tables 1 and 2 in the paper)
├── .devcontainer/
│   └── devcontainer.json           # VS Code Dev Container configuration
├── Dockerfile                      # Docker image for containerized execution
├── requirements.txt                # Python package dependencies
└── README.md
```

## Dataset

`data/data.csv` contains 288 experimental records with the following columns:

| Column | Description |
|--------|-------------|
| `Inoculum_size_[CFU/well]` | Number of cells inoculated per well (*n*) |
| `Glycine_[w/v_%]` | Glycine concentration (% w/v); empty for NaCl conditions |
| `NaCl_[w/v_%]` | NaCl concentration (% w/v); empty for glycine conditions |
| `Wavelength_[nm]` | Absorbance wavelength used for growth detection (620 nm for glycine, 596 nm for NaCl conditions) |
| `Bacteria` | Bacterial species (`E.coli` or `B.cereus`) |
| `Elapsed_time_[days]` | Incubation period (3 or 7 days) |
| `Number_of_growth_well` | Number of wells (out of 96) showing detectable growth |

Each combination of species, additive concentration, and incubation period has 18 records (six inoculum levels from approximately 10<sup>0</sup> to 10<sup>5</sup> CFU/well, three records per level). The probability of growth detection is calculated as `Number_of_growth_well / 96`.

The notebook analyzes the following conditions:

| Figure | Species | Panel | Additive | Stress levels (low / high) | Incubation |
|--------|---------|-------|----------|---------------------------|------------|
| Figure 2 | *E. coli* | A, B | Glycine | 1.7% / 1.8% (w/v) | A: Day 3, B: Day 7 |
| | | C, D | NaCl | 6.5% / 7.0% (w/v) | C: Day 3, D: Day 7 |
| Figure 3 | *B. cereus* | A, B | Glycine | 1.4% / 1.6% (w/v) | A: Day 3, B: Day 7 |
| | | C, D | NaCl | 7.0% / 7.5% (w/v) | C: Day 3, D: Day 7 |

In each panel, the low stress level is shown as dark red circles and the high stress level as blue diamonds; lines are the fitted model curves.

## Method

- The parameter *p* is estimated for each condition by minimizing the sum of squared residuals between the observed and predicted growth probabilities.
- Optimization uses `scipy.optimize.minimize` with the L-BFGS-B method (bounds: 0 ≤ *p* ≤ 1, initial value *p* = 0.001).
- The standard error of *p* is approximated from the inverse Hessian returned by L-BFGS-B, and the 95% confidence interval is computed as *p* ± 1.96 × SE (Gaussian approximation).
- Goodness of fit is evaluated by the root mean squared error (RMSE).

## Results

`results/df_model_fit_results.csv` contains the fitted results for all 16 conditions (2 species × 2 additives × 2 stress levels × 2 incubation periods):

| Column | Description |
|--------|-------------|
| `Bacterial_species` | `E.coli` or `B.cereus` |
| `Additive_type` | `Glycine_[w/v_%]` or `NaCl_[w/v_%]` |
| `Stress_level` | `Low` or `High` |
| `Additive_concentration` | Additive concentration (% w/v) |
| `Elapsed_time_[days]` | Incubation period (3 or 7 days) |
| `model_type` | Model name (`exponential`) |
| `RMSE` | Root mean squared error of the fit |
| `parameter_1` | Estimated *p* |
| `parameter_2` | Not used for the exponential model (empty) |
| `parameter_set` | Parameter names (`[p]`) |
| `p_se` | Standard error of *p* |
| `p_ci95_lower`, `p_ci95_upper` | Lower and upper bounds of the 95% confidence interval of *p* |

The notebook recomputes these values and displays them as a table (`df_results`); it does not write files.

## Usage

1. Set up the environment using one of the options below.
2. Open `scripts/code_all.ipynb` and run all cells (e.g., **Restart & Run All**).
   The notebook reads `../data/data.csv` relative to the notebook, so run it from the `scripts/` directory (the default in Jupyter and VS Code).
3. For each figure cell, the notebook prints the estimated *p*, its SE, and the RMSE for each condition, then displays the figure and the result table.

## Setup and Dependencies

### Option A: Docker (standalone)

**Requirements:** [Docker](https://docs.docker.com/get-docker/)

```bash
# Build the image
docker build -t growth_probability .

# Run Jupyter Notebook
docker run -p 8888:8888 growth_probability

# With local file sync (edits saved to your machine)
docker run -p 8888:8888 -v $(pwd):/app growth_probability
```

Open the URL shown in the terminal (`http://127.0.0.1:8888/tree?token=...`) in your browser.

### Option B: VS Code Dev Container

**Requirements:** Docker + [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

Open this repository in VS Code and click **Reopen in Container** when prompted.

### Option C: Local installation

**Requirements:** Python 3.11

```bash
pip install -r requirements.txt
jupyter notebook
```

### Key dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| pandas | 2.2.2 | Data handling and manipulation |
| numpy | 1.26.4 | Numerical computation |
| scipy | 1.13.1 | Optimization (L-BFGS-B method) |
| matplotlib | 3.10.0 | Visualization |
| matplotlib-inline | 0.1.7 | Inline plotting in Jupyter |
| jupyter | 1.0.0 | Notebook environment |

## Citation

If you use this code or data, please cite:

> (Citation to be added: authors, title, journal, year, DOI)

## License

(License to be added)
