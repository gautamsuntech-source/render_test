# Step 1: PHP image use karna
FROM php:8.2-cli

# Step 2: System dependencies install karna
RUN apt-get update && apt-get install -y \
    unzip \
    git \
    libpq-dev \
    libzip-dev \
    zip \
    && docker-php-ext-install pdo pdo_mysql pdo_pgsql zip \
    && docker-php-ext-install mysqli

# Step 3: Composer install karna
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Step 4: Working directory set karna
WORKDIR /app

# Step 5: Project files copy karna
COPY . .

# Step 6: Laravel dependencies install karna
RUN composer install --no-dev --optimize-autoloader

# Step 7: Set permissions
RUN chown -R www-data:www-data /app && chmod -R 755 /app

# Step 8: Laravel cache clear
RUN php artisan config:cache && php artisan route:cache && php artisan view:cache

# Step 9: Expose port
EXPOSE 10000

# Step 10: Run Laravel with Artisan (or PHP-FPM)
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=10000"]
