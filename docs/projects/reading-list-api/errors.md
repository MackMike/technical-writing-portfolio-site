# Error handling

When a request fails, the Reading List API returns an HTTP error status and a JSON body that explains what went wrong. Every error uses the same structure, so you can write one error handler for the whole API.

## Error format

Errors follow the Problem Details standard, [RFC 9457](https://www.rfc-editor.org/rfc/rfc9457.html), and are returned with the `application/problem+json` content type.

```json
{
  "type": "https://example.com/problems/not-found",
  "title": "Resource not found",
  "status": 404,
  "detail": "No book exists with ID bk_999.",
  "instance": "/books/bk_999"
}
```

| Field | Type | Description |
| --- | --- | --- |
| `type` | string (URI) | Identifies the kind of error. Use it to branch on error kinds in code. |
| `title` | string | A short summary of the error kind. The same for every occurrence of that kind. |
| `status` | integer | The HTTP status code, repeated in the body for convenience. |
| `detail` | string | An explanation of this specific occurrence. Safe to show in logs, not designed for end users. |
| `instance` | string | The request path that produced the error. |
| `errors` | array | Field-level problems. Present only on `400` responses. See [Field-level errors](#field-level-errors). |

!!! note "The `type` URIs are placeholders"
    The `type` values in this sample point to `example.com`, and no pages exist at those addresses. In a production API, each `type` URI would link to documentation for that error.

## Status codes

| Status | Title | When it happens | How to fix it |
| --- | --- | --- | --- |
| `400` | Bad request | A request body or query parameter failed validation. | Read the `errors` array, correct each listed field, and resend the request. |
| `401` | Unauthorized | The `X-API-Key` header is missing or the key is not valid. | Send a valid key in the `X-API-Key` header. See [Authentication](authentication.md). |
| `404` | Resource not found | No book exists with the ID in the path. | Check the ID. Use an `id` returned by the API, which always starts with `bk_`. |

## Field-level errors

A `400` response includes an `errors` array with one entry for each invalid field or query parameter:

```json
{
  "type": "https://example.com/problems/bad-request",
  "title": "Bad request",
  "status": 400,
  "detail": "The request body is invalid.",
  "instance": "/books",
  "errors": [
    { "field": "title", "message": "This field is required." },
    { "field": "status", "message": "Must be one of unread, reading, or finished." }
  ]
}
```

Each entry has two fields: `field` names the invalid field or query parameter, and `message` says what is wrong and how to fix it.

These are the validation rules that can produce a `400`:

| Where | Field | Rule |
| --- | --- | --- |
| Request body | `title` | Required. 1 to 200 characters. |
| Request body | `author` | Required. 1 to 100 characters. |
| Request body | `status` | Required. One of `unread`, `reading`, or `finished`. |
| Query string | `status` | Optional. One of `unread`, `reading`, or `finished`. |
| Query string | `limit` | Optional. An integer from 1 to 100. Defaults to 20. |

An invalid query parameter on `GET /books` produces the same structure:

```json
{
  "type": "https://example.com/problems/bad-request",
  "title": "Bad request",
  "status": 400,
  "detail": "One or more query parameters are invalid.",
  "instance": "/books",
  "errors": [
    { "field": "limit", "message": "Must be an integer between 1 and 100." }
  ]
}
```

## Handle errors in code

Check the status code first. If the request failed, parse the body as JSON, use `status` and `title` to decide what to do, and log `detail` for debugging. When `errors` is present, report each field.

=== "JavaScript"

    ```javascript
    const response = await fetch("http://127.0.0.1:4010/books", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-API-Key": "demo-key",
      },
      body: JSON.stringify({ status: "unread" }),
    });

    if (!response.ok) {
      const problem = await response.json();
      console.error(`${problem.status} ${problem.title}: ${problem.detail}`);
      for (const error of problem.errors ?? []) {
        console.error(`  ${error.field}: ${error.message}`);
      }
    }
    ```

=== "Python"

    ```python
    import requests

    response = requests.post(
        "http://127.0.0.1:4010/books",
        headers={"X-API-Key": "demo-key"},
        json={"status": "unread"},
    )

    if not response.ok:
        problem = response.json()
        print(f'{problem["status"]} {problem["title"]}: {problem["detail"]}')
        for error in problem.get("errors", []):
            print(f'  {error["field"]}: {error["message"]}')
    ```

Against the mock server, either example prints:

```text
400 Bad request: The request body is invalid.
  title: This field is required.
  status: Must be one of unread, reading, or finished.
```

!!! warning "The mock's 400 body is fixed"
    A real server would list only the fields that were invalid in your request. The mock always returns the same example, as explained in the [Quickstart](quickstart.md#4-trigger-the-errors).

## Troubleshooting

- **Getting `401` on every request?** Confirm the header is named `X-API-Key` and that the value has no extra spaces.
- **Getting `400` on a `POST`?** Confirm you are sending `Content-Type: application/json` and that `title`, `author`, and `status` are all present.
- **Getting `400` on a `GET`?** Check that `limit` is a whole number from 1 to 100 and that `status` is spelled exactly as one of the three allowed values.
- **Getting `404`?** Copy the `id` directly from a previous response rather than typing it.

## Next steps

- Review the endpoints that can return each error in the [API reference](reference.md).
- Try triggering each error yourself in the [Quickstart](quickstart.md#4-trigger-the-errors).
