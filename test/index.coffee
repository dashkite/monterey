import assert from "@dashkite/assert"
import { test, success } from "@dashkite/amen"
import print from "@dashkite/amen-console"
import $ from "../src"

# TODO mock window.location 
#      blocks remaining tests

do ->

  print await test "Montery", [

    test "query", [

      test "object", ->
        registry = $.make()
        registry.add "/a/{x}/{y}", name: "test"
        page = registry.query name: "test"
        assert page?
        assert page.data?
        assert.equal page.data.name == "test"

      test "path"

      test "url"

    ]

    test "link"
    
  ]

  process.exit if success then 0 else 1
