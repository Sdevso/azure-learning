🚀 Your 30-Day Azure DevOps & GitOps Learning Journey
This roadmap is designed to guide you from foundational concepts to building a comprehensive DevOps pipeline using a powerful set of tools on Azure. The emphasis is on learning by doing with practical, hands-on challenges that build upon each other.

Remember: Becoming an "expert" in 30 minutes a day for a month is a stretch, but this plan will give you an incredibly strong foundation and momentum. Consistency and applying concepts immediately are your keys to success!

✨ Learning Objectives
By the end of this journey, you will:

Understand core DevOps principles and their application.

Master Infrastructure as Code (IaC) with Terraform on Azure.

Automate server configuration with Ansible.

Deploy and manage containerized applications on Azure Kubernetes Service (AKS).

Implement a GitOps workflow using Argo CD.

Automate your development and deployment processes with GitLab CI/CD and GitHub Actions.

Integrate these tools to build a full end-to-end CI/CD pipeline.

🛠️ Prerequisites & Tools
Before you begin, ensure you have the following:

Foundational Knowledge (Self-study if needed):
Basic Linux Command Line: Navigating directories, basic commands (ls, cd, mkdir, rm).

Git Fundamentals: Cloning repositories, committing changes, pushing, pulling, basic branching.

Docker Basics: Understanding containers, images, and Dockerfile concepts.

Cloud Computing Concepts: What is a VM, a network, a resource group? (Azure specific concepts will be covered).

Tools to Install Locally:
Git: Download & Install Git

Azure CLI: Install Azure CLI

Terraform CLI: Install Terraform

Ansible: Install Ansible (Requires Python)

kubectl: Install kubectl (Azure CLI can often install this for you: az aks install-cli)

Helm CLI: Install Helm (Used for packaging Kubernetes applications)

Text Editor / IDE: VS Code with extensions (e.g., Azure Terraform, Docker, YAML, Python) is highly recommended.

Azure Account: A free tier or subscription.

🗺️ The Learning Path: Modules & Challenges (30 Mins/Day)
Each module builds on the previous one. Focus on understanding the "why" and completing the "Challenge" for each day.

Module 1: Azure Fundamentals & Infrastructure as Code with Terraform (Days 1-7)
Goal: Understand Azure basics and provision cloud resources using Terraform.

Day 1: Azure CLI & Resource Groups

Concept: Introduction to Azure's foundational building blocks (Resource Groups) and how to interact with Azure using its command-line interface.

Challenge 1.1:

Log in to Azure CLI (az login).

Create an Azure Resource Group.

Delete the Resource Group.

Git Practice: Initialize a Git repository, commit your CLI commands to a README.md or a .sh script, and push to GitHub/GitLab.

Day 2: Terraform Basics - Providers & Resources

Concept: Introduction to Terraform syntax (.tf files), providers (AzureRM), and defining basic resources.

Challenge 2.1:

Create a new directory infra/azure-basics/.

Write a main.tf to define the azurerm provider.

Declare an Azure Resource Group resource using Terraform.

Run terraform init, terraform plan, terraform apply -auto-approve.

Verify the RG exists in Azure Portal. Run terraform destroy -auto-approve.

Git Practice: Commit and push your infra/azure-basics/ changes.

Day 3: Terraform Variables & Outputs

Concept: Making your Terraform code reusable using variables and extracting useful information with outputs.

Challenge 3.1:

Add variables.tf to define variables for your Resource Group name and location.

Modify main.tf to use these variables.

Add an outputs.tf to output the Resource Group ID.

Apply and destroy, passing variable values.

Day 4: Terraform Azure Virtual Networks & Subnets

Concept: Deploying networking components vital for cloud infrastructure.

Challenge 4.1:

Extend your Terraform code to create an Azure Virtual Network and two subnets within it, all in your existing Resource Group.

Output the VNet and Subnet IDs.

Day 5: Terraform Azure Virtual Machines

Concept: Provisioning compute resources (VMs) and connecting them to your network.

Challenge 5.1:

Add two Azure Virtual Machines (web-vm, app-vm) to your Terraform configuration.

Place them in the subnets created in Challenge 4.1.

Ensure SSH ports are open. Output their public IPs.

Day 6: Terraform Remote State

Concept: Storing Terraform's state file remotely (e.g., Azure Storage Account) for team collaboration and security.

Challenge 6.1:

Create an Azure Storage Account and Container using the Azure CLI (for the state backend).

Configure your Terraform backend in main.tf to use this Storage Account.

Run terraform init -reconfigure, terraform plan, terraform apply. Observe the state file moving to Azure.

Day 7: Review & Terraform Practice

Concept: Consolidate Terraform knowledge.

Challenge 7.1:

Review all your Terraform code.

Make a small change to a VM size or OS image in your main.tf.

Run terraform plan to see the proposed changes.

Run terraform apply to implement the change.

Perform a full terraform destroy to clean up all resources created so far (except the remote state storage account, which you'll keep).

Module 2: Configuration Management with Ansible (Days 8-12)
Goal: Automate software installation and configuration on VMs provisioned by Terraform.

Day 8: Ansible Basics & Inventory

Concept: What Ansible does (idempotency, agentless), and how to define target machines (inventory).

Challenge 8.1:

Create a new directory ansible/ in your root.

Create a static inventory.ini file for your web-vm and app-vm using their public IPs (from Terraform outputs).

Run a simple ad-hoc Ansible command (e.g., ansible -i inventory.ini web-vm -m ping).

Git Practice: Commit and push your Ansible inventory.

Day 9: Ansible Playbooks & Modules

Concept: Writing structured YAML playbooks to define tasks using various modules.

Challenge 9.1:

Create ansible/webserver-config/install_nginx.yml.

Write a playbook that connects to your web-vm and uses the apt (for Ubuntu) or yum (for CentOS) module to install Nginx.

Use the service module to ensure Nginx is running.

Run the playbook: ansible-playbook -i ../inventory.ini install_nginx.yml.

Verify Nginx is running on the VM.

Day 10: Ansible Variables & Handlers

Concept: Using variables within playbooks for flexibility and handlers for triggered actions.

Challenge 10.1:

Add a variable for the Nginx package name.

Add a copy module task to deploy a custom index.html file to /var/www/html.

Use a handler to restart Nginx only when index.html is changed.

Day 11: Ansible Roles

Concept: Organizing playbooks into reusable and shareable roles.

Challenge 11.1:

Convert your install_nginx.yml playbook into an Ansible role named nginx.

Modify ansible/webserver-config/main.yml to call this role.

Run the role.

Day 12: Dynamic Inventory (Azure)

Concept: Automatically fetching inventory from cloud providers like Azure, instead of static files.

Challenge 12.1:

Configure Ansible to use the Azure dynamic inventory plugin.

Modify your Ansible commands to use the dynamic inventory.

Run your Nginx role against dynamically discovered Azure VMs.

Module 3: Azure Kubernetes Service (AKS) & Containerization (Days 13-17)
Goal: Deploy a managed Kubernetes cluster and containerize a simple application.

Day 13: Dockerizing a Simple Application

Concept: How to package an application into a Docker image.

Challenge 13.1:

Create a new directory app/web-app/.

Inside, create a simple index.html and a basic Dockerfile to serve it with Nginx (or a simple Flask/Node.js app).

Build the Docker image locally: docker build -t my-web-app:v1 ..

Run the container locally: docker run -p 8080:80 my-web-app:v1. Verify in browser.

Git Practice: Commit and push your app/web-app/ Dockerfile and app.

Day 14: Azure Container Registry (ACR)

Concept: A private Docker registry in Azure to store your container images.

Challenge 14.1:

Extend your infra/azure-basics/ Terraform (or create a new infra/azure-acr/) to provision an Azure Container Registry (ACR).

Output the ACR login server.

Log in to ACR using az acr login.

Tag your local Docker image (my-web-app:v1) for ACR.

Push your Docker image to ACR.

Day 15: Deploying AKS with Terraform

Concept: Provisioning a managed Kubernetes cluster on Azure.

Challenge 15.1:

Create a new Terraform configuration infra/aks-cluster/.

Define an Azure Kubernetes Service (AKS) cluster resource.

Output the kube_config file or credentials.

Run terraform apply to deploy AKS.

Day 16: Basic Kubernetes Deployment on AKS

Concept: Core Kubernetes objects: Pods, Deployments, Services.

Challenge 16.1:

Configure kubectl to connect to your new AKS cluster: az aks get-credentials --resource-group <your-rg> --name <your-aks-name>.

Create a new directory config/simple-app/.

Write deployment.yaml and service.yaml manifests for your my-web-app Docker image (using the image from ACR).

Deploy your application to AKS: kubectl apply -f config/simple-app/.

Verify the deployment and service: kubectl get pods, kubectl get svc.

Access your application via the public IP of the Kubernetes service.

Day 17: Kubernetes Namespaces & Scaling

Concept: Organizing resources with namespaces and scaling applications.

Challenge 17.1:

Create a new Kubernetes namespace for your app (e.g., dev-app).

Deploy your my-web-app into this new namespace.

Scale your Nginx deployment to 3 replicas using kubectl scale.

Observe the new pods being created.

Module 4: GitOps with Argo CD (Days 18-22)
Goal: Implement a GitOps workflow where Kubernetes state is managed from a Git repository.

Day 18: GitOps Principles & Argo CD Installation

Concept: What GitOps is, its benefits (declarative, version-controlled, automated). Introduction to Argo CD as a GitOps tool.

Challenge 18.1:

Install Argo CD onto your AKS cluster. (You can typically find official installation manifests online).

Access the Argo CD UI via port-forwarding.

Retrieve the initial admin password.

Git Practice: Create a new remote Git repository (e.g., kubernetes-config) – this will be your "source of truth" for GitOps.

Day 19: Argo CD Application Definition

Concept: How Argo CD defines and syncs applications using an Application custom resource.

Challenge 19.1:

Move your config/simple-app/deployment.yaml and service.yaml into your new kubernetes-config Git repository.

In your local config/argocd/ directory, create simple-app-argocd.yaml.

Define an Application resource in this YAML that points Argo CD to your kubernetes-config repository's simple-app path and targets your AKS cluster.

Apply this Application manifest to AKS: kubectl apply -f config/argocd/simple-app-argocd.yaml.

Observe Argo CD syncing and deploying your app. Verify in Argo CD UI.

Day 20: Argo CD Sync & Health

Concept: Understanding Argo CD's reconciliation loop, sync status, and health checks.

Challenge 20.1:

Manually delete your my-web-app deployment from AKS using kubectl delete.

Observe Argo CD automatically "healing" (re-deploying) the application because it detects drift from Git.

Modify the replica count in your deployment.yaml in the Git repository.

Commit and push this change.

Observe Argo CD detecting the change and updating your application on AKS.

Day 21: Argo CD UI & CLI Exploration

Concept: Navigating the Argo CD user interface and using its command-line tool.

Challenge 21.1:

Explore the Argo CD UI: view application details, history, logs, and resources.

Use the argocd CLI to log in, list applications, and check their status.

Day 22: GitOps Best Practices

Concept: Discussion on separation of concerns (infra vs. app config), repository structure for GitOps, and branching strategies.

Challenge 22.1:

Reflect on your current Git repository structure. Discuss how infra, app, and config could be separate repos in a real-world scenario. (No coding, just conceptual understanding).

Module 5: CI/CD Pipelines with GitLab & GitHub Actions (Days 23-27)
Goal: Automate building, testing, and deploying using popular CI/CD platforms.

Day 23: GitLab CI/CD Basics

Concept: Introduction to .gitlab-ci.yml, stages, jobs, and runners.

Challenge 23.1:

Push your app/web-app/ code (Dockerfile, index.html) to a new GitLab repository.

Create a .gitlab-ci.yml file in the root of this repo.

Define a basic pipeline with a build stage that just prints "Building application..." and a test stage that prints "Running tests...".

Commit and push, observe the pipeline running in GitLab.

Day 24: GitLab CI/CD - Docker Build & Push

Concept: Building and pushing Docker images to ACR from GitLab CI.

Challenge 24.1:

Modify your .gitlab-ci.yml to:

Log in to your Azure Container Registry (ACR).

Build your my-web-app Docker image.

Push the image to ACR with a unique tag (e.g., using $CI_COMMIT_SHORT_SHA).

Commit and push, verify the image appears in ACR.

Day 25: GitHub Actions Basics

Concept: Introduction to .github/workflows/, jobs, steps, and using marketplace actions.

Challenge 25.1:

Push your infra/aks-cluster/ Terraform code to a GitHub repository.

Create a .github/workflows/terraform-plan.yml file.

Define a simple workflow that triggers on push, checks out code, and prints "Running Terraform plan...".

Commit and push, observe the workflow running in GitHub Actions.

Day 26: GitHub Actions - Azure Authentication & Terraform Plan

Concept: Securely authenticating to Azure from GitHub Actions using Service Principals/OIDC.

Challenge 26.1:

Create an Azure Service Principal (via Azure CLI) with Contributor role to your infrastructure Resource Group.

Add the Service Principal credentials as GitHub Secrets to your repository.

Modify terraform-plan.yml to:

Authenticate to Azure using the azure/login action and your secrets.

Install Terraform.

Run terraform init (with remote backend config).

Run terraform plan.

Commit and push, verify the plan output in the workflow logs.

Day 27: GitHub Actions - Terraform Apply (Conditional)

Concept: Automating terraform apply with safeguards (e.g., manual approval, specific branch).

Challenge 27.1:

Add a new job or modify your existing terraform-plan.yml workflow to perform terraform apply.

Implement a safety measure: Make the apply step require manual approval in a GitHub environment, or only run on a specific production branch.

Commit and push, test the apply process.

Module 6: End-to-End GitOps Pipeline (Days 28-30)
Goal: Integrate all tools into a seamless, automated GitOps deployment workflow.

Day 28: Orchestrating the Full Pipeline (Conceptual & Setup)

Concept: How application code changes trigger image builds, which then trigger Kubernetes manifest updates, leading to GitOps deployments.

Challenge 28.1:

Review your three Git repositories:

infra-repo (GitHub): Terraform for Azure (AKS, ACR).

app-code-repo (GitLab): Your application code, Dockerfile, and GitLab CI pipeline.

k8s-config-repo (GitHub or GitLab): Your Kubernetes manifests (Deployment, Service), watched by Argo CD.

Ensure all repos are set up and connected as in previous challenges.

Day 29: Automated Kubernetes Manifest Update

Concept: The bridge between application CI/CD and GitOps – how the CI/CD pipeline updates the K8s manifest in the config repo.

Challenge 29.1:

In your app-code-repo's GitLab CI pipeline (.gitlab-ci.yml):

After building and pushing the Docker image to ACR, add a new stage/job.

This job will clone your k8s-config-repo.

It will then use a tool like sed (or a Python script) to find and replace the image tag in your config/simple-app/deployment.yaml with the newly built image tag (e.g., my-web-app:$CI_COMMIT_SHORT_SHA).

It will then commit this change and push it back to the k8s-config-repo.

(Note: This requires GitLab CI to have write access to the k8s-config-repo. You'll need to set up a GitLab deploy token or SSH key for this).

Commit a small change to your application code.

Observe the GitLab CI pipeline run, update the K8s manifest, and push it.

Day 30: End-to-End Validation & Review

Concept: Observing the full GitOps flow in action.

Challenge 30.1:

After Challenge 29.1, open your Argo CD UI.

Observe Argo CD detecting the new commit in k8s-config-repo and automatically deploying the updated application image to AKS.

Access your application's public IP to confirm the new version is live.

Reflect: What did you learn? What were the hardest parts? What are the next steps for deeper learning?

💡 Motivation & Tips for Success
Small Chunks (30 Mins Daily): Stick to the 30-minute commitment. If a challenge takes longer, break it into smaller parts. Consistency beats marathon sessions.

Don't Copy-Paste Blindly: Type out the commands and code. Make mistakes, then fix them. That's how you truly learn.

Understand the "Why": For every command, tool, or configuration, ask "Why am I doing this? What problem does it solve?"

Troubleshooting is Learning: Errors are your best teachers. Read the error messages carefully, and use search engines (Google, Stack Overflow) to find solutions.

Document Your Progress: Keep notes on what you learn, commands you use, and issues you face.

Connect the Dots: After each module, explicitly think about how the new tool or concept fits into the broader DevOps picture.

Visualize: Use diagrams (mental or drawn) to see how components like Git, CI/CD, Argo CD, and AKS interact.

Celebrate Small Wins: Every successful terraform apply, ansible-playbook run, or pipeline green checkmark is a victory!

🚀 Next Steps & Advanced Topics
Once you've completed this roadmap, you'll have a formidable foundation. Consider these areas for deeper dives:

Advanced Terraform: Custom modules, Terragrunt, tfsec for security scanning.

Advanced Ansible: Custom facts, Jinja2 templating, Ansible Vault for secrets.

Kubernetes Deep Dive: StatefulSets, Helm Charts (advanced), network policies, custom resource definitions (CRDs).

Security: Integrating security scanning (SAST, DAST, container scanning) into CI/CD.

Monitoring & Logging: Implementing Prometheus, Grafana, Azure Monitor, ELK stack.

Service Mesh: Istio, Linkerd.

Chaos Engineering: Gremlin, LitmusChaos.

Cloud Cost Management: Understanding and optimizing Azure costs.

More Advanced CI/CD: Release strategies, blue/green deployments, canary deployments.

This journey will set you up for a highly in-demand career in DevOps. Enjoy the process!