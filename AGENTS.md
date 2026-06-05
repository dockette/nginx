# AGENTS.md

## Project

Dockette Nginx builds `dockette/nginx`, an Nginx image with SSL, HSTS, HTTP/2-oriented configuration, custom global config includes, site fragments, and Diffie-Hellman parameter files.

## Images

- Default image: `dockette/nginx:latest`.
- Build context: repository root `.` with `Dockerfile`, `nginx.conf`, `mime.types`, `conf.d/`, `site.conf.d/`, `sites.d/`, and DH parameter files.
- Base image: `dockette/stretch`.
- GitHub Actions tests `linux/amd64`, then publishes `linux/amd64,linux/arm64` through the shared Dockette Docker workflow on `master` and the weekly schedule.

## Commands

- `make build` builds `${DOCKER_IMAGE}:${DOCKER_TAG}` from `.`.
- `make test` runs `nginx -v` and validates the generated Nginx configuration with `nginx -t`.
- `make run` starts the image locally on `80:80` and `443:443`.

## Testing Notes

- Prefer `make test` after Dockerfile or Nginx configuration changes.
- Use `make -n build test run` to dry-run command wiring without requiring Docker.
- The smoke test requires Docker and a locally built `${DOCKER_IMAGE}:${DOCKER_TAG}` image.

## Guidelines

- Keep `Dockerfile`, `Makefile`, README, Nginx config files, and `.github/workflows/docker.yml` aligned.
- Prefer `DOCKER_*` names for Docker-related Makefile variables.
- Place `.PHONY: <target>` directly above each Makefile target.
- Keep README badges and maintenance sections consistent with other Dockette image repos.
- Do not introduce unrelated formatting or structural changes.
