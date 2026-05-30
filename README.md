# SDD Best Practice

A best practice template of APM package for Spec-Driven Development (SDD) in software projects, covering architecture, testing, observability, tech stack, project guidelines, and governance.

## Installation

1. Clone the repository

```shell
git clone https://github.com/take44444/sdd-best-practice.git
cd sdd-best-practice
```

2. Install APM

Please refer to the [Quickstart | Agent Package Manager](https://microsoft.github.io/apm/quickstart/) for instructions on installing APM.

3. apm install

```shell
apm install
```

## Get Started

1. Create the spec

Use the /specify command to describe what you want to build. Focus on the what and why, not the tech stack.

```shell
/specify Build an application that can help me organize my photos in separate photo albums. Albums are grouped by date and can be re-organized by dragging and dropping on the main page. Albums are never in other nested albums. Within each album, photos are previewed in a tile-like interface.
```
