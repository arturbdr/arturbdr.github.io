---
title: "Projects"
date: 2024-01-02
draft: false
---

A handful of projects from the past nine years that I'm most proud of, reverse chronological. The full work history is on the [Experience](/experience/) page.

## Internationalisation Platform
**Huspy** | 2025 – Present | Senior Engineer / Tech Lead, Core Team

Each Huspy platform — mobile, web, backend — handled translations differently. Proofreading workflow, versioning, and rolling out a new locale were three separate problems in three places, and adding a language meant engineering work everywhere.

**What I built**

- Wrote the RFC, evaluating Crowdin and the alternatives on CI/CD integration, proofreading workflow and cost
- Selected Crowdin and led the rollout across mobile, web and backend so all three platforms feed from the same translation source
- Replaced the per-platform setup with one shared integration owned end-to-end

**Stack** — Crowdin, integrated via CI/CD on mobile, web and backend.

**Result** — Now live with 7 languages. Adding a new locale is a content task — no engineering work needed.

## Document Service
**Huspy** | 2025 – Present | Senior Engineer / Tech Lead, Core Team

Huspy's documents and images were spread across many systems with no clear ownership or versioning. As the first project after joining the Core Team, I designed and led the build of a single Document Service for the entire engineering org (~20 engineers).

**What I built**

- Kotlin / Spring Boot microservices for document upload, download, and bulk operations
- AWS Lambdas for image resize, shrink, and watermarking
- AWS CloudFront with signed URLs so file names cannot leak sensitive data
- A Datadog-based monitoring standard (APM + logs) adopted across teams
- k6 load tests as part of the rollout

**Stack** — Kotlin, Spring Boot, AWS Lambda, S3, CloudFront, Postgres, Terraform, Kubernetes, k6, Datadog.

**Result** — Single source of truth for documents and images across the platform. Document load times dropped ~30% after Datadog-driven tuning. Image resizing is now available to end users.

## Shared JWT Validation Library
**Huspy** | 2025 – Present | Senior Engineer / Tech Lead, Core Team

Every microservice at Huspy had its own copy of JWT validation code. That made supporting multiple identity providers painful, and any change to validation had to be repeated across all services.

**What I built**

- Two libraries with identical behaviour — one for Spring Boot, one for Node.js
- At startup, the library fetches and caches signing keys per Keycloak realm and AWS Cognito pool
- On every incoming request, before the controller runs, it reads the realm claim from the JWT and validates the token against the keys for that realm
- A service only declares the realms it trusts — the library does the rest

**Stack** — Spring Boot, Kotlin, Node.js, TypeScript, JWT, Keycloak, AWS Cognito.

**Result** — Hand-written JWT validation removed from every microservice. Services can now talk to Keycloak and AWS Cognito at the same time. Adding a new realm is config, not code.

## LTI 1.3 Microservice
**GoodHabitz** | 2024 | Senior Software Engineer / Architect

LTI and Remote SCORM are the protocols connecting Learning Management Systems to content providers like GoodHabitz. The legacy service handling LTI 1.1 and RScorm didn't scale, was hard to maintain, and had almost no observability. With two other engineers, I took it over and added LTI 1.3 support.

**What I built**

- New microservice using the Strangler Pattern — started as a proxy in front of the legacy code, then took over piece by piece
- LTI 1.3 protocol support layered on top of the migrated LTI 1.1 / RScorm code
- GCP Pub/Sub for asynchronous student-progress events
- Migration from SQL Server to a new Postgres database
- Datadog dashboards showing per-customer integration health
- LaunchDarkly feature toggles to migrate customers without disruption

**Stack** — .NET 6, .NET 8, Postgres, GCP Pub/Sub, SQL Server, LaunchDarkly, Datadog, Grafana, GitHub Actions.

**Result** — All clients moved to the new system without disruption. New dashboards exposed which companies and courses drove the most usage, giving the business useful data. Architecture leaves room for adding xAPI later.

## Strangling the Order Management System
**Jumbo** | 2020 – 2022 | Principal Software Engineer

Jumbo's e-commerce Order Management System was a Java 7 / Mule / Spring 3 monolith — hard to scale, slow to evolve, painful to deploy.

**What I built**

- Identified the business domains living inside the monolith
- Led the solution and the development to extract them into Spring Boot microservices using the Strangler Pattern
- Each new microservice on Java 11+, with MongoDB or PostgreSQL, Redis caching, AWS SNS/SQS for messaging, Datadog for telemetry, deployed on Kubernetes

**Stack** — Java 11+, Spring Boot, MongoDB, PostgreSQL, AuroraDB, Redis, AWS SNS/SQS, Kubernetes, Datadog.

**Result** — One full domain (~150,000 lines of code) extracted out and handed off to a new team that now evolves it independently. Smaller monolith, easier deploys, no production incidents during the strangling. Pattern reused for further domain extractions.

## Checkout & Payment Integrations
**Netshoes** | 2016 – 2018 | Software Architect

Netshoes ran e-commerce across Brazil, Argentina and Mexico. The Checkout team needed integrations against 7+ payment methods across those countries on top of a previous Oracle ATG platform that was hard to extend.

**What I built**

- New Java / Spring Boot checkout platform replacing the previous Oracle ATG one
- Integrations with 7+ payment methods across three countries
- Jenkins-driven CI/CD with Sonar metrics enforcing code quality on every push
- Kafka and RabbitMQ for asynchronous integration; Redis and EhCache for hot reads
- Knowledge-transfer dojos to spread patterns across teams

**Stack** — Spring Boot, Spring Cloud (Feign, ConfigServer, Zuul), RabbitMQ, Kafka, Redis, EhCache, MongoDB, Jenkins, JUnit, Mockito, Spock.

**Result** — Faster, more maintainable platform; new payment integrations now far easier to add than on the old ATG stack. Earlier and more frequent releases via the CI/CD pipeline.
