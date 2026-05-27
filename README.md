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
│   └── data.csv                    # Experimental data (288 data rows)
├── scripts/
│   └── code_all.ipynb              # Model fitting, visualization, result export
├── results/
│   ├── df_model_fit_results.csv    # Estimated p, standard error (SE), and RMSE per condition (see Table 1 & 2 in the paper)
│   └── figures/
│       ├── Figure_1.pdf              # Design of experiments
│       ├── Figure_2.pdf              # E. coli + Glycine
│       ├── Figure_3.pdf              # E. coli + NaCl
│       ├── Figure_4.pdf              # B. cereus + Glycine
│       └── Figure_5.pdf              # B. cereus + NaCl
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
| `Inoculum_size_[CFU/well]` | Number of cells inoculated per well |
| `Glycine_[w/v_%]` | Glycine concentration (% w/v) |
| `NaCl_[w/v_%]` | NaCl concentration (% w/v) |
| `Wavelength_[nm]` | Absorbance wavelength used for growth detection |
| `Bacteria` | Bacterial species (*E. coli* or *B. cereus*) |
| `Elapsed_time_[days]` | Incubation period (3 or 7 days) |
| `Number_of_growth_well` | Number of wells (out of 96) showing detectable growth |

The notebook analyzes four experimental conditions:

| Figure | Species | Additive | Stress levels (low / high) |
|--------|---------|----------|---------------------------|
| Figure_2 | *E. coli* | Glycine | 1.7% / 1.8% (w/v) |
| Figure_3 | *E. coli* | NaCl | 6.5% / 7.0% (w/v) |
| Figure_4 | *B. cereus* | Glycine | 1.4% / 1.6% (w/v) |
| Figure_5 | *B. cereus* | NaCl | 7.0% / 7.5% (w/v) |

## Setup and Dependencies

### Option A: Docker (standalone)

**Requirements:** [Docker](https://docs.docker.com/get-docker/)

```bash
# Build the image
docker build -t growth_probability .

# Run Jupyter Notebook (accessible at http://localhost:8888)
docker run -p 8888:8888 growth_probability

# With local file sync (edits saved to your machine)
docker run -p 8888:8888 -v $(pwd):/app growth_probability
```

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
| jupyter | 1.0.0 | Notebook environment |
