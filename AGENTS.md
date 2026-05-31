# Service Inventory Constitution

## Core Principles

### 1. Clean Architecture

- Strict separation of concerns between presentation, business logic, and data access layers
  - Business logic layer (service layer) **MUST NOT** directly depend on data access implementations; it **MUST** depend on abstractions (interfaces)
  - Presentation layer (API controllers) **MUST NOT** contain business logic; it **MUST** delegate to the service layer
  - Data access layer (repository layer) **MUST** be responsible for all interactions with the database and external data sources, and **MUST** expose an interface that abstracts away implementation details
- DTOs and DAOs **MUST NOT** be used in the service layer; only domain models defined in the service layer **MUST** be used there

### 2. Test-Driven Development (TDD)

- Red-Green-Refactor cycle **MUST** be followed for all new features and meaningful refactors
- Tests **MUST** be written before implementation based on the requirements and expected behavior of the feature

### 3. Quality Gates

- All code **MUST** pass linting checks
- All code **MUST** have at least 90% test coverage, and all tests **MUST** pass

### 4. Observability

- Implement logging for all critical operations and errors
- Use OpenTelemetry for distributed tracing and monitoring

## Tech Stack in Use

- Python 3.11+
- FastAPI for web framework
- uvicorn for ASGI server
- Injector for dependency injection
- OAuth2 for authentication
- Pydantic for data validation and settings management
- SQLAlchemy for ORM and data access
- PostgreSQL for production database
- SQLite for development and testing database
- pytest for testing
- Ruff for linting

## Project and Code Guidelines

- Must follow [PEP 8](https://peps.python.org/pep-0008/) for Python code style
- Type hints are required for all functions, methods, and variables
- Type "any" **MUST NOT** be used in type hints; all known models **MUST** be defined explicitly
- Docstrings are required for all public functions and classes

### Directory Structure

- Module must be created per OpenAPI specification in the `openapi/` directory
- An API router must be created for each module and included in the root API router
- Each module must have its own directory
- The directory structure **MUST** follow this pattern:
```
app/
├── main.py                         FastAPI application entry point
├── router/                         Root API router that includes all module routers
├── modulename1/                    Module directory for the first OpenAPI specification
│   ├── modules.py                  Production and development modules that inject dependencies for the service and repository implementations
│   ├── controller/                 Presentation layer
│   │   ├── router.py               FastAPI router for the module's endpoints
│   │   └── dto.py                  DTO for request and response validation defined using Pydantic models
│   ├── service/                    Business logic
│   │   ├── iservice.py             Service interface that controller depends on (abstraction for dependency inversion)
│   │   ├── service.py              Implementation of the service interface
│   │   └── model.py                Domain models that represent the core business entities (used in the service layer)
│   ├── repository/                 Data access layer
│   │   ├── irepository.py          Repository interface that service layer depends on (abstraction for dependency inversion)
│   │   ├── postgres_repository.py  PostgreSQL implementation of the repository interface (for production)
│   │   ├── sqlite_repository.py    SQLite implementation of the repository interface (for development and testing)
│   │   └── dao.py                  DAO defined using SQLAlchemy models
│   └── tests/
│       ├── common/                 Common test utilities and fixtures used by integration tests in the `suite/` directory
│       └── suite/                  Integration tests for the module that test the API endpoints and interactions between components
├── modulename2/                    Module directory for the second OpenAPI specification
│   ├── modules.py
...
```

## Governance

Constitution supersedes all other practices

### Governance Check

- All reviews must verify compliance
- Code that violates the constitution must be pointed out during the review and corrected