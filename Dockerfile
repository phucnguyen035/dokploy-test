# Use the official Bun image as base
FROM oven/bun:1-alpine AS base

# Stage 1: Dependencies
FROM base AS deps
WORKDIR /app

# Copy package files for dependency installation
COPY package.json bun.lock ./

# Install dependencies with optimizations
RUN bun install --frozen-lockfile

# Stage 2: Build
FROM base AS builder
WORKDIR /app

# Copy dependencies from deps stage
COPY --from=deps /app/node_modules ./node_modules
COPY . .

# Prepare SvelteKit (generate config files)
RUN bun run prepare

# Build the application
RUN bun run build

# Stage 3: Production runtime
FROM base AS runtime
WORKDIR /app

# Create non-root user for security
RUN addgroup --system --gid 1001 bunjs \
    && adduser --system --uid 1001 bunjs

# Copy only the built application and necessary files
COPY --from=builder --chown=bunjs:bunjs /app/build ./build
COPY --from=builder --chown=bunjs:bunjs /app/package.json ./
COPY --from=builder --chown=bunjs:bunjs /app/bun.lock ./

# Switch to non-root user
USER bunjs

# Expose port 3000
EXPOSE 3000

# Set environment variables
ENV NODE_ENV=production
ENV PORT=3000

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD bun --version || exit 1

# Start the application
CMD ["bun", "start"]
