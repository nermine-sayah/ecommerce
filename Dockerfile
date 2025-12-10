# مرحلة البناء
FROM node:18-alpine AS builder

WORKDIR /app

# نسخ package.json و package-lock.json
COPY package*.json ./

# تثبيت كل dependencies
RUN npm install --legacy-peer-deps

# تثبيت vite عالميًا عشان يكون متاح
RUN npm install -g vite

# نسخ باقي الملفات
COPY . .

# build المشروع
RUN vite build

# مرحلة nginx النهائية
FROM nginx:alpine
COPY --from=builder /app/dist /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
