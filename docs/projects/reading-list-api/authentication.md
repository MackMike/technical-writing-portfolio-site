# Authentication

The Reading List API uses API key authentication. You send your key in the `X-API-Key` request header on every request. There are no tokens to refresh and no sign-in flow.

## Send your key

Add the header to each request:

```http
X-API-Key: demo-key
```

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
    ```

=== "Python"

    ```python
    import requests

    response = requests.get(
        "http://127.0.0.1:4010/books",
        headers={"X-API-Key": "demo-key"},
    )
    ```

HTTP header names are not case-sensitive, so `x-api-key` works as well as `X-API-Key`. The key itself is case-sensitive.

## Get a key

This sample has no sign-up or key-management page, because there is no production service behind it. Use the demo key `demo-key` for every example in these docs.

!!! note "The mock only checks that a key is present"
    The local mock server returns `401` when the `X-API-Key` header is missing, but it accepts any value. A production version of this API would also reject keys it does not recognize, and the [API reference](reference.md) documents that behavior.

## Keep your key safe

An API key grants access to your reading list, so treat it like a password.

- **Never put the key in a URL.** Query strings end up in server logs, browser history, and referrer headers. The API reads the key only from the `X-API-Key` header and returns `401` if you send it as a query parameter such as `?api_key=...`.
- **Never put the key in client-side code.** Anything that runs in a browser can be read by the person using it. Call the API from a server you control and keep the key there.
- **Store the key outside your source code.** Use an environment variable or a secrets manager, and add any local file that holds the key to `.gitignore`.
- **Use a different key for each environment.** Separate keys for development and production let you revoke one without breaking the other.

## If a key is exposed

For a production API like this one, the recommended response is to replace the key rather than try to contain the exposure:

1. Create a new key.
2. Update your application to use it.
3. Revoke the old key.

Because each request carries the key independently, replacing it takes effect immediately for new requests.

## Authentication errors

A request without a valid key receives `401 Unauthorized` with a [Problem Details](errors.md) body:

```json
{
  "type": "https://example.com/problems/unauthorized",
  "title": "Unauthorized",
  "status": 401,
  "detail": "The X-API-Key header is missing or invalid.",
  "instance": "/books"
}
```

| Cause | How to fix it |
| --- | --- |
| The `X-API-Key` header is missing | Add the header to the request. |
| The key is sent under a different header name, such as `Authorization` | Rename the header to `X-API-Key`. |
| The key is sent as a query parameter | Move it to the `X-API-Key` header. |
| The header is present but empty | Set the header to your key. |
| The key is not valid (production only) | Check for typos or extra whitespace, then confirm the key has not been revoked. |

## Next steps

- Try the requests in the [Quickstart](quickstart.md).
- See how all errors are structured in [Error handling](errors.md).
