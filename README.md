# Tracks

Tracks is a web-application framework that handles incoming HTTP requests and
gives appropriate responses. It relies on Rack to create a server and
uses a router to filter requests made to this server and map them to the
appropriate controller. The controller has a series of methods for
different requests, each one generating a custom response. The user has the
option to respond with an ERB HTML template whose filename and path can
be automatically recognized. This framework was inspired by Rails.

## Example Use

To demonstrate the capacity of Tracks, navigate in your terminal to the
directory where this readme is found, and run the following:

`ruby bin/example_server.rb `

You have now started a local server at host:3000. In your browser, you
can navigate to the following paths:

`localhost:3000/languages`
`localhost:3000/languages/1/sampletexts`

Check out the file to see how it works.
