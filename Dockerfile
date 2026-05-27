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
    fontconfig \
    fonts-noto-cjk \
    && rm -rf /var/lib/apt/lists/*

# ==========================================================
# 3) installing Python library
# ==========================================================
COPY requirements.txt /tmp/requirements.txt
RUN pip install --upgrade pip \
    && pip install --no-cache-dir --retries 10 -r /tmp/requirements.txt

# ==========================================================
# 4) copy source code for standalone Docker usage
# ==========================================================
WORKDIR /app
COPY . /app

# ==========================================================
# 5) setting option (port etc) when running Jupyter Notebook 
# ==========================================================
EXPOSE 8888
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--allow-root", "--no-browser", "--NotebookApp.notebook_dir=/app"]