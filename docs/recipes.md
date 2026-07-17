# Monterey Recipes

This document provides task-based scenarios for utilizing Monterey.

## How to register basic routes and perform URL matching?

Creators often need a straightforward way to associate URL patterns with specific data payloads. Monterey enables this by leveraging RFC 6570 templates. Developers can register standard URL patterns and later extract the matched data utilizing a URL string.

```coffeescript
import Registry from "@dashkite/monterey"

registry = Registry.make()

registry.add "/articles/{id}",
  name: "article"

# Fetch a matching route payload
page = registry.query "/articles/1024"
```

1. Instantiate a new registry utilizing `Registry.make`.
2. Register a route pattern and an associated data object utilizing `add`.
3. Locate the specific page by calling `query` with the desired URL string.

## How to define catch-all and priority routes?

When building complex applications, certain routes need to preempt broader patterns, while others must act as safety nets. Monterey evaluates routes sequentially based on registration order. You can leverage this deterministic behavior to orchestrate route priority precisely.

```coffeescript
# Establish a catch-all route at the bottom of the routing table
registry.append "/*", name: "not_found"

# Ensure a specific route bypasses general wildcard patterns
registry.prepend "/articles/featured", name: "featured_article"

# The specific route matches before the catch-all
page = registry.query "/articles/featured"
```

1. Insert generic or fallback routes at the end of the routing table utilizing `append`.
2. Insert highly specific routes that require immediate precedence at the beginning of the table utilizing `prepend`.
3. Execute a `query` to verify the registry honors the correct sequence.

## How to execute logical routing and dynamic linking?

Hardcoding URLs throughout a codebase creates brittle architectures. Monterey solves this by allowing developers to query routes by their logical names and dynamically construct standard `URL` objects based on data bindings.

```coffeescript
# Query the route configuration directly
namedPage = registry.query name: "article"

# Construct a URL for the route
url = registry.link
  name: "article"
  bindings: id: "2048"
```

1. Retrieve a specific route without relying on string patterns by passing an object query to `query`.
2. Construct a fully formed `URL` object utilizing `link`.
3. Provide the logical name alongside any required bindings to fulfill the template requirements.

## How to programmatically manipulate browser history?

Interactive single-page applications require programmatic transitions between distinct views without triggering full page reloads. Monterey integrates directly with the modern browser navigation API, providing a streamlined mechanism for these transitions.

```coffeescript
# trigger a state transition utilizing logical routing
registry.navigate
  name: "article"
  bindings: id: "4096"
```

1. Determine the target view and any required data bindings.
2. Invoke the `navigate` method on the registry instance.
3. Pass the routing criteria, allowing the registry to construct the URL and instruct the browser to update the current history state.
