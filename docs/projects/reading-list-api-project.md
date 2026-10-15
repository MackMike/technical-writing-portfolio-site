# Reading List API Documentation

**One-sentence summary:**  
API documentation set for a fictional REST API that pairs an OpenAPI 3.1 specification and a generated reference with hand-written quickstart, authentication, and error-handling guides.

## Overview
This project documents the Reading List API, a fictional REST API for cataloging books and tracking reading status. It uses an OpenAPI-first workflow: the OpenAPI 3.1 specification is the source of truth, generates the interactive reference, and supports hand-written guides. These guides cover starting a local mock server, making requests in curl, JavaScript, and Python, using an API key, and handling errors. Every code sample was tested against the mock server.

## Audience
- Application developers building reading trackers or book-related tools
- Developers new to the API who need to make a first successful request quickly
- Developers integrating the API who need clear guidance on authentication and error handling

## Documentation Goal
The goal of this documentation is to help a developer go from nothing to a working request in about five minutes, and then give them what they need to build a reliable integration. It is intended to make authentication unambiguous, make every error self-explanatory, and keep the specification, the reference, and the guides consistent with one another.

## What This Sample Demonstrates
- OpenAPI 3.1 authoring, including reusable schemas and responses, field-level descriptions, validation rules, and examples
- Generated API reference with code samples in curl, JavaScript, and Python
- Task-based quickstart writing for developers
- Authentication guidance, including key-handling practices
- Standardized error documentation using Problem Details (RFC 9457), with field-level error detail
- Testing documentation against a mock server and documenting the mock's limits honestly
- Separating generated reference content from hand-written guidance

## Tools / Methods
- OpenAPI 3.1
- Redocly CLI (linting and reference generation)
- Prism (local mock server)
- Markdown
- MkDocs with Material for MkDocs
- GitHub
- Shell script to lint, regenerate the reference, and build the site
- Version-controlled documentation workflow

## Challenges / Writing Considerations
* Because the API is fictional and has no production backend, I used a Prism mock server built from its specification to make every example runnable. Unlike a real server, it accepts any API key, returns fixed responses, and stores no data. I tested these behaviors and documented differences that might surprise readers.
* A generator can create a reference page from a specification, but it cannot decide what field descriptions should say, what error responses should teach, or what new developers need first. The challenge was separating specification content from hand-written guides and keeping them consistent.
* Error docs should tell developers what to fix, not just what failed. I extended Problem Details with an `errors` array naming invalid fields and added a realistic example for each failure type.
* This was my first API documentation project, so I learned conventions readers expect, including operation IDs, reusable components, and multilingual code samples.

## Deliverables
- OpenAPI 3.1 specification (three operations, API key authentication, Problem Details errors)
- Generated, interactive API reference
- Quickstart with curl, JavaScript, and Python examples
- Authentication guide
- Error handling guide
- Process and tooling page documenting decisions, tradeoffs, and mock server behavior
- Changelog
- Build script for linting, reference generation, and site build

## Outcome / Why It Matters
This sample demonstrates the ability to document an API from specification to published guides. It shows how a technical writer can combine an OpenAPI source file, generated reference output, and hand-written content, and how testing against a mock server keeps documentation accurate. It also shows a repeatable, version-controlled workflow for keeping an API's documentation in step with its specification. 

## View the Project
- **View final sample:** [Reading List API Documentation](https://mackmike.github.io/technical-writing-portfolio-site/projects/reading-list-api/)
- **View generated API reference:** [Reading List API Reference](https://mackmike.github.io/technical-writing-portfolio-site/projects/reading-list-api/api-reference.html)
- **View OpenAPI specification:** [reading-list-api.yaml](https://github.com/MackMike/technical-writing-portfolio-site/blob/main/docs/projects/reading-list-api/reading-list-api.yaml)
- **View Markdown/source:** [reading-list-api folder](https://github.com/MackMike/technical-writing-portfolio-site/tree/main/docs/projects/reading-list-api)
- **View repository:** [GitHub Repository](https://github.com/MackMike/michael-scarborough-technical-writing-portfolio)

## Related Skills
Technical writing, API documentation, developer documentation, OpenAPI, REST API documentation, error documentation, quickstart writing, documentation tooling
