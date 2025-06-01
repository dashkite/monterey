import * as Fn  from "@dashkite/joy/function"
import * as Obj  from "@dashkite/joy/object"
import Generic from "@dashkite/generic"
import { Router } from "@dashkite/url-router"
import { encode } from "@dashkite/url-codex"
import { 
  compact
  error
  XRL
} from "./helpers"

class Registry

  @make: ->
    Object.assign ( new @ ), router: new Router

  append: ( template, data ) ->
    @router.append { template, data }

  prepend: ( template, data ) ->
    @router.prepend { template, data }

  add: ( template, data ) -> 
    @prepend template, data

  query: do ->

    ( Generic.make "monterey::query" )

      .define [ Object ], ( query ) ->
        @router.routes.find ( page ) ->
           Obj.query query, page.data

      .define [ URL ], ( url ) ->
        @router.match XRL.target url

      .define [ Location ], ( url ) ->
        @router.match XRL.target url

      .define [ String ], ( target ) ->
        @query XRL.make target

  link: ({ query..., bindings }) ->
    if ( page = @query query )?
      origin = window.location.href    
      path = encode page.template, compact bindings
      new URL path, origin
    else
      console.warn error "page not found"
      console.warn query
      throw error "not found"

  navigate: ( target ) ->
    navigation.navigate @link target


  
export default Registry
