# Platform Usage Guide

Welcome to the ML IDP Platform! This guide shows you how to rapidly scaffold, develop, and deploy a new machine learning service securely.

## 1. Create a New ML Service

To create a new service, utilize our scaffolding script from the root of this repository:

```bash
./scripts/create-ml-service.sh <service-name>
```

For example:
```bash
./scripts/create-ml-service.sh fraud-detector
```

**What this script does:**
1.  Creates a Python FastAPI template application in `src/<service-name>`.
2.  Generates the necessary Dockerfile for building the container image.
3.  Injects a new Terraform workspace definition into `infra/environments/*/main.tf` using the standard ML-Service module.
4.  Generates a dedicated `values.yaml` for helm deployments under `helm/ml-service/<service-name>-values.yaml`.

## 2. Develop Your Application

Navigate to your newly created source directory:

```bash
cd src/<service-name>
```

You'll find an `app.py` script. Override the `predict` endpoint to include your customized ML logic (e.g., PyTorch inference, sklearn model loading). 

*Optionally test locally via Docker:*
```bash
docker build -t <service-name>:local .
docker run -p 8080:8080 <service-name>:local
```

## 3. Commit and Deploy

1.  Create a new feature branch: `git checkout -b feature/add-<service-name>`
2.  Add your files: `git add .`
3.  Commit: `git commit -m "feat: Add new <service-name> model"`
4.  Push: `git push -u origin feature/add-<service-name>`

### The CI/CD Process

Once you create a Pull Request, our GitHub Action workflow will:
1.  **Lint & Test:** Verify code quality.
2.  **Build Docker Image:** Build and push the image to the container registry.
3.  **Terraform Plan:** Run a speculative plan against the `dev` environment showing exactly what infrastructure changes (like new namespaces or budgets) will be applied.

Once your PR is reviewed and **merged to `main`**, the CI pipeline will execute a `terraform apply`, promoting your application to production.
