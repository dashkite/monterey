compact = ( parameters ) ->
  if parameters?
    result = {}
    for key, value of parameters
      if ( parameters[ key ]? && parameters[ key ] != "" )
        result[ key ] = parameters[ key ]
    result
  else {}

error = ( message ) -> new Error "monterey: #{message}"

XRL =

  # hoists if url is a string
  # otherwise returns the URL object
  make: ( value ) -> 
    new URL value, window.location

  target: ( value ) ->
    url = XRL.make value
    url.pathname + url.search

export { 
  compact
  error
  XRL
}
