# Architecture Overview

This platform uses a multi-layered infrastructure-as-code and GitOps approach to provision and manage machine learning services.

## High-Level Architecture

1.  **Developer Port / CLI (`scripts/create-ml-service.sh`)**: Exposes self-service capabilities to ML engineers. It scaffolds applications using standardized templates.
2.  **Infrastructure as Code (Terraform)**: Defines cloud resources explicitly and modularly.
    *   **Modules:** Shared patterns for VPC, EKS, IAM, and ML services.
    *   **Environments:** Instantiations of modules for `dev`, `staging`, and `prod` state.
3.  **CI/CD Pipeline (GitHub Actions)**: Implements continuous integration and deployment.
    *   **Continuous Integration:** Lints code, builds container images, and runs `terraform plan`.
    *   **Continuous Deployment:** Applies terraform changes upon merging to `main`.
4.  **Kubernetes Configuration (Helm)**: Packages and manages application deployments targeting the EKS clusters.

## Security & Compliance Highlights

*   **Policy-as-Code (OPA):** Policies are enforced at both CI (via Terraform plan analysis) and runtime (via Kubernetes admission controllers).
*   **Workload Isolation:** Each ML service is provisioned in its own Kubernetes namespace.
*   **mTLS:** Internal service communication is encrypted.

## Cost Management
*   **Resource Quotas:** Kubernetes resource limits ensure noisy-neighbor protection and cost predictability.
*   **Budgeting Alerts:** Terraform `aws_budget` definitions alert teams when their specific service namespace exceeds monthly spending caps.
