# 🤖 RoboShop Shell Scripting Deployment

![Shell Script](https://img.shields.io/badge/Bash-Shell%20Scripting-green)
![License](https://img.shields.io/github/license/BharathKumarReddy2103/shell-scripting-roboshop)
![GitHub Repo stars](https://img.shields.io/github/stars/BharathKumarReddy2103/shell-scripting-roboshop?style=social)

This repository contains **production-ready shell scripts** to deploy the **RoboShop microservices-based e-commerce application**. It's ideal for DevOps engineers practicing infrastructure automation and service orchestration using shell scripting.

---

## 📚 Table of Contents

- [📦 What is RoboShop?](#-what-is-roboshop)
- [📁 Repository Structure](#-repository-structure)
- [🚀 Features](#-features)
- [⚙️ Technologies Used](#️-technologies-used)
- [🛠️ How to Use](#️-how-to-use)
- [📌 Best Practices Followed](#-best-practices-followed)
- [🧠 Learning Outcomes](#-learning-outcomes)
- [🤝 Contributing](#-contributing)
- [📄 License](#-license)
- [🙋‍♂️ Author](#-author)

---

## 📦 What is RoboShop?

RoboShop is a modern **e-commerce application** built using a **microservices architecture**, where each service is developed using a different tech stack like Node.js, Java, Python, Go, etc.

This repository contains shell scripts to automate the installation, configuration, and management of all services and dependencies involved in RoboShop.

---

## 📁 Repository Structure

```bash
├── catalogue.sh
├── common.sh
├── frontend.sh
├── cart.sh
├── user.sh
├── shipping.sh
├── payment.sh
├── mysql.sh
├── mongodb.sh
├── rabbitmq.sh
├── redis.sh
├── roboshop.sh
├── nginx.sh
├── load-balancer.sh
├── common.sh
└── README.md
````

Each script is **modular** and focuses on setting up one service or database component.

---

## 🚀 Features

* ✅ Automated installation and configuration of all RoboShop components
* ✅ Modular scripts for individual service deployments
* ✅ Reusable helper functions via `common.sh`
* ✅ Support for CentOS / RHEL / Oracle Linux environments
* ✅ Systemd service registration for persistence
* ✅ Aligned with DevOps shell scripting best practices

---

## ⚙️ Technologies Used

* Bash (Shell Scripting)
* Linux (Oracle Linux / CentOS / RHEL)
* Systemd
* MongoDB, MySQL, Redis, RabbitMQ
* Node.js, Java, Python, Nginx

---

## 🛠️ How to Use

### 1. Clone the Repository

```bash
git clone https://github.com/BharathKumarReddy2103/Shell-Scripting-roboshop.git
cd Shell-Scripting-roboshop
```

### 2. Run the Desired Script

```bash
sudo bash catalogue.sh
```

You can automate all component setups by chaining these scripts or creating a custom wrapper.

> 💡 **Note:** Run scripts with root privileges on a supported Linux OS (Oracle Linux / CentOS / RHEL).

---

## 📌 Best Practices Followed

* 📋 Error handling and input validation
* 🧾 Step-by-step logging and user-friendly output
* 🔁 Reusable logic via `common.sh`
* 🔐 Systemd-based service registration and health checks

---

## 🧠 Learning Outcomes

This project is ideal for DevOps learners and practitioners looking to:

* Master real-world shell scripting for service deployments
* Automate microservices-based app deployment
* Understand service orchestration across multiple stacks
* Deepen Linux system administration and automation skills

---

## 🤝 Contributing

Contributions are welcome. If you’d like to improve or extend this project:

1. Fork this repository
2. Create a new feature branch
3. Make your changes
4. Open a pull request

---

## 📄 License

This project is licensed under the [MIT License](https://github.com/BharathKumarReddy2103/shell-scripting-roboshop/blob/main/LICENSE).

---

## 🙋‍♂️ Author

**Bharath Kumar Reddy**
Senior DevOps & DataOps Engineer | AWS | Kubernetes | GitHub Actions | Shell Scripting
🔗 [LinkedIn](https://www.linkedin.com/in/bharath-kumar-reddy2103)

---

⭐ **Star this repository** to support the project and help others discover it.
