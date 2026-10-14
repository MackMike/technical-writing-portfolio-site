# Changelog

All notable changes to the Reading List API and its documentation are recorded here. The API follows [semantic versioning](https://semver.org/): a change that could break existing clients increases the major version, a backward-compatible addition increases the minor version, and a fix or clarification increases the patch version.

## 1.0.0: 2026-10-14

Initial release.

### Added

- `GET /books`: list books, with optional `status` and `limit` query parameters.
- `POST /books`: add a book to the reading list.
- `GET /books/{bookId}`: get a single book by its ID.
- API key authentication through the `X-API-Key` header.
- Problem Details error responses (RFC 9457) for `400`, `401`, and `404`, with field-level `errors` on `400`.
