# Launch School Course 360 - Notes

## Book Notes: Working with Web APIs

### Getting Started

#### HTTPie Option Reference

Option | What it does
--- | ---
-p | What to output: H and B for request headers and body, h and b for response headers and body
-a |  Authenticate with this username:password combination
--help | View command options and documentation

### Using Postman

Think of Postman as a specialized web browser that has a little more manual control. Let's send a GET request to `www.google.com` and see what it does.

Postman parses out the headers and displays the body in a nice syntax-highlighted format. Since the body is minified, it's a bit hard to read. If we search around, we can find `form` and `intput` elements from which we can learn to build a search query. We find the `path` is `/search`, and the parameter attached to the `input` field is `q`. We can build a URL based on this knowledge: let's send a GET to `www.google.com/search?q=puppies`. We can easily do this with the "params" option in Postman. This allows us to send a bunch of keys and values, and it'll automatically add them to the request headers/body/etc. depending on the type of request we're sending.

Again, the response we get is super minified and complicated, so it's really hard to find anything useful in it the way it is originally sent. This data includes CSS and JavaScript for showing how the response is to be displayed in a browser. It would be nice to simply get the data we want without all the display logic.

APIs are useful for this, since they can do a lot of different things that a user can do though a web browser, without the need to specify how the data is to be presented. API responses are usually just the data itself, represented in a way that makes it easy for a computer program to use.

DuckDuckGo gives us a useful search API that gives us clean responses without presentation logic. It returns a list of links similar in structure to the kinds of results a search engine would return. The url for this is `https://api.duckduckgo.com`, and we should specify that the format we want is `JSON`.

Let's send a request to that URL with the `q` we want, and the `format` set to JSON. The response we get is from DuckDuckGo's "instant answers" function, and it's designed to be consumed by a computer rather than a human. There is no HTML, CSS, or JavaScript in the response. There are lots of other formats we can use for data interchange, such as XML, but in this book we'll use JSON.

In this case we used HTTPS. APIs can be accessed using secure URLs. If we don't provide the protocol, Postman will assume we are using HTTP.

#### Checking the Weather

Let's build an application that displays the current weather. In order to do this, we can use an open weather API. OpenWeatherMap is one such service that provides an API for this functionality. The URL for this service is `http://api.openweathermap.org/data/2.5/weather`. We can format our request's params in quite a few different ways. Let's build a query for Washington, DC. We'll need to add a second parameter for our API key, too, with the key being `APPID` and its value being our API key.

Our response gives us a JSON object, and we can look up the meanings for each attribute in the API documentation.

One thing to notice is that the units for the temperature are sent in Kelvin. We can make the conversion to Fahrenheit on our end, or we can ask the API to return in imperial units. To do this, we add `units=imperial` to our params.

### Defining API

#### What is an API?

An API, or **Application Programming Interface**, is a way in which computer systems can interact with each other. Mobile devices provide APIs to provide access to location or other sensor data. OSs themselves provide APIs used by programs to access files, memory, and screen data. The one thing all APIs have in common is they provide functionality for use by other programs.

#### Web APIs

Here we'll focus on APIs that are built with web technologies--Web APIs, or HTTP APIs. We'll discuss more later how APIs relate to HTTP.

#### Provider and Consumer

- An API Provider is the system that provides the API for other parties to use. GitHub is the _provider_ of the GitHub API.
- An API Consumer is the system that uses the API to accomplish some work. When you check the weather on your phone, it is running a program that _consumes_ a weather API.

In this book we will be consumers of a "store" API. The web store server will be the provider.

#### What about Clients and Servers?

To just pull a quote from the book:

"Client and server are rather overloaded terms, with server conjuring up images of racks and racks of computers in massive server farms, and clients as being small or mobile computers. In this way, client and server are often used to indicate the location or size of a computer and not its role in communicating with another machine.

"When we speak of clients and servers in the context of APIs, the server is generally going to be the API provider and the client will be the consumer (technically, _a client is the side of a communication that initiates the connection_.) As a result of this, the terms are sometimes used as if they were synonyms.

"As a result, it is best to stick to using provider and consumer when discussing APIs, as this makes the relationship of the computer to the API much clearer."

### What APIs Can Do

#### Sharing Data

APIs are most commonly used to share data between systems. At a certain level, all APIs are used to transfer data.

#### Enabling Automation

"APIs allow users of a service to make use of it in new and useful ways."

#### Leverage Existing Services

Rather than building datasets on our own, many services provide APIs that allow us to offload a lot of our work and data onto them. We can process credit card payments and send emails using services designed that way, rather than doing the work on our own. This is especially useful for smaller companies with limited resources. This allows the developers to focus on their actual objectives, rather than worrying about the complexities of every part of the system.

In a way, it's like subcontracting for a construction project.

### Accessibility

#### Public and Private

__Public APIs__ are designed for consumption outside the organization that provides them. Twitter, Facebook, Instagram, etc. provide public APIs that third-party programs can use to interact with their services.

__Private APIs__ are intended only for internal use. For example, the Google search page uses a private API to get a list of search suggestions as we type words into the search box. We can make calls to private APIs sometimes, but it's typically not a great idea to do so.

Public APIs are competitively advantageous, so companyes that provide them are typically not shy about doing so.

#### Ts and Cs

It's always a good idea to check the Ts and Cs for a public API we are using in order to know the limits we need to work under.

### Media Types

#### Data Serialization

APIs generally involve the interchange of structured data. Most requests will use a content and media format that works well for representing heirarchical data. These are known as "data serialization formats." These are ways for programs to convert internal application data into a form that is more efficiently stored and transferred. This data can be converted back into the original data at any time  by any program that can understand the format.

#### XML

__eXtensible Markup Language__ shares a common heritage with HTML. XML is stricter than HTML in that it doesn't handle missing tags or improper nesting. XML was common in the past, but it is now much more common to see JSON as an interchange format.

#### JSON

__JavaScript Object Notation__ is perhaps the most popular data serialization format used by web APIs today. Its syntax is based on the way object literals are writting JavaScript. JSON is typically seen as simpler and less ambiguous than XML.

JSON is written in key/value pairs. It can represent objects, arrays, strings, and numbers. Here we will exclusively be using JSON.

### REST and CRUD

#### What is REST?

The term _REST_ is used to describe a set of conventions for how to build APIs. __REST__ stands for __REpresentational State Transfer__.

- _Representational_ refers to how a resource is represented when we transfer data, rather than the resource itself (a `JSON` representation of an `ActiveRecord` object, for example).
- _State Transfer_ refers to how HTTP is a stateless protocol. The server doesn't know anythign about the client, and everything the server needs to process the request (the state) is included in the request itself.

These ideas grew from observations about how the web already worked. From this, Fielding (the conceiver of REST) derived a set of formalized patterns about the kind of interactions that take place on the web.

Here are some of the possible ineractions that can take place between a client and a server, in the context of a social network profile. This involves loading pages, filling out forms, etc..

Action | HTTP Method | Path | Params
--- | --- | --- | ---
Load new profile page | GET | `/profiles/new` |
Submit filled out filled out new profile form | POST | `/profiles` | `email=test@example.com&password=password`
View new profile page | GET | `/profiles/1` |
Load the "edit" profile page | GET | `profiles/1/edit` |
Submit profile changes to server | POST | `/profiles/1` | `email=test2@example.com`
View new profile page | GET | `/profiles/1` |
Click the "delete profile" button | POST | `/profiles/1` | `_method=delete`

This is a fairly typical set of steps for page-based website navigation and use. An API would involve a slimmed-down version of these steps.

- We wouldn't need the original GET request.
- HTML forms only support two HTTP methods, _GET_ and _POST_. APIs are able to take advantage of all HTTP methods, which helps clarify the purpose of our requests.

When thinking about APIs and resources, we can define our intentions with two parts:

- _What_: Which resource is being acted upon?
- _How_: What is happening to that resource?

Nearly all interactions with a RESTful API can be defined this way. In the above case, the "what" is the user profile. The "how" is the action we're taking (editing, deleting, loading, etc).

#### CRUD

CRUD is an acronym for all the actions we can make on a resource: Create, Read, Update, and Delete. An API will function by matching one of these actions to the appropriate resource. Below is a table which is equivalent to the above table, only using REST API actions rather than HTML from-based actions.

Action | CRUD Operation | HTTP Method | Path
--- | --- | --- | ---
Create new profile | Create | POST | `/profiles`
Fetch profile | Read | GET | `/profiles/1`
Update profile with new values | Update | PUT | `/profiles/1`
Delete Profile | Delete | DELETE | `/profiles/1`

For this we do not need to load a form or anything, since a computer doesn't need to load a web page to interface with the server. This is handled by the documentation.

APIs have far fewer limitations than an HTML form, thus more fully embracing the concepts of HTTP. The development of APIs moves much faster than the world of HTML.

API interactions revolve around the resource in question and which action is being taken. Not all APIs follow this pattern exactly, but as a general rule, the mapping between CRUD actions and HTTP methods shown above doesn't change depending on the resource or API. POST requests will usually create resources, and so on. If you know which CRUD action you want to employ, you know which HTTP method to use.

Following REST conventions, API designers have to make fewer decisions to build their API, and API consumers have fewer questions to answer when using one.

#### A RESTful API Template

Objective | How || What ||
 | Operation | HTTP Method | Resource | Path
 Get information about $RESOURCE | Read | GET | $RESOURCE | `/$RESOURCEs/:id`
 Add a $RESOURCE to the system | Create | POST | $RESOURCEs Collection | `/$RESOURCEs`
 Make a change to a $RESOURCE | Update | PUT | $RESOURCE | `/$RESOURCEs/:id`
 Remove a $RESOURCE from the system | Delete | DELETE | $RESOURCE | `/$RESOURCEs/:id`

 Since the only actions that can be taken on a resource are create, read, update, and delete, the creative side of RESTful design lies in what resources are exposed to allow users to accomplish their goals. This is similar to designing a database schema, in that the same basic CRUD actions apply to rows in a database table.

#### Resource-Oriented Thinking

Think about making an order in an online shop. Using resourceful routes, what seems like a single action involves multiple requests to a server: creating an order, adding an item to an order, adding a second item, creating a shipping address, updating an order with shipping and billing addresses, adding a credit card to the system as payment, setting the order to use the credit card as a payment method, and submitting the order.

Most of the time, the cost of making multiple requests is offset by the simplicity of what each of the requests does.

Look at the last step. The book has it configured to be the creation of a `OrderPlacement` resource, which is nested under an `Order` resource. So we're sending a POST request to `/orders/:id/placement`. Notice how `placement` is in the singular, which indicates that it is a "singleton resource." We can suppose in this case that GETting a `placement` resource doesn't involve an `:id` placeholder. We simply send a GET request to `/orders/:id/placement`. Since there can only be one of this resource, we don't need to bother with multiple such resources.

#### Conventions, not Rules

Some solutions to application design require us to deviate from REST conventions. As such, few real world APIs strictly follow REST conventions.

## Working with an API

### Fetching Resources



## Building a Simple API Client

### Introduction

Modern web applications are directly connected by their use of each other's APIs. These APIs enable systems to use each other's functionality, allowing each system to specialize--lots of internal custom code can now be carried out by external systems.

APIs communicate over HTTP. If the "human" web is made up of web sites, the "computer" web is made up of web APIs, since they're interfaces intended for use by computers.

