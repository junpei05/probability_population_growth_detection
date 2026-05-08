# probability_population_growth_detection

## Overview
Background: <br><br>
Objectives: The objective of this study is to reveal inoculum effect using cell numbers.<br><br>
Expected outcome: <br><br>


## Repository Structure

This repository contains the code for modeling the probability of bacterial population growth detection at the individual cell level, using inoculum size as the explanatory variable.

| Path | Description |
|------|-------------|
| `data/` | Raw experimental data (growth/no-growth observations) |
| `scripts/` | Jupyter notebooks for model fitting and visualization |
| `results/` | Model fit results (CSV) and output figures (TIFF/PDF) |
| `.devcontainer/` | VS Code Dev Container configuration |

## Setup and Dependencies

### Option A: Docker (standalone)

**Requirements:** [Docker](https://docs.docker.com/get-docker/)

```bash
# Build the image
docker build -t growth_probability .

# Run Jupyter Notebook (accessible at http://localhost:8888)
docker run -p 8888:8888 growth_probability
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
| scikit-learn | 1.4.2 | Model evaluation (RMSE) |
| matplotlib | 3.10.0 | Visualization |
| seaborn | 0.13.2 | Statistical visualization |
| jupyter | 1.0.0 | Notebook environment |
| openpyxl / xlrd | 3.1.2 / 2.0.1 | Excel file support |
