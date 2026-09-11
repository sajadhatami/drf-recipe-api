FROM python:3.13-slim

LABEL maintainer="sajadhatamiw@gmail.com"

ENV PYTHONUNBUFFERED=1

# Install uv
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

WORKDIR /app

# Install dependencies
COPY pyproject.toml uv.lock README.md ./

# Copy application
COPY ./src ./src

RUN uv sync --frozen
# RUN uv sync --frozen --no-dev


# Create non-root user
RUN adduser \
    --disabled-password \
    --no-create-home \
    django-user

ENV PATH="/app/.venv/bin:$PATH"

USER django-user

EXPOSE 8000

# CMD ["python", "src/drf_recipe_api/manage.py", "runserver", "0.0.0.0:8000"]