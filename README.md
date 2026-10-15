# UE23CS33BB6 : Information Security Laboratory

This repository contains code, documentation, lab reports, and problem statements for the laboratory exercises, case studies, and CTF challenges completed during the sixth semester as part of the **Information Security (IS)** course.

## Repository Overview

The repository is organised into lab folders for hands-on exercises, case-study folders, CTF challenge collections, and supplementary course material. The exercises are based largely on the [SEED Labs](https://seedsecuritylabs.org/) framework and cover both system-level and web-application security.

### Labs

- **Lab1** — Environment Variables and Set-UID Programs: how privileged programs read the environment and the risks that follow.
- **Lab2** — Shellcode: writing and assembling minimal shellcode for x86-64 and ARM64.
- **Lab3** — Buffer Overflow: stack-based memory-corruption and the classic overflow exercise.
- **Lab4** — Return-to-libc / ROP: bypassing non-executable stacks with return-oriented programming.
- **Lab5** — Format String Vulnerabilities: exploiting uncontrolled format specifiers.
- **Lab6** — Cross-Site Request Forgery (CSRF): attack and defence on the Elgg web platform.
- **Lab7** — Cross-Site Scripting (XSS): reflected/stored XSS and Content-Security-Policy defences.
- **Lab8** — SQL Injection: injection against a sample web app and parameterised-query defences.
- **Lab9** — Malware: studying worm and virus propagation in an isolated lab.
- **Lab10** — Penetration Testing: end-to-end assessment workflow.

### Other Material

- **CaseStudy1 / CaseStudy2** — Written security case-study analyses.
- **CTF_Practice_Mar26 / CTF_Mar28th** — Practice and competition CTF challenges with prompts and solution notes.
- **Malware Analysis - Assignment** — Malware analysis report and reference notes. (Live sample archives are intentionally not tracked — see `.gitignore`.)
- **ThreatModelingExercise** — Threat-modelling case study.

## About the Course

The Information Security laboratory focuses on the practical foundations of offensive and defensive security — memory-corruption vulnerabilities, web-application attacks, malware behaviour, threat modelling, and penetration testing — through controlled, hands-on exercises.

## Installation Instructions for macOS

Most exercises run inside Docker containers or on a SEED Labs VM. To work with them locally:

```bash
# Install Homebrew (if not already installed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Core tooling
brew install python3 git gdb
brew install --cask docker

# Common Python packages used across labs
pip3 install pwntools
```

### Running Lab Exercises

Each lab folder contains its own problem statement and, where applicable, a `docker-compose.yml` and source files. A common workflow:

```bash
# Move into a lab folder
cd Lab<X>

# Start the containerised lab environment where present
docker compose up -d
docker ps

# Run the provided scripts / exploits in the lab's own setup
python3 exploit.py

# Tear down
docker compose down
```

## Notes on Contents

- Several labs include compiled binaries, archives, and Docker image tarballs that are build artifacts; these are excluded via `.gitignore`.
- Malware sample archives from the malware-analysis assignment are **not** committed, by design.

**⚠️ Ethical Use Notice:** All material here is for educational use within the course. The techniques are meant to be practised only in the provided isolated lab environments. Do not use them against any system without explicit authorisation.

## License

This repository is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
