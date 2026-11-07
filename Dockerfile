# ====================================================
# Stage 1: Build Flutter Web
# ====================================================
FROM ghcr.io/cirruslabs/flutter:stable AS build

# Menentukan direktori kerja di dalam container
WORKDIR /app

# Salin file spesifikasi dependensi (hanya pubspec.yaml agar tidak terikat versi SDK dari pubspec.lock lokal)
COPY pubspec.yaml ./

# Download semua paket dependensi yang dibutuhkan
RUN flutter pub get

# Salin seluruh kode proyek ke dalam container
COPY . .

# Build aplikasi Flutter untuk target Web (release mode)
RUN flutter build web --release

# ====================================================
# Stage 2: Production Server (Nginx)
# ====================================================
FROM nginx:alpine

# Konfigurasi Nginx untuk SPA (Single Page Application)
# agar navigasi dan refresh halaman tidak menghasilkan error 404
RUN printf 'server {\n\
    listen 80;\n\
    location / {\n\
        root /usr/share/nginx/html;\n\
        index index.html index.htm;\n\
        try_files $uri $uri/ /index.html;\n\
    }\n\
}\n' > /etc/nginx/conf.d/default.conf

# Salin hasil build web dari Stage 1 ke folder publik Nginx
COPY --from=build /app/build/web /usr/share/nginx/html

# Buka port 80 untuk akses web
EXPOSE 80

# Jalankan server Nginx di foreground
CMD ["nginx", "-g", "daemon off;"]
