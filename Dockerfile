# Build bosqichi
FROM node:alpine AS builder
WORKDIR /app

# Paket fayllarni qo‘shish va o‘rnatish
ADD package*.json ./
RUN yarn install

# Barcha fayllarni qo‘shish va build qilish
ADD . .
RUN yarn build

# Production bosqichi
FROM node:alpine
WORKDIR /app

# Build qilingan fayllarni ko‘chirish
COPY --from=builder /app/dist ./dist
COPY package.json ./

# Faqat production dependencylarni o‘rnatish
RUN yarn install --production
 
# Port (agar kerak bo‘lsa)
EXPOSE 3000

# Ishga tushirish
CMD ["node", "./dist/main.js"]
