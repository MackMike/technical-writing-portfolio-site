# Reading List API

The Reading List API lets you keep a personal catalog of books and track your progress through each one. You can add a book, look one up by its ID, and list your books filtered by reading status.

!!! note "This is a fictional API"
    The Reading List API is a sample designed for this portfolio. It has no production backend. You can run every example in these docs against a local mock server built from the [OpenAPI specification](reference.md).

## Who this is for

Developers who want to build a reading tracker, a book-recommendation tool, or any app that needs a simple list of books with a status attached to each one.

## What you can do

| Method | Path | What it does |
| --- | --- | --- |
| `GET` | `/books` | List books, optionally filtered by reading status |
| `GET` | `/books/{bookId}` | Get a single book by its ID |
| `POST` | `/books` | Add a book to your reading list |

Every request is authenticated with an API key sent in the `X-API-Key` header, and every error uses the same [Problem Details](errors.md) format.

## Start here

1. **[Quickstart](quickstart.md)**: start a local mock server and make your first three requests.
2. **[Authentication](authentication.md)**: how the API key works and how to keep it safe.
3. **[Error handling](errors.md)**: what each error response means and how to fix it.
4. **[API reference](reference.md)**: every endpoint, parameter, and response, generated from the OpenAPI specification.

## About this sample

This piece shows an OpenAPI-first documentation workflow: the specification is the single source of truth, the reference is generated from it, and the guides around it are written by hand. [Process and tooling](process.md) explains the decisions behind it, including what the mock server can and cannot demonstrate. See the [changelog](changelog.md) for version history.
