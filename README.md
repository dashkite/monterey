# Monterey

*Browser-friendly URL-template-based routing.*

[![Hippocratic License HL3-CORE](https://img.shields.io/static/v1?label=Hippocratic%20License&message=HL3-CORE&labelColor=5e2751&color=bc8c3d)](https://firstdonoharm.dev/version/3/0/core.html)

Monterey provides a browser-friendly registry for URL-template-based routing. It maps RFC 6570 URL templates to specific data payloads and handlers.

## Features

- Evaluates routes sequentially based on registration priority.
- Supports querying routes by URL, location, or descriptive name.
- Connects directly with the browser's native `navigation` API.
- Provides a polymorphic interface via `@dashkite/generic`.

## Installation

```bash
pnpm install @dashkite/monterey
```

## Usage

Here is a common scenario for instantiating a registry, adding a route, and querying it.

```coffeescript
import Registry from "@dashkite/monterey"

registry = Registry.make()

registry.add "/hello/{name}",
  name: "greeting"
  handler: ({bindings}) ->
    console.log "Hello, #{bindings.name}"

# Query the route
page = registry.query "https://acme.org/hello/dan"

# Navigate via name and bindings
registry.navigate
  name: "greeting"
  bindings: name: "dan"
```

## Other Resources

- [Reference](docs/reference.md)
- [Recipes](docs/recipes.md)
- [Technical Notes](docs/technical-notes.md)
- [Testing](docs/testing.md)
