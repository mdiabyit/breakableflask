# --- build ---
FROM python:3.12-slim AS build
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir --prefix=/install -r requirements.txt

# --- runtime ---
FROM python:3.12-slim
WORKDIR /app
RUN useradd --create-home --uid 10001 appuser
COPY --from=build /install /usr/local
COPY --chown=appuser:appuser main.py .
USER appuser
EXPOSE 4000
CMD ["python", "main.py"]
