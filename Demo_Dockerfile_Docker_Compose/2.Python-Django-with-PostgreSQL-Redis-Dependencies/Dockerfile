FROM python:3.11-slim-bullseye
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONDUNBUFFERED=1
ENV DJANGO_SETTING_MODULE=myproject.settings.production
RUN apt-get update && apt-get install -y \
    postgresql-client \
    gcc \
    libpq-dev \
    python3-dev \
    netcat-openbsd \
    && rm -rf /var/lib/apt/lists/*
WORKDIR /app
RUN addgroup --system django && adduser --system --ingroup django django
COPY requirement.txt .
RUN pip install --no-cache-dir -r requirement.txt
COPY . .
RUN python manage.py collectstatic --noinput --clear
RUN chown -R django:django /app
USER django
EXPOSE 8000
HEALTHCHECK --interval=30s --timeout=30s --start-periods=5s --retries=3 \
    CMD curl -f http://localhost:8000/health/ || exit 1
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "--workers", "4", "--threads", "2", "myproject.wsgi:application"]
