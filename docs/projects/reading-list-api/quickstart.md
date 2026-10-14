# Quickstart

This guide gets you from nothing to a working request in about five minutes. You will start a local mock server, list your books, retrieve one, add one, and trigger each error the API can return.

## Before you begin

You need:

- [Node.js](https://nodejs.org/) 18 or later (needed for the mock server, and for the JavaScript examples, which use the built-in `fetch`).
- `curl`, which is included with macOS and most Linux distributions.
- Optional, for the Python examples: Python 3 and the `requests` library (`pip install requests`).

!!! note "No real server behind this API"
    The Reading List API is fictional, so you will run it against a mock server called [Prism](https://github.com/stoplightio/prism). The mock reads the OpenAPI specification and returns the example responses documented in it. It does not store data. [Process and tooling](process.md#what-the-mock-server-does-and-does-not-do) lists exactly what the mock does and does not do.

## Start the mock server

1. Download the [OpenAPI specification](reading-list-api.yaml) and save it as `reading-list-api.yaml`.

2. Install Prism:

    ```bash
    npm install -g @stoplight/prism-cli@5.16.0
    ```

3. Start the mock server from the folder that contains the file:

    ```bash
    prism mock reading-list-api.yaml
    ```

    You should see output similar to this. Leave the server running and open a second terminal for the rest of this guide.

    ```text
    [CLI] ℹ  info      GET        http://127.0.0.1:4010/books
    [CLI] ℹ  info      POST       http://127.0.0.1:4010/books
    [CLI] ℹ  info      GET        http://127.0.0.1:4010/books/bk_001
    [CLI] ▶  start     Prism is listening on http://127.0.0.1:4010
    ```

The base URL for every request in this guide is `http://127.0.0.1:4010`. The demo API key is `demo-key`.

!!! tip "Running the JavaScript examples"
    The JavaScript examples use top-level `await`, so save each one in a file that ends in `.mjs` (for example, `list-books.mjs`) and run it with `node list-books.mjs`.

## 1. List your books

Send a `GET` request to `/books`:

=== "curl"

    ```bash
    curl http://127.0.0.1:4010/books \
      -H "X-API-Key: demo-key"
    ```

=== "JavaScript"

    ```javascript
    const response = await fetch("http://127.0.0.1:4010/books", {
      headers: { "X-API-Key": "demo-key" },
    });
    console.log(response.status);
    console.log(await response.json());
    ```

=== "Python"

    ```python
    import requests

    response = requests.get(
        "http://127.0.0.1:4010/books",
        headers={"X-API-Key": "demo-key"},
    )
    print(response.status_code)
    print(response.json())
    ```

The API responds with `200 OK` and a list of books, most recently added first:

```json
{
  "items": [
    {
      "id": "bk_002",
      "title": "API Patterns",
      "author": "R. Designer",
      "status": "reading",
      "createdAt": "2026-10-02T14:30:00Z"
    },
    {
      "id": "bk_001",
      "title": "Docs for Developers",
      "author": "A. Writer",
      "status": "unread",
      "createdAt": "2026-09-28T09:15:00Z"
    }
  ]
}
```

To narrow the list, add the optional `status` and `limit` query parameters, for example `/books?status=unread&limit=10`. `status` must be `unread`, `reading`, or `finished`. `limit` must be an integer from 1 to 100 and defaults to 20.

!!! warning "The mock does not filter"
    A real server would return only unread books for `?status=unread`. The mock returns the same example list no matter which values you send. It does reject invalid values, such as `?limit=0`, with a `400` error.

## 2. Get one book

Send a `GET` request to `/books/{bookId}`, using an `id` from the list:

=== "curl"

    ```bash
    curl http://127.0.0.1:4010/books/bk_001 \
      -H "X-API-Key: demo-key"
    ```

=== "JavaScript"

    ```javascript
    const response = await fetch("http://127.0.0.1:4010/books/bk_001", {
      headers: { "X-API-Key": "demo-key" },
    });
    console.log(response.status);
    console.log(await response.json());
    ```

=== "Python"

    ```python
    import requests

    response = requests.get(
        "http://127.0.0.1:4010/books/bk_001",
        headers={"X-API-Key": "demo-key"},
    )
    print(response.status_code)
    print(response.json())
    ```

The API responds with `200 OK` and the book:

```json
{
  "id": "bk_001",
  "title": "Docs for Developers",
  "author": "A. Writer",
  "status": "unread",
  "createdAt": "2026-09-28T09:15:00Z"
}
```

## 3. Add a book

Send a `POST` request to `/books` with a JSON body. All three fields are required:

| Field | Type | Rules |
| --- | --- | --- |
| `title` | string | 1 to 200 characters |
| `author` | string | 1 to 100 characters |
| `status` | string | `unread`, `reading`, or `finished` |

=== "curl"

    ```bash
    curl -X POST http://127.0.0.1:4010/books \
      -H "Content-Type: application/json" \
      -H "X-API-Key: demo-key" \
      -d '{"title": "The Art of API Docs", "author": "Jane Example", "status": "unread"}'
    ```

=== "JavaScript"

    ```javascript
    const response = await fetch("http://127.0.0.1:4010/books", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-API-Key": "demo-key",
      },
      body: JSON.stringify({
        title: "The Art of API Docs",
        author: "Jane Example",
        status: "unread",
      }),
    });
    console.log(response.status);
    console.log(await response.json());
    ```

=== "Python"

    ```python
    import requests

    response = requests.post(
        "http://127.0.0.1:4010/books",
        headers={"X-API-Key": "demo-key"},
        json={
            "title": "The Art of API Docs",
            "author": "Jane Example",
            "status": "unread",
        },
    )
    print(response.status_code)
    print(response.json())
    ```

The API responds with `201 Created` and the new book. The server assigns the `id` and `createdAt` values:

```json
{
  "id": "bk_003",
  "title": "The Art of API Docs",
  "author": "Jane Example",
  "status": "unread",
  "createdAt": "2026-10-14T18:45:00Z"
}
```

!!! warning "The mock does not store books"
    Prism returns the same example response for every valid request. If you list your books again, the new book will not appear.

## 4. Trigger the errors

The API returns three kinds of error. Each one is easy to reproduce against the mock.

**`401 Unauthorized`: leave out the API key.**

```bash
curl -i http://127.0.0.1:4010/books
```

```http
HTTP/1.1 401 Unauthorized
Content-type: application/problem+json

{"type":"https://example.com/problems/unauthorized","title":"Unauthorized","status":401,"detail":"The X-API-Key header is missing or invalid.","instance":"/books"}
```

**`400 Bad Request`: send an invalid body.** This request is missing the required `title` and `author` fields:

```bash
curl -i -X POST http://127.0.0.1:4010/books \
  -H "Content-Type: application/json" \
  -H "X-API-Key: demo-key" \
  -d '{"status": "unread"}'
```

```http
HTTP/1.1 400 Bad Request
Content-type: application/problem+json

{"type":"https://example.com/problems/bad-request","title":"Bad request","status":400,"detail":"The request body is invalid.","instance":"/books","errors":[{"field":"title","message":"This field is required."},{"field":"status","message":"Must be one of unread, reading, or finished."}]}
```

!!! warning "The mock's 400 body is fixed"
    A real server would list only the fields that were actually invalid in your request. The mock always returns the same example body, so the `errors` list above does not match the request you sent. The status code is accurate.

**`404 Not Found`: ask the mock for it.** The mock returns a book for any ID, so use the `Prefer` request header to request a specific documented response:

```bash
curl -i http://127.0.0.1:4010/books/bk_999 \
  -H "X-API-Key: demo-key" \
  -H "Prefer: code=404"
```

```http
HTTP/1.1 404 Not Found
Content-type: application/problem+json

{"type":"https://example.com/problems/not-found","title":"Resource not found","status":404,"detail":"No book exists with ID bk_999.","instance":"/books/bk_999"}
```

The `Prefer: code=` header is a Prism feature, not part of the Reading List API. A real server would not need it.

## Next steps

- Learn how the API key works in [Authentication](authentication.md).
- See how to read and handle errors in [Error handling](errors.md).
- Browse every parameter and response in the [API reference](reference.md).
