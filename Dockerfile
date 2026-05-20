FROM node:20-alpine AS frontend-builder
WORKDIR /build/frontend
RUN npm install -g pnpm
COPY frontend/package.json frontend/pnpm-lock.yaml frontend/pnpm-workspace.yaml ./
RUN pnpm install --frozen-lockfile
COPY frontend/app ./app
COPY frontend/components ./components
COPY frontend/next.config.ts frontend/postcss.config.mjs frontend/tsconfig.json frontend/eslint.config.mjs  ./
RUN pnpm build  


#------------------------GitRSS Start------------------------

FROM node:20-alpine AS gitrss-frontend-builder
WORKDIR /build/gitrss/frontend
ENV VITE_API_URL=/gitrss/api
ENV VITE_ADMIN_STORAGE_KEY=gitrss-admin-session
ENV VITE_BASE=/gitrss/
RUN npm install -g pnpm@10
COPY gitrss/frontend/package.json gitrss/frontend/pnpm-lock.yaml ./
RUN pnpm install --frozen-lockfile
COPY gitrss/frontend/src ./src
COPY gitrss/frontend/index.html gitrss/frontend/vite.config.ts gitrss/frontend/tsconfig.json ./
RUN pnpm build

FROM node:20-alpine AS gitrss-backend-builder
WORKDIR /build/gitrss-backend
RUN npm install -g pnpm@10
COPY gitrss/backend/package.json gitrss/backend/pnpm-lock.yaml ./
RUN pnpm install --frozen-lockfile
COPY gitrss/backend/src ./src
COPY gitrss/backend/tsconfig.json ./
RUN pnpm build


FROM node:20-alpine AS gitrss-backend-runtime-deps
WORKDIR /app/gitrss/backend
RUN npm install -g pnpm@10
COPY gitrss/backend/package.json gitrss/backend/pnpm-lock.yaml ./
RUN pnpm install --frozen-lockfile --prod

#------------------------GitRSS Finish------------------------


#------------------------PackageJsonAnalyzer Start------------------------
FROM node:20-alpine AS package-json-analyzer-frontend-builder
WORKDIR /build/package-json-analyzer/frontend
ENV VITE_API_BASE=/package-json-analyzer/api
RUN npm install -g pnpm@10
COPY package-json-analyzer/frontend/package.json package-json-analyzer/frontend/pnpm-lock.yaml ./
RUN pnpm install --frozen-lockfile
COPY package-json-analyzer/frontend/src ./src
COPY package-json-analyzer/frontend/index.html package-json-analyzer/frontend/vite.config.ts package-json-analyzer/frontend/tsconfig.json ./
RUN pnpm build


FROM node:20-alpine AS package-json-analyzer-backend-builder
WORKDIR /build/package-json-analyzer/backend
RUN npm install -g pnpm@10
COPY package-json-analyzer/backend/package.json package-json-analyzer/backend/pnpm-lock.yaml ./
RUN pnpm install --frozen-lockfile
COPY package-json-analyzer/backend/src ./src
COPY package-json-analyzer/backend/tsconfig.json ./
RUN pnpm build


FROM node:20-alpine AS package-json-analyzer-backend-runtime-deps
WORKDIR /app/package-json-analyzer/backend
RUN npm install -g pnpm@10
COPY package-json-analyzer/backend/package.json package-json-analyzer/backend/pnpm-lock.yaml ./
RUN pnpm install --frozen-lockfile --prod

#------------------------PackageJsonAnalyzer Finish------------------------



#------------------------Openapi Merger Start------------------------
FROM node:20-alpine AS openapi-merger-backend-build
RUN npm install -g pnpm
RUN pnpm config set ignore-scripts false
ENV CI=true
ENV NODE_ENV=development

COPY openapi-merger/shared  /build/openapi-merger/shared
COPY openapi-merger/backend /build/openapi-merger/backend

WORKDIR /build/openapi-merger/shared
RUN pnpm install --no-frozen-lockfile --reporter=silent

WORKDIR /build/openapi-merger/backend
RUN pnpm install --no-frozen-lockfile --reporter=silent
RUN pnpm build


FROM node:20-alpine AS openapi-merger-frontend-build
RUN npm install -g pnpm
RUN pnpm config set ignore-scripts false
ENV CI=true
ENV NODE_ENV=development
ENV VITE_API_BASE_URL=/openapi-merger/api

COPY openapi-merger/shared  /build/openapi-merger/shared
COPY openapi-merger/frontend /build/openapi-merger/frontend

WORKDIR /build/openapi-merger/shared
RUN pnpm install --no-frozen-lockfile --reporter=silent

WORKDIR /build/openapi-merger/frontend
RUN pnpm install --no-frozen-lockfile --reporter=silent
RUN pnpm build
#------------------------Openapi Merger End------------------------


FROM node:20-alpine
WORKDIR /app
RUN apk add --no-cache nginx

#copy frontend
COPY --from=frontend-builder /build/frontend/out /usr/share/nginx/html/main-frontend

#copy gitrss frontend and backend
COPY --from=gitrss-frontend-builder /build/gitrss/frontend/dist /usr/share/nginx/html/gitrss
COPY --from=gitrss-backend-runtime-deps /app/gitrss/backend/node_modules /app/gitrss/backend/node_modules
COPY --from=gitrss-backend-builder /build/gitrss-backend/dist /app/gitrss/backend/dist


#copy package-json-analyzer frontend and backend
COPY --from=package-json-analyzer-frontend-builder /build/package-json-analyzer/frontend/dist /usr/share/nginx/html/package-json-analyzer
COPY --from=package-json-analyzer-backend-runtime-deps /app/package-json-analyzer/backend/node_modules /app/package-json-analyzer/backend/node_modules
COPY --from=package-json-analyzer-backend-builder /build/package-json-analyzer/backend/dist /app/package-json-analyzer/backend/dist


#copy openapi-merger frontend and backend
COPY --from=openapi-merger-backend-build /build/openapi-merger/backend/node_modules /app/openapi-merger/backend/node_modules
COPY --from=openapi-merger-backend-build /build/openapi-merger/backend/dist /app/openapi-merger/backend/dist
COPY --from=openapi-merger-frontend-build /build/openapi-merger/frontend/dist /usr/share/nginx/html/openapi-merger

# set ports for backend services
ENV GITRSS_PORT=3000
ENV PACKAGE_JSON_ANALYZER_PORT=3001
ENV OPENAPI_MERGER_PORT=3002

# copy swagger ui api docs
COPY swagger-ui-docs/index.html  /usr/share/nginx/html/api-docs/
COPY swagger-ui-docs/openapi.json  /usr/share/nginx/html/api-docs/


#copy nginx config and start script
COPY docker/reverseproxy.conf /etc/nginx/http.d/default.conf
COPY docker/start.sh ./
RUN chmod +x ./start.sh
EXPOSE 80

CMD ["./start.sh"]