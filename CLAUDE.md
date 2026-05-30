# Resource Inventory Constitution

## Core Principles

### 1. Clean Architecture

- Separation of concerns: Keep business logic, data access, and presentation layers separate
- Modular design: Organize code into reusable and independent modules
- Dependency inversion: High-level modules should not depend on low-level modules; both should depend on abstractions

### 2. Test-Driven Development (TDD)

- Red-Green-Refactor cycle: Write failing tests first, then implement code to pass the tests, and finally refactor for improvement

### 3. Integration Testing

Focus areas requiring integration tests:
  - API endpoints
  - Interactions between different components

### 4. Observability

- Implement logging for all critical operations and errors
- Use OpenTelemetry for distributed tracing and monitoring

## Tech Stack in Use

- Python 3.10+
- FastAPI for web framework
- OAuth2 for authentication
- SQLAlchemy as ORM
- PostgreSQL for production database
- SQLite for development and testing

## Project and Code Guidelines

- Follow [PEP 8](https://peps.python.org/pep-0008/) for Python code style
- Use type hints for all functions, methods, and variables
- Write docstrings for all functions and classes

### Directory Structure

- One module per OpenAPI specification in the `openapi/` directory
- An API router must be created for each module and included in the root router
- Each module should have its own directory with the following structure:
```
modulename/
├── controller/   API router
│   └── dto/      Data Transfer Objects for request and response validation
├── service/      Business logic
│   └── model/    Data models that represent the domain entities
├── repository/   Data access layer
│   └── dao/      Data Access Objects defined using SQLAlchemy models
└── tests/        
    ├── common/   Common test utilities and fixtures used by integration tests in the `suite/` directory
    └── suite/    Integration tests for the module
```

## Governance

Constitution supersedes all other practices

### Governance Check

- All reviews must verify compliance
- Code that violates the constitution must be pointed out during the review and corrected