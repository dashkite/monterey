# Technical Notes

### Polymorphic query method

The `query` method uses `@dashkite/generic` to provide a polymorphic interface. It processes `Object`, `URL`, `Location`, and `String` inputs. When an object contains a `name` property, it specifically filters routes matching that name or its aliases, using `@dashkite/joy/object`'s `query` method for evaluating the remaining properties.

### Integration with URL Codex and RFC 6570

Monterey draws heavily from the underlying `@dashkite/url-codex` library for template management. URL Codex aims to be fully compliant with [RFC 6570](https://tools.ietf.org/html/rfc6570) when expanding templates into URLs. Furthermore, it adheres to the spirit of the RFC 6570 standard when reversing this process (destructuring URLs back into data objects), even though reverse routing is not a feature formally defined by the RFC specification.

### Browser Navigation API and Cordoba

The `navigate` method relies on the modern [Navigation API](https://developer.mozilla.org/en-US/docs/Web/API/Navigation_API). This API provides a modern, decoupled interface for managing processes that react to page navigation or link clicks in single-page applications, allowing the browser to handle many low-level details. 

Most of the detailed Navigation API configuration and event handling occurs in the companion library, Cordoba. Monterey maintains a strict focus on the registration of *routes* and presenting a stable, deterministic ordering that affects route matching.

### Compact bindings

When constructing links, Monterey utilizes a local `compact` helper to remove undefined or empty string values from the bindings before passing them to the URL codex `encode` function.
