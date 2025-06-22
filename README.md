# 🚀 Jenkins-Based CI/CD Pipeline with Ansible, Docker, and Terraform For NodeJS App Deployment


## 📖 Project Overview

This project automates the deployment of a Node.js application using a complete CI/CD pipeline built with Jenkins, Ansible, and Terraform. It leverages AWS infrastructure to provision and configure resources including Jenkins master/slave EC2 instances, application EC2s behind a Load Balancer, and integrations with Slack for pipeline notifications. The app is connected to RDS and Redis and can be validated via specific endpoints.

---

## 🔑 Key Features

* **Infrastructure as Code (IaC)** using **Terraform** to provision EC2 instances and an Application Load Balancer.
* **Configuration Management** using **Ansible**:

  * Automates setup of private EC2 instances to host the application.
  * Configures EC2 Jenkins slave nodes with private IP access through a bastion host.

* **CI/CD Pipeline** with **Jenkins**:

  * Master Jenkins VM created and configured.
  * Slave agents configured to run builds.
  * Pipeline to deploy `nodejs_example` app from the `rds_redis` branch.
* **Slack Integration**:

  * Jenkins integrated with Slack for real-time build notifications on success/failure.
* **Application Load Balancer**:

  * Exposes Node.js app on port 80.
  * Provides `/db` and `/redis` endpoints for testing backend integrations.
* **SSH Bastion Configuration**:

  * Secure access to private EC2s through a bastion using `~/.ssh/config`.
* **Comprehensive Documentation**:

  * Step-by-step instructions with screenshots to reproduce the entire workflow.

---

## 🧰 Tech Stack

* **Terraform**: Infrastructure provisioning
* **Ansible**: Configuration management
* **Jenkins**: Continuous Integration/Delivery
* **AWS EC2**: Compute resources ( Bastion , Jenkins Master , Jenkins Slave , App )  
* **Slack**: Notifications
* **Node.js**: Sample application
* **RDS & Redis**: Backend services

---