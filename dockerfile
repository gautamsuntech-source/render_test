# Step 1: PHP image use karna
FROM php:8.2-cli

# Step 2: System dependencies install karna
RUN apt-get update && apt-get install -y \
    unzip \
    git \
    libpq-dev \
    libzip-dev \
    zip \
    && docker-php-ext-install pdo pdo_mysql pdo_pgsql zip

# Step 3: Composer install karna
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Step 4: Working directory set karna
WORKDIR /app

# Step 5: Project files copy karna
COPY . .

# Step 6: Laravel dependencies install karna
RUN composer install --no-dev --optimize-autoloader

# Step 7: Port expose karna
EXPOSE 10000

# Step 8: Laravel serve command
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=10000"]
