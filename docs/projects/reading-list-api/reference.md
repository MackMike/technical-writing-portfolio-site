# API reference

The reference documents every endpoint, parameter, request body, and response in the Reading List API. It is generated from the OpenAPI specification, so it always matches the specification exactly.

- [Open the API reference](api-reference.html){ target=_blank }: an interactive page with request and response examples and code samples in curl, JavaScript, and Python.
- [Download the OpenAPI specification](reading-list-api.yaml): the OpenAPI 3.1 source file. Use it to start a mock server, import the API into a tool such as Postman, or generate a client.

## What the reference covers

| Endpoint | Operation ID | Summary |
| --- | --- | --- |
| `GET /books` | `listBooks` | List books, optionally filtered by `status` and capped by `limit` |
| `POST /books` | `createBook` | Add a book to your reading list |
| `GET /books/{bookId}` | `getBook` | Get a single book by its ID |

For task-based guidance, start with the [Quickstart](quickstart.md). To see how the reference is produced, read [Process and tooling](process.md).
