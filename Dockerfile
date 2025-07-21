# Use the official Bun image as base
FROM oven/bun:1-alpine AS base

FROM base AS install
WORKDIR /app
COPY package.json bun.lock ./
RUN bun install --frozen-lockfile
COPY . .
RUN bun run prepare
RUN bun run build

FROM base AS release
COPY --from=install /app/node_modules node_modules
COPY --from=install /app/package.json .
COPY --from=install /app/build ./build

# Expose port 3000
EXPOSE 3000

# Set environment variables
ENV NODE_ENV=production

USER bun
CMD ["bun", "start"]
