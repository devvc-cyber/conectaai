FROM node:18-alpine AS base

# Add compatibility library for node-gyp compatibility
FROM base AS deps
RUN apk add --no-cache libc6-compat python3 make g++

WORKDIR /app

# Copy package manifests and install dependencies
COPY package.json ./
COPY yarn.lock ./
COPY tsconfig.json ./
RUN yarn config set network-timeout 600000 -g
RUN yarn install --frozen-lockfile

# Build stage
FROM base AS builder
WORKDIR /app

# Copy node_modules from deps stage to avoid reinstalling dependencies
COPY --from=deps /app/node_modules ./node_modules
COPY . .
COPY lib ./lib

# Run build command to create the production build
RUN yarn build

# Production image, setup for runtime
FROM base AS runner
WORKDIR /app

# Set environment variables for production
ENV NODE_ENV=production
ENV NEXT_TELEMETRY_DISABLED=1

# Create user and group to run the application securely
RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nextjs 

# Copy necessary files from the builder stage
COPY --from=builder /app/public ./public
COPY --from=builder /app/context ./context
COPY --from=builder /app/types ./types
COPY --from=builder /app/lib ./lib
COPY --from=builder --chown=nextjs:nodejs /app/.next/standalone ./
COPY --from=builder --chown=nextjs:nodejs /app/.next/static ./.next/static
COPY --from=builder /app/package.json ./package.json
COPY --from=builder /app/tsconfig.json ./tsconfig.json

# Change to the non-root user
USER nextjs

# Expose application port
EXPOSE 3000

# Start the application
CMD ["node", "server.js"]
