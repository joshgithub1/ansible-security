# Ansible for security automation

Project Version: 0.0.1 (alpha)
Last updated README June 23, 2016

### Introduction

This project is a composable Continuous Integration pipeline for security minded professionals.  The project puts together a few key componenets with proper configuration management, testing, and deployment goals in mind.

Specifically workflow and containers that allow safe, tested contributions to security configuration items such as:

- Firewall configuration
- AWS Security Groups or VPC
- Automated config verification
 
Safe means that a contributor does not have to have access to the Ansible Controller in order to test or build configuration items through the use of the Ansible Controller.   In other words, whenever possible keep people off the controller.  Build tests and automation around use of the controller.

This project makes use of project items already created

- Docker
- [Docker: Ansible controller](https://hub.docker.com/r/sometheycallme/ansible-controller/)
- [Docker: Github autostager]()
- [Docker: Ansible webserver wrapper](https://github.com/cleanerbot/ansible-security/tree/master/webserver)
- [Continuous Integration](https://circleci.com/gh/cleanerbot/ansible-security)

### Composable Design

![Workflow](https://raw.githubusercontent.com/cleanerbot/ansible-security/master/security-automation-workflow.png)
