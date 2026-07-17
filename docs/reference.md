# Monterey API Reference

## Core Concepts

Before interacting with the registry, it is helpful to understand how Monterey evaluates route targets and handles associated data.

### Route Data
When defining a route, you provide a URL template and an associated `data` object. This object acts as the payload returned upon a successful match. The `data` object must include a `name` property to identify the route logically, and it may include `aliases` or any other custom metadata, such as handler functions or state requirements.

### Target Resolution
Monterey relies on a polymorphic query resolution mechanism provided by `@dashkite/generic`. This means methods that resolve routes can accept a variety of inputs:
- An **Object** representing query constraints (e.g., `{ name: "article" }`).
- A **String** representing an absolute or relative URL.
- A standard **URL** or **Location** object.

## Registry

The `Registry` class manages the prioritized list of URL templates and coordinates matching, linking, and navigation.

### make

$make: \to registry$

Instantiates and returns a new registry. Each registry maintains its own internal routing table and URL Router instance.

```coffeescript
import Registry from "@dashkite/monterey"

registry = Registry.make()
assert.ok registry.router
```

### append

$append: template, data \to \emptyset$

Appends a route to the end of the routing table. Because routes are evaluated sequentially, appending a route ensures it will only be matched if no previously added routes match the target. This makes it ideal for defining fallback or "catch-all" routes.

```coffeescript
registry.append "/*", name: "fallback"

page = registry.query "/unknown-path"
assert.equal page.data.name, "fallback"
```

### prepend

$prepend: template, data \to \emptyset$

Prepends a route to the beginning of the routing table. This grants the route the highest priority during evaluation, allowing specific templates to preempt broader patterns.

```coffeescript
registry.prepend "/users/admin", name: "admin_profile"

page = registry.query "/users/admin"
assert.equal page.data.name, "admin_profile"
```

### add

$add: template, data \to \emptyset$

An alias for `prepend`. It registers a new route by placing it at the front of the routing table, guaranteeing immediate precedence over previously defined routes.

```coffeescript
registry.add "/posts/{id}", name: "post"

page = registry.query "/posts/42"
assert.equal page.data.name, "post"
```

### query

$query: target \to page$

Queries the registry for a matching route using a polymorphic target. The method evaluates the target against the routing table and returns the corresponding page object containing the `template` and `data`. If the target is an object, it evaluates the constraints against route data properties using `@dashkite/joy/object`.

```coffeescript
registry.add "/articles/{id}", name: "article"

pageByUrl = registry.query "/articles/10"
assert.equal pageByUrl.data.name, "article"

pageByName = registry.query name: "article"
assert.equal pageByName.data.name, "article"
```

### link

$link: description \to url$

Constructs and returns a standard `URL` object for a given route description. The description typically includes query properties to locate the route (such as `name`) and a `bindings` object providing the dynamic segment values necessary to expand the URL template via URL Codex.

```coffeescript
registry.add "/items/{id}", name: "item"

url = registry.link 
  name: "item"
  bindings: id: "42"
  
assert.equal url.pathname, "/items/42"
```

### navigate

$navigate: target \to \emptyset$

Programmatically navigates the browser to the specified target. It resolves the target into a fully formed URL utilizing the `link` method, and then invokes the native `navigation.navigate` API to update the browser state and trigger routing events.

```coffeescript
# Assuming execution within a modern browser environment
registry.add "/dashboard", name: "dashboard"

registry.navigate 
  name: "dashboard"
  bindings: {}
```
