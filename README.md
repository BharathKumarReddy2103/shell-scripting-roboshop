# 🤖 RoboShop Shell Scripting Deployment

Welcome to the **RoboShop Shell Scripting** repository. This project provides production-ready shell scripts to automate the deployment of **RoboShop**, a microservices-based e-commerce application designed to sell robots 🛒⚙️

This repository is a part of a real-world DevOps project and demonstrates how shell scripting can be used to manage service deployments efficiently across multiple components.

---

## 📦 What is RoboShop?

RoboShop is a modern e-commerce application built using multiple services (microservices architecture). Each service is developed using different technologies like Node.js, Java, Python, Go, etc. This repo contains shell scripts to automate the installation, configuration, and management of these services.

---

## 📁 Repository Structure

```bash
├── catalogue.sh
├── cart.sh
├── user.sh
├── shipping.sh
├── payment.sh
├── mysql.sh
├── mongodb.sh
├── rabbitmq.sh
├── redis.sh
├── nginx.sh
├── load-balancer.sh
├── common.sh
└── README.md
````

Each script is modular and handles the setup of a specific service or database component.

---

## 🚀 Features

* Automated installation and configuration of all RoboShop components
* Modular scripts for individual service deployment
* Common reusable functions via `common.sh`
* Environment setup for CentOS / RHEL / Oracle Linux
* Systemd service registration
* Follows DevOps best practices for shell scripting

---

## ⚙️ Technologies Used

* Shell Scripting (Bash)
* Linux (Oracle Linux / CentOS / RHEL)
* Systemd
* MongoDB, MySQL, Redis, RabbitMQ
* Node.js, Java, Python, Nginx

---

## 🛠️ How to Use

### 1. Clone this repo:

```bash
git clone https://github.com/BharathKumarReddy2103/Shell-Scripting-roboshop.git
cd Shell-Scripting-roboshop
```

### 2. Run the desired service script:

```bash
sudo bash catalogue.sh
```

Or automate all components in sequence via a custom wrapper script or by chaining script execution.

> 💡 Ensure you run with root privileges and on supported OS environments.

---

## 📌 Best Practices Followed

* Error handling and validation using shell logic
* Logging and status updates for each step
* Use of variables and reusable code via `common.sh`
* Service registration and status checks

---

## 🧠 Learning Outcomes

This project is great for DevOps engineers who want to:

* Practice real-world shell scripting
* Automate application deployments
* Understand microservices architecture and how services interact
* Learn Linux system administration tasks

---

## 🤝 Contributing

Contributions, issues, and feature requests are welcome.

If you'd like to contribute:

1. Fork the repository
2. Create a new branch
3. Make your changes
4. Submit a pull request

---

## 📄 License

This project is open-source and available under the [MIT License](LICENSE).

---

## 🙋‍♂️ Author

**Bharath Kumar Reddy**
Senior DevOps & DataOps Engineer | AWS | Kubernetes | GitHub Actions | Shell Scripting
🔗(www.linkedin.com/in/bharath-kumar-reddy2103)

---

## ⭐ Star this repository to support the project.
