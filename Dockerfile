# ==========================================================
# 1) base docker image 
# ==========================================================
FROM python:3.11-slim

# ==========================================================
# 2) installing package, font
# ==========================================================
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    cabextract \ 
    && rm -rf /var/lib/apt/lists/*

# ==========================================================
# 3) setting work directory "/workspace"
# ==========================================================
WORKDIR /workspace

# ==========================================================
# 4) /workspace files at local directory (Notebook, requirements, etc...) 
# ==========================================================
COPY . /workspace

# ==========================================================
# 5) installing Python library
# ==========================================================
RUN pip install --upgrade pip \
    && pip install --no-cache-dir --retries 10 -r requirements.txt

# ==========================================================
# 6) setting option (port etc) when running 　Jupyter Notebook 
# ==========================================================
EXPOSE 8888
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--allow-root", "--no-browser", "--NotebookApp.notebook_dir=/workspace"]


