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

We have a web store API set up from the following repo:

https://github.com/gotealeaf/web_store

This is a sinatra app that I've deployed to my own Heroku app at:

https://tranquil-dawn-24386.herokuapp.com/

All resources for this instance are namespaced under the `/v1` path.

#### Fetching a Resource

Let's get the first product from our app:

```http
$ http GET https://tranquil-dawn-24386.herokuapp.com/v1/products/1
HTTP/1.1 200 OK
Connection: keep-alive
Content-Length: 53
Content-Type: application/json
Date: Wed, 08 Feb 2017 19:13:49 GMT
Server: Cowboy
Status: 200 OK
Via: 1.1 vegur

{
    "id": 1,
    "name": "Red Pen",
    "price": 100,
    "sku": "redp100"
}
```

Let's take note of a few details:

- The _media type_ is `application/json`.
- The _status_ is `200 OK`.
- The _body_ is in `JSON` format.

The JSON body is a representation of a single __resource__ on the server, representing a single product. When deserialized into a programming environment, the response body will be a single object. This representation includes `id`, `name`, `price`, and `sku`. Note the datatypes for each property.

#### What is a Resource?

A __resource__ is the representation of some grouping of data. A resource can be anything an API user needs to interact with. Every resource must have a unique URL that can be used to identify and access it. In the previous example, the URL for the product we wanted information about was `https://tranquil-dawn-24386.herokuapp.com/v1/products/1`. This was the URL for a single resource on the server.

APIs can have multiple versions, so our API has namespaced our resource under `v1`. APIs can have multiple versions.

The path we used identified a single resource, but sometimes we can identify multiple resources as a group. See below.

#### Fetching a Collection

Our server comes preloaded with a few products: some pens, each with a unique ink color. To see all of these products, send a GET request to the collection's path.

```http
http GET https://tranquil-dawn-24386.herokuapp.com/v1/products
HTTP/1.1 200 OK
Connection: keep-alive
Content-Length: 166
Content-Type: application/json
Date: Wed, 08 Feb 2017 19:21:32 GMT
Server: Cowboy
Status: 200 OK
Via: 1.1 vegur

[
    {
        "id": 1,
        "name": "Red Pen",
        "price": 100,
        "sku": "redp100"
    },
    {
        "id": 2,
        "name": "Blue Pen",
        "price": 100,
        "sku": "blup100"
    },
    {
        "id": 3,
        "name": "Black Pen",
        "price": 100,
        "sku": "blap100"
    }
]
```

What we get back is largely the same as the previous example, but the JSON body represents a __collection__ resource. When we deserialize the data, we end up with an array of three objects.

#### Elements and Collections

So we have two kinds of resources we can manipulate with a REST API: elements and collections. Elements involve a single resource, while collections involve multiple resources. The paths for elements are commonly nested under the paths for elements.

```
/api/blog/posts

# vs...

/api/blog/posts/1
```

We add an extra value to the element path in order to identify the element we want to manipulate.

How do we know if a URL is for a collection or a resource? It's always best to reference the API documentation. If there isn't any, we can get some clues.

Collection:

- The path ends in a plural word
- The body contains multiple elements (an array in JSON)

Element

- The path includes an identifier, commonly nested under a plural word
- The body contains a single element (an object in JSON)

### Requests in Depth

#### GET and POST

All requests to a web server starts with an HTTP verb. This helps the server know which action to carry out. For a while, the only verbs used were GET and POST, despite that the HTTP spec includes many, many more. This is because browsers only needed to support the HTML-based web. Each time you visit a page, your browser performs a GET request. Every time you submit a form (such as a login form), your browser performs a POST.

#### Parts of a Request

Let's look at the structure of a request. HTTPie allows us to print out the contents of our request if we use the `--print H` flag.

```http
$ http --print H GET https://tranquil-dawn-24386.herokuapp.com/v1/products/1

GET /v1/products/1 HTTP/1.1
Accept: */*
Accept-Encoding: gzip, deflate
Connection: keep-alive
Host: tranquil-dawn-24386.herokuapp.com
User-Agent: HTTPie/0.9.8
```

So the first line of the request includes the verb, the path, and the protocol version.

POST and PUT requests also support bodies, which is formatted just like a response's body: following any headers. Since this was a GET request, we didn't include a body.

Another part of the request is very important:

```
Accept: */*
```

This tells the server which media types we will accept from the server. Our server currently returns a JSON media type by default, but it's best to get into the habit of crafting more explicit requests.

We want to tell the server to return JSON to us. We can do this with HTTPie by adding an additional argument: `accept:application/json`.

```http
$ http --print H GET https://tranquil-dawn-24386.herokuapp.com/v1/products/1 accept:application/json

GET /v1/products/1 HTTP/1.1
Accept-Encoding: gzip, deflate
Connection: keep-alive
Host: tranquil-dawn-24386.herokuapp.com
User-Agent: HTTPie/0.9.8
accept: application/json
```

The accept header now correctly includes a JSON datatype.

### Creating Resources

#### HTTP Request Side Effects

By definitions, a GET request shouldn't alter the state of the server. There can, however, be some side effects, the simplest of which might be a hit counter which increments each time a resource is loaded. While a GET request is generally "safe," it's always good to be aware of any side effects built into the system.

#### Creating a Resource

Let's say we want to post a new product to our store. We can do this with a single POST request.

```http
$ http -a admin:password POST https://tranquil-dawn-24386.herokuapp.com/v1/products name="Purple Pen" sku="purp100" price=100

HTTP/1.1 201 Created
Connection: keep-alive
Content-Length: 56
Content-Type: application/json
Date: Wed, 08 Feb 2017 19:43:43 GMT
Server: Cowboy
Status: 201 Created
Via: 1.1 vegur

{
    "id": 4,
    "name": "Purple Pen",
    "price": 100,
    "sku": "purp100"
}
```

The response is similar to what we saw when we were fetching a resource:

- The __media type__ is `application/json`.
- The __status__ is `201 Created`. This code is in _2xx_ format, so we know the action was successful. `201 Created` means the request successfully created a new resource.
- The __body__ is in JSON format. The format is the same, with the exception of the values, which reflect the values that we entered into the request.

We can also fetch all the products again to see that our new product was added to the collection.

```http
$ http GET https://tranquil-dawn-24386.herokuapp.com/v1/products
HTTP/1.1 200 OK
Connection: keep-alive
Content-Length: 223
Content-Type: application/json
Date: Wed, 08 Feb 2017 19:46:51 GMT
Server: Cowboy
Status: 200 OK
Via: 1.1 vegur

[
    {
        "id": 1,
        "name": "Red Pen",
        "price": 100,
        "sku": "redp100"
    },
    {
        "id": 2,
        "name": "Blue Pen",
        "price": 100,
        "sku": "blup100"
    },
    {
        "id": 3,
        "name": "Black Pen",
        "price": 100,
        "sku": "blap100"
    },
    {
        "id": 4,
        "name": "Purple Pen",
        "price": 100,
        "sku": "purp100"
    }
]
```

#### Handling Errors

HTTP requests aren't always successful. A failure can be due to authentication, a validation error, or even a network disruption. Error responses can vary from useful to very vague. Sometimes there will be no information beyond the status code. The best course of action would be to read the documentation to verify all the right things are in place.

Here are some of the most common errors and how to resolve them.

##### Missing or Invalid Parameters

Validations are typically put in place on the server side to enforce data integrity, espeically when an API allows for resource creation. The best place to go to see what the API needs re: request parameters. Our web store provides such documentation.

Let's try to create a product without sending any parameters.

```http
$ http -a admin:password POST https://tranquil-dawn-24386.herokuapp.com/v1/products
HTTP/1.1 422 Unprocessable Entity
Connection: keep-alive
Content-Length: 97
Content-Type: application/json
Date: Wed, 08 Feb 2017 19:54:59 GMT
Server: Cowboy
Status: 422 Unprocessable Entity
Via: 1.1 vegur

{
    "message": "Name is missing, sku is missing, sku is invalid, price is missing",
    "status_code": 422
}
```

This is different from the responses we typically get.

- The status is 422 Unprocessable Entity. Since it's in 4xx format, we know the request was unsuccessful. A 422 suggests that the request was invalid. This is often caused by a validation error.
- The body is in JSON format. Instead of a representation of the resource we are creating, it is an error message.

##### Missing Resources

Let's try to GET a resrouce that doesn't exist on the server.

```http
$ http GET https://tranquil-dawn-24386.herokuapp.com/v1/products/1000
HTTP/1.1 404 Not Found
Connection: keep-alive
Content-Length: 78
Content-Type: application/json
Date: Wed, 08 Feb 2017 20:00:25 GMT
Server: Cowboy
Status: 404 Not Found
Via: 1.1 vegur

{
    "message": "Couldn't find WebStore::Product with 'id'=1000",
    "status_code": 404
}
```

Notice the familiar `404` status. There are a few reasons we might be getting this error:

- The resource might not exist. Verify that any parameters exist, including the identifiers.
- The URL could be incorrect. Make sure you are sending a request with the correct path.
- The specific resource may require authentication. These kinds of errors should be resulting in a status code of `401` or `403`, but for security reasons it is sometimes better to expose the existence of a resource for those who are authorized to access it.

##### Authentication

Many systems require authentication for their APIs. These will result in a status of 400, 401, or 403, and can be resolved using the correct credentials.

##### Incorrect Media Type

Most newly-released APIs use JSON, so HTTPie automatically converts any parameters into JSON when sending a POST or PUT request. HTTPie doesn't print this stuff by default, but we can print the entire request by altering the params we pass to the `--print` flag. The value in question is `HBhb`, which will have it print both the headers and bodies for both the request and the reaponse.

If we send a request with the wrong media type (say, `application/x-www-form-urlencoded`, which we can let HTTPie send as using the `--form` flag), then we get a `415 Unsupported Media Type` response.

##### Rate Limiting

Since APIs are consumed by automated systems, we can easily conceive of an API having to receive many hundreds or thousands of requests in a few seconds. This could hinder the server's performance for other users, so some APIs enforce __rate limiting__. Each consumer is allotted a certain number of requests in a specified amount of time. Any requests beyond this limit are sent an error response and not processed further. The status code is often 403 Forbidden.

We can mitigate this by performing the request less often.

##### Server Errors

4xx errors are described as "client errors." They are a result of the consumer doing somethign that is incompatible with the server. Errors can also occur that are not a direct result of something the client is doing. These errors are the 5xx series, and have many potential causes, such as:

- A bug or oversight in the server implementation. This can sometimes result from correct or intended use of the API.
- A hardware or infrastructure problem with the remote system.
- Some APIs even return 5xx errors when a specific client error would be more accurate and useful.

As an API consumer, a 5xx error isn't all that useful. Sometimes the errors are intermittent, and so retrying the request may resolve the problem. If the server error continues, it is best to stop making requests until the remote system has been fixed. Continuing to make requests to a remote systems could cause damage.

### More HTTP Methods

#### Updating a Resource

Let's say that we need to increace the price for our purple pens, and maybe change its name.

Our purple pen has an ID of `4`. To change this resource, we need to send a PUT (rather than a POST or a GET) to its identifying path, which is `v1/products/4`.

Think of __PUT__ as telling the server to "put this resource in this place." This typically involves passing all of the resource's properties to the server. According to the HTTP spec, thus, PUT requests must take a complete representation of the resource being updated. If a parameter was required to create the resource, it is required to be sent with a PUT request. If it is left out of the request, it is assumed to have an empty value. Most APIs don't strictly follow this requirement, resulting in a PUT action that acts more like a PATCH action.

Our web store follows allong with that convention, so we don't need a full representation of the product to send a PUT request. Let's send a value of 150 for our pen's price.

```http
$ http -a admin:password PUT https://tranquil-dawn-24386.herokuapp.com/v1/products/4 price:150
HTTP/1.1 200 OK
Connection: keep-alive
Content-Length: 56
Content-Type: application/json
Date: Wed, 08 Feb 2017 20:25:21 GMT
Server: Cowboy
Status: 200 OK
Via: 1.1 vegur

{
    "id": 4,
    "name": "Purple Pen",
    "price": 100,
    "sku": "purp100"
}
```

What we get in return is a representation of the updated resource! We can change multiple values this way, too, by passing in multiple parameters.

#### Deleting a Resource

Let's delete our purple pen by sending a DELETE request to the identifier path for that resource.

```http
$ http -a admin:password DELETE https://tranquil-dawn-24386.herokuapp.com/v1/products/4
HTTP/1.1 204 No Content
Connection: keep-alive
Content-Length: 0
Date: Wed, 08 Feb 2017 20:28:00 GMT
Server: Cowboy
Status: 204 No Content
Via: 1.1 vegur
```

We get a `204 No Content` status in return. This means that the deletion was successful. This response is used when there isn't anything useful to return as a body. Since there is no longer a resource in the server, there is nothing to send back to the client.

We can verify that this worked (if we don't trust the response) by trying to fetch the product.

## Real World APIs

### The Twitter API

Twitter was one of the earliest popular services to provide an API for use by other applications.

#### Reading Documentation

We need to collect a few pieces of information when we first work with an API:

- What protocol, host, and path will provide access to the appropriate resource?
- What parameters do we need to provide?
- Is authentication required?

Looking at Twitter's API documentation, we can find out what is required for all of this. For instance, to get a tweet, the URL we need is `https://api.twitter.com/1.1/statuses/show.json`, with an `id` parameter. We also need this request to be authenticated.

Furthermore, Twitter also requires that all API access is done over HTTPS.

#### Gaining Access

Let's try fetching a tweet using Postman. Since the API requires authentication over the OAuth protocol, we're deciding to use Postman over HTTPie.

Let's get the first tweet to ever stored on Twitter, which has an ID of 20.

```
https://api.twitter.com/statuses/show.json?id=20
```

If we do this without authentication, we'll get a 4xx response. The JSON object includes a helpful message, as well as a code of 215. This isn't an HTTP status code, but rather an internal error code that we can look up in the docs.

Our next step would be to authenticate with Twitter. Twitter uses OAuth as of 2010. This made the API more secure, but it made it more difficult to interact with the API using a command line utility like cURL or HTTPie. These utilities support basic authentication, but OAuth is a separate protocol.

#### What is OAuth?

OAuth is a complicated system that provides a way for users to grant access to third party applications without revealing their credentials. From a user perspective, this involves clicking a button saying "Sign in with X Service." The user is redirected to the site of the service in question where they approve the service we are trying to connect. There are some interactions happening directly between the services' servers which are not revealed to the user. The result is an "access token" and an "access token secret" which, when combined with an "application token" and an "application secret" belonging to the requesting application, provide enough information to build a request.

The application key and application secret can be thought of as the application's username and password, and the access token and access secret are those for the individual user. All four values are needed to make requests.

OAuth provides a way for a user to authorize access to their accounts without giving out their credentials. This results in a fairly smooth experience for the user, but all the functionality, if implemented from scratch, can be a lot of work for the developer. There are libraries available for many programming languages that can make the process more manageable.

Twitter provides another way to create OAuth tokens for use in developing new applications, allowing us to skip most of these steps. This way provides access tokens and access secrets for development purposes. We'll use these to focus on the API rather than the particulars of OAuth.

#### Setting up the Twitter Application

We register a new app to twitter (attached to a Twitter account) here:

https://apps.twitter.com/

Then we want to make sure the app has read/write permissions.

Next we want to create an access token/secret for an individual user (which is us). This will allow our application to perform actions on behalf of us. To do this we go to the "Keys and Access Tokens" tab. Here we can see the token and secret for our app. These are the _application_ ("consumer") access token and secret. To create the ones for our user, we can create an _access_ token for our user at the bottom of the page. We need to user all four of these values for our API call.

Let's put these four values into Postman under its "authentication" section for our request. We also need to check "Add params to header" and "Auto add parameters."

To verify that this authentication works, Twitter's API gives us a resource that can be accessed that returns data for the user currently authenticated through the API.

```
https://api.twitter.com/1.1/account/verify_credentials.json
```

We'll send a GET to this path and if we receive a 2xx in return, our authentication is successful.

If we look at the request headers, we notice that OAuth uses the same `Authorization` header as basic http auth, but it has more values. Postman computed these values automatically based on our tokens and secrets. It's common to use a lib to do this for us when we are developign an application.

#### Fetching a Tweet

Using our authentication parameters, let's fetch a tweet, sending a GET to

```
https://api.twitter.com/1.1/statuses/show.json?id=20
```

The response contains a bunch of data about the tweet, including a JS object with information about the user, who is "jack." The text, we see, is "just setting up my twittr".

Here is a page with most of the relevant information about a tweet object returned by the response:

https://dev.twitter.com/overview/api/tweets

If we change the value of `id` to point to a tweet that doesn't exist, such as `19`, notice that we get a 404.

#### Posting a Tweet

To post a tweet, we need to send a POST request to `https://api.twitter.com/1.1/statuses/update.json`. `status` is a required parameter, which includes the text of the tweet.

So let's change that stuff in Postman. We need to remember to set the format to `x-www-form-urlencoded`, the option for which can be found under the "Body" tab under the request form field. We set the key for our one parameter to `status` and let's add a value, like `hello world`.

#### Twitter API and REST

The twitter API handles thousands of applications and a shitton of traffic. However, it doesn't very closely follow REST conventions. This is for a couple of reasons.

- It uses GET and POST instead of the full range of HTTP verbs. This makes the API less expressive.
- Resource paths, as a result, include only the actions being performed on them.

If Twitter were to mke their API more RESTful, this would require a new version in order to not disrupt existing applications.

This wouldn't really change the functionality of the API, though, while involving a lot of engineering work. When in doubt, check the docs!

Let's do some stuff:

##### Retweeting an Existing Tweet

```
POST https://api.twitter.com/1.1/statuses/retweet.json
```

We need to add an `id` paremter for the ID of the tweet we are retweeting.

##### Location Data

```
POST https://api.twitter.com/1.1/statuses/update.json
```

With paremeters `status`, `lat`, and `long`.

## Building a Simple API Client

### Introduction

Modern web applications are directly connected by their use of each other's APIs. These APIs enable systems to use each other's functionality, allowing each system to specialize--lots of internal custom code can now be carried out by external systems.

APIs communicate over HTTP. If the "human" web is made up of web sites, the "computer" web is made up of web APIs, since they're interfaces intended for use by computers.

### HTTP Calls Within a Simple Program

Consider the following program:

```ruby
require "json"
require "faraday"

url = "http://dev.markitondemand.com/MODApis/Api/v2/Quote/json"
symbol, quantity = ARGV

http_client = Faraday.new
response = http_client.get(url, symbol: symbol)
data = JSON.load(response.body)

price = data["LastPrice"]
total = price.to_f * quantity.to_i

puts total
```

There shouldn't be too much surprising stuff here. We have a URL for an API call, and take in two arguments. We use a Faraday object to make a GET request at that URL, with a `symbol` parameters. We then use the JSON library to convert the body of the response into a hash. We do some calculations on the response, and spit out the total stock worth.

### Wrap the Program in a Test

We're going to write a spec for this program so that we can expand upon it without the risk of regressions.

In its current state it is difficult to test thecode, since it takes inputs from STDIN, and prints to STDOUT. To solve this, we can wrap it in a method called `calculate_value`.

When our spec requires `stock_totaler.rb`, it executes all the code in that file. This will print out something in spite of the fact that we never passed in any arguments. To prevent this from happening, our `puts` call should be on the condition that `$0 == __FILE__`. `$0` is a global variable that is set by Ruby when the program runs. It contains the name of the current executing program. When we run this program using `ruby stock_totaler.rb TSLA 1`, `$0` will be set to `stock_totaler.rb`. When we run this program using `rspec spec/stock_totaler_spec.rb`, `$0` will be whatever path `rspec` is executing from (usually a `bin`). `__FILE__` is a constant that always contains the name of the file in which it appears. So `__FILE__` in our `stock_totaler.rb` file will be just that, and `__FILE__` in `stock_totaler_spec.rb` will be that (actually, the absolute path to that file, since we're executing it from `rspec`). This means that these values are only equal if we are executing the program from that path as that program.

### The Issues of Testing with External Service Dependencies

Since our test is communicating with a live API, ther are a few shortcomings that need to be addressed.

1. The test will fail if there is no network access.
2. The test (in its current state at this stage in the lesson) is dependent on the exact values returned by the API. If the stock price changes, which it certainly will over time, the test will fail even though the code works as intended.
3. The test runs slowly due to the external API call.
4. Repeated or rapid tests could negatively affect the API. We want to avoid hammering the API with a lot of calls, especially when we are running multiple tests that have to do with code that executes those API calls. Most services have usage limits for API calls and will reject sources that abuse it.

### Stubbing Out the Network

Let's address these concerns. First we'll add a gem called `webmock`. We'll require that gem in our spec and set a local variable with the body of what would be our response (in string format). In the `it` call itself, we define the URL as the API endpoint we want to hit in the program, then we call `stub_request` and pass it some data referring to the request.

```ruby
url = "http://dev.markitondemand.com/MODApis/Api/v2/Quote/json?symbol=TSLA"
stub_request(:get, url).to_return body: tesla_data
```

Note the query parameter in the URL string that we are passing into `stub_request`. The method needs to know the exact URL string we want it to intercept. This means GET requests must always include the query params.

The test no longer relies on the external service to be called. As the project grows, this technique dramatically speeds up the runtime of tests.

When webmock is loaded, all outgoing HTTP requests are disabled. So if we don't stub the request, an exception is raised.

Another thing to note is that webmock supports specifying headers in our outgoing requests.

### Problems with Manual HTTP Traffic Stubbing

Here are some potential problems to consider.

- __The way `tesla_data` is defined is fairly verbose.__

As our test suite grows, these files can get fairly unwieldy. Also, we sometimes get request bodies and response bodies that are enormous. These take up a lot of space in our spec file, while our specs might not be all that large. To alleviate this we can possibly put this data in other files, such as fixtures. This, however, wouldn't address the next problem.

- __There isn't a simple way to keep the value of `tesla_data` up-to-date.__

If the API changes, we don't know if our code will break, since we're not running against the real API.

- __We're only providing a stubbed value for a response body.__

While our current stub doesn't rely on special request headers, this might be the case for future API calls. This becomes difficult to maintina if we want to manually specify request and response headers and bodies.

### Deterministic Network Testing with VCR

The range of testing tools is rapidly expanding and maturing. One such testing tool is VCR, which we can use to clean up our API-dependent tests while keeping them up-to-date as APIs change.

With our next change to our spec, we removed the stuff related to `webmock`, including the call to `stub_request`. We added a call to `VCR.configure`, and added `:vcr` as an argument to our call to `it`.

The first time we run the test we might have a failing test if the price for TSLA has changed. We just need to revise our test to reflect the new price. VCR has recorded this API call, and all subsequent test runs will be stubbed from this recorded API call.

Looking at our `VCR.configure` block, note that we've specified a few things. First, we have the directory in which we are storing cassettes. Each HTTP interaction gets recorded by VCR and stored as a YAML file. Next, we specify that we're using `webmock` to manage the stubbing of our requests. Our call to `#configure_rspec_metadata!` sets up automatic VCR integration with Rspec, which lets us pass `:vcr` into our `#it` call. These make it so VCR only runs when we have this argument passed in.

So if we change the stock being fetched with our current config, we'll get an error. VCR recognizes that this request deviates from what VCR knows. This is because VCR will only record requests once per method per URI, since we have our `:record` flag set to `:once`. It is seeing a combination of `method` and `uri` that it doesn't recognize. It gives us a few options that we can use. For our purposes we're going to just change the spec back.

### Service Response with Errors

Say we want to run our code with invalid input. What should our program do in this case? Currently, it does run, giving us a value of 0.0. We have two decisions to make: how can we determine how a request has failed, and how can we respond to the failed request.

### Handle Connection Errors

Even when the application itself is running correctly, there's always the possibility of something happening between the client and the server that causes the request to fail. Fortunately, Faraday takes care of quite a few network errors, and raises an instance of `Faraday::Error::ConnectionError`.

Let's make sure the code handles the exceptions properly. We not only want to be aware of these errors on our own, but also to wrap these errors with our own error type so that any program using this program will need to depend on Faraday or know any specifics of how the program works.

It's best to hide the implementation of how the HTTP requests are made from any outside code as much as possible. If we define a clear interface we can ensure that we can change the HTTP library that our code uses at any point in the future without worrying about the change having any rippling effects throughout a larger codebase.

### Extracting an API Client

As it stood before this section, our `calculate_value` method did a whole lot of things. It performed calculations, it made requests to the API and parsed the results, and handled network errors.

This violates the __single responsibility principle__, which says that each object in a system should only do one thing. The following code starts to untangle these concerns.

```ruby
require "json"
require "faraday"

class SymbolNotFound < StandardError; end
class RequestFailed < StandardError; end

# MarkitClient provides access to the Markit On Demand API
class MarkitClient
  def initialize(http_client=Faraday.new)
    @http_client = http_client
  end

  # Get the most recent price for a stock symbol
  # Returns the price as a Float.
  # Raises RequestFailed if the request fails.
  # Raises SymbolNotFound if a price cannot be found for the provided symbol.
  def last_price(stock_symbol)
    url = "http://dev.markitondemand.com/MODApis/Api/v2/Quote/json"
    data = make_request(url, symbol: stock_symbol)
    price = data["LastPrice"]

    raise SymbolNotFound.new(data["Message"]) unless price

    price
  end

  private

  # Make an HTTP GET request using @http_client
  # Returns the parsed response body.
  def make_request(url, params={})
    response = @http_client.get(url, params)
    JSON.load(response.body)
  rescue Faraday::Error => e
    raise RequestFailed, e.message, e.backtrace
  end
end

def calculate_value(symbol, quantity)
  markit_client = MarkitClient.new
  price = markit_client.last_price(symbol)
  price * quantity.to_i
end

if $0 == __FILE__
  symbol, quantity = ARGV
  puts calculate_value(symbol, quantity)
end
```

Now we have a `MarkitClient` class, which handles initiating the API calls. We just create a new client and give it the symbol for which we want the price. It doesn't make any cool calculations or do anything super fancy. It passes the actual HTTP request concerns on to the `Faraday` library.

So we have three layers:

- Probram Code (`calculate_value`) - does somethign useful that is the purpose of the program.
- API Client (`MarkitClient`) - provides access to the data without hte user needing to know the specifics of how it is accessed.
- HTTP Client (`Faraday`) - handles making the requests and networking concerns.

When we write programs to work with web APIs, it is often helpful to reason about our code in these sorts of layers. This separates responsibilities and makes the code easier to understand.

## Logging, Error Handling, and Authentication

### Intro

Moving on from our MarkitOnDemand application, we're going to explore some concerns with using more involved APIs in production applications.

- Logging
- Error Handling
- Authentication
- Middlewares
- Caching
- Pagination
- Testing
- Non-idempotent Methods

"We will also cover the use of the Faraday Ruby library and how a stack of small components can provide sophisticated functionality for working with web APIs."

### Project Goals

We're going to use the GitHub API to build some reponts that analyze a uer's activity on the site. We'll create a command-line program that can display three reports: activity stats, user repository stats, and more

### Discovery and Implementation

"When working with web APIs, it doesn't always make sense to start right out of the gate writing failing tests, as one would with test-driven development. APIs can be complicated and a lot of times, you won't be ready to write tests right from the beginning. It often takes investigation before you understand what the code even needs to do! This investigation can take many forms: reading documentation, trying out code and libraries in interactive sessions, and even reading existing code to see how it works. Sometimes it makes sense to build a small prototype or spike implementation of a project to try out some ideas before commiting to an approach.

"When it is time to write production code, it is a good idea to go back and add tests or rewrite the code in a test-driven manner. This isn't as much work as it sounds, since much of the hard work of getting something to work will already be somewhat completed.

"We will be using this approach in this project. After exploring some new web API concepts and seeing how they affect the implementation in our Ruby project, we will take a step back and look at how the concepts affect testing."

### Logging While Working with APIs

Logging lets us know what our code has done. Logs work by adding information to the end of a file, with the information being details about how the software is operating in production systems. Logs are often the only way to discover the cause of a problem.

The Rails log logs every database query and template render that occur while responding to a request. This is thorough but it has some downsides:

- __It may be at the wrong granularity__

It can be difficult to trace the relationship between a complicated problem and a list of minute events that have been logged, especially if the problem is a result of the combination of many of these events.

- __It might not be logging the right thing__

An application will have some domain-specific data that is neccessary to understand how the code operates. Most of the time, this information is not going to be logged automatically and doing so will require some development time.

- __It is noisy__

Tryign to find the line of a large log that represents a specific event can be challenging, and in a busy application, the size of the logs can grow quickly.

It is common to address these problems by logging to specific parts of a codebase that are of interest. For this project we are mostly interested in what HTTP requests out code makes as a result of user interaction and decisions we've made about how the application works.

We'll also look at ways to control how much logging occurs in order to maximize their signal-to-noise ratio.

### Error Handling: An Overview

#### Bad Input

Whenever we're getting information from an external source, there is a chance that something about that information will be incompatible with the assumptions made by the application. Some input can be a valid format, but considered invalid for semantic reasons.

Sometimes this input can come from other systems (i.e. not just user input). Many input errors are caused by incompatibilities in how different systems represent data.

#### Invalid or Missing Credentials

Many API tokens have a limited lifetime and need to be refreshed. Since access via a token or OAuth or similar can be revoked, it's best not to assume credentials are valid in another system.

#### An API Request was Invalid

Validation errors are a common source of rejected requests. Make sure your input matches what is suggested by an API's documentation, and validate locally to match.

#### Network Issues

Network errors are often difficult to anticipate and are often out of your control to resolve.

Degrading connections are also a common source of issues, and are harder to detect since requests don't fail outright. Logging is important in these cases because they can detect and assist in diagnosing this type of problem.

#### Rate Limit Exceeded

Many web APIs have a limit on how many requests you can send them within a given time frame. If the rate is exceeded, an error will be returned.

#### Unexpected Responses

Sometimes a server will return a 500 or another response that the code isn't designed to handle. Since each response typically needs to be sepecifically handled in code, if a certain response wasn't taken into account when the program was written, it will be unable to process the response and proceed.

### General Approach to Handling API Related Errors

In general, it's best to handle errors in the same layer of the coe that they originate from. As an example, it would be ideal to catch exceptions related to low-level networking problems in the HTTP client and then deal with the problem or raise an appropriate error.

The HTTP client we're using actually does this. It catches a lot of exceptions raised by the underlying network code and then raises as single exception. This allows code that uses Faraday to only have to worry about a single type of exception and prevents the implementation details of how Faraday works from leaking out in higher layers of the code.

If an error occurs that is the result of user input, try to handle it in the part of the code that is already interacting with the user.

#### Can a resolution be automated?

Some errors can be automatically handled by an application. This is the ideal way to gracefully handle problems that may arise when working with an API. some developers will argue that problems that can be expected are really just part of normal operations, regardless of the technical definition, it is a good idea for an application to gracefully ahndle common errors that can occur.

Many times this will involve presenting users with a means to resolve the problem themselves. If a user's credentials are no longer valid, prompt them to grant new ones. If a request was rejected because it was invalid, present the user with an interface where they can make corrections.

There are also some errors that a program can attempt to resolve without a user even knowing. Some networking issues fall into this category and can be retired safely to work around intermittent connection problems.

#### See if the error can be detected early and handled accordingly.

Verifying the presence and format of data is a good way to tect problems before making any API reuqests.

#### If the request is idempotent and the failure was not a result of an invalid request, retry it.

Networking issues are often temporary, so a retry interval is a common practice. Be sure to limit retries, and incorporate a growing backoff interval.

#### If the request was rejected due to invalid data, present the data and a human-friendly message to the user

Some APIs will return an error message in response to invalid requests, but these aren't typically intended for end users. It's best to write our own error messages to present to our users. This will help us reframe the problem in a way that relates directly to a user's objectives. Include steps that a user can take to resolve the issue.

Conversely, if there is nothing a user can do to improve the situation, say so. The situation is indicative of a design problem with the system.

### If a request failed due to exceeding a rate limit, wait and retry it later.

IF you are encountering frequent rate limiting errors, there is probably an improvement that needs to be made to the system's design. Many apps that are very 'talkative' with APIs will need to use some form of local cache in order to deviver acceptable levels of performance and availability.

Consider the ramifications of this delay on your users. It may be necessary to notify them that some features are temporarily unavailable or that some datam ay not be updated immediately.

#### If all else failse, raise an exception.

Try to raise an exception that is as speicfic as possible. Production applications typically collect information about errors via logging or notification systems, and including relevant details in the exception will assist the investigating developer diagnose the problem and address it.

Think about how an exception is handled at the userlevel. Does something appear to just not happen to the user? Should they be notified that somethign went wrong? It is tempting to catch Ruby exceptions and use the value returned by calling `message` as a human_friendly error message to display to users. A lot of the time, though, the information contained in the exception isn't appropriate for exposure to users, and the dev will need to handle the problem in another way.

### Rate Limiting

Most web API providers limit the number of requests that can be made to its API by a single user. In many cases the limit will be higher for users with accounts than it would be for anonymous users, although most web APIs are moving toward requiring auth for all users. Paid plans often offer higher request limits.

A program that makes a lot of API requests should minimize the number of requests and also gracefully handle hitting a rate limit should it occur.

#### Minimizing requests

- Take advantage of resource params and API features.

If your are fetching data from a collection that uses pagination, use the largest page size that is supported. This will transmit the data using as few requests as possible.

Some APIs will provide a way to request that associated objects are embedded in a resource's representataion, obviating the need for add'l API calls

- Don't make repeat reqeusts

It is good to examine what API interactions your code is making and look for duplicate requests. This often happens when looping through resources and performing additional requests for each one. We will see ways to store the responses for API requests and re-use them in future sessions.

### Authentication: Intro

Many web APIs require users to authenticate with the provider during each request made to the service. This allows the proder to control who accesses the service and makes it easier to handle abusive users.

We want to pay attention to _who_ the user is when authenticating with an API. It won't always be the developer of the application, but and end user who has authorized third party access to the APi on their behalf.

We need to keep two things in mind: how to actually include the credentials in an HTTP request, and what values to send. Here are a few of the different options--keep in mind that they may be combined in a variety of ways.

#### Types of Credentials

##### Username and Password

This is how most users manually sign into a service. This occurs with web APIs, but it's fairly rare due to the following weaknesses:

- Allowing an application to access a web API on your behalf means giving that application your username and password. This requires that the application store those credentials.
- This means that all applications that access the account have the same credentials. There is no simple way to revoke access from a single application. If anything changes, all formerly authorized applications will no longer have access.

Some services improve on this by providing each user with a single _access token_ to be used for API access. This improves security somewhat by removing the need for a user to share their password with a third party, but we still can't granularly modify access control.

The solution is to supply each application with a unique set of credentials, which is where OAuth comes in.

##### OAuth

OQuth describes how applications can allow users to authorize third parties to access their content without having to expose their personal credentials. Most modern applications support 2.0, but there is an older version which is more complicated to use.

We'll talk more about OAuth in the final project.

##### Other Access Tokens

OAuth can be difficult to implement for some types of applications, some API providers support an alternate way for users to manually generate access tokens that can then be given to an application to grant it access. Google calls these toeksn _App passwords_, and GitHub refers to them as _personal access tokens_. These are commonly used when services implement two-step verification, without which there would be no way for a user to grant an application access without thm being physically present.

If such a token is lost, it would need to be regenerated.

### Authentication: Sending Credentials in an API Request

Every request that requires authentication must include its credentials, since HTTP is a stateless protocol. There are two main ways to include this: in the headers, as a URL parameter. Let's take a look at what each of these looks like.

#### Credentials in an HTTP Header

##### Basic Auth

Some sites use basic auth, which for the user comes in the form of a dialog box prompting for a username and a password.

With HTTPie, we can provide these credentials with the `-a` flag in the form of `-a username` or `-a username:password`. If we send the request and print the headers, we get something like this:

```
$ http -p H https://api.github.com -a username:password
GET / HTTP/1.1
Accept: */*
Accept-Encoding: gzip, deflate
Authorization: Basic dXNlcm5hbWU6cGFzc3dvcmQ=
Connection: keep-alive
Host: api.github.com
User-Agent: HTTPie/0.8.0
```

The value for the `Authorization` header is computed using a simple formula, the conversion for which is usually handled by nearly all HTTP client libs.

##### Other Auth Headers

HTTP basic auth isn't the only way to provide credentials in a request header. Some services allow a consumer to specify an access token or other identifier in a header, either in the `Authorization` header or, in some cases, an `X-ACCESS-TOKEN` or other such header. Here's an example of a request made to the GitHub API using OAuth:

```
$ http -p H https://api.github.com 'Authorization: token OAUTH_TOKEN'
GET / HTTP/1.1
Accept: */*
Accept-Encoding: gzip, deflate
Authorization:  token OAUTH_TOKEN
Connection: keep-alive
Host: api.github.com
```

The specific header may vary, but the purpose is the same.

#### Passing Credentials as a URL Parameter

In some cases we can use query params for our authentication. The values are essentially the same as they would be if we were to put them in the header:

```
https://api.github.com?access_token=ACCESS_TOKEN
```

### Authentication: Managing Credentials Safely

All credentials need to be securely stored for future use. This means we shouldn't use usernames and passwords to consume APIs where possible. Never persist usernames and passwords anywhere.

For this project we'll be using a personal access token from GitHub. We should store this token in the code where it is being used to make API requests, but doing so makes it far too easy to accidentally commit it to a public repo.

We should never give this a chance of happening in the first place. This means we should never include credentials in code files. Instead, store them somewhere that provides easy access but keeps the actual credentials persisted outside the project directory.

We can:

- Store them as environment variables, adding them to our shell config file (`.bashrc`, etc).

```
export SUPER_SECRET_AUTH_TOKEN=asecretvalue
```

We can access this from most any programming language by a program running under that shell. In Ruby, it's stored as a key in the `ENV` hash:

```ruby
ENV['SUPER_SECRET_AUTH_TOKEN'] #=> `asecretvalue`
```

This value will be accessible to any code running on your machine. If you need to keep several different credentials for different projects, you will need to give them unique names.

- The gem `dotenv` provides a similar setup, but it allows a project's credentials to be kept in a file within the project. It is a good way to keep credentials for development environments. __We must use the `.env` file to `.gitignore`_.

Environment variables are a common way to store secret values in production. It is how configuration is provided to applications deployed to Heroku or other hosting providers that suppport 12 factor apps.

## Client Side Architecture with Middlewares

### Patterns When Working with APIs

After adding our "repos" method to our client class, we're repeating a lot of code. In either case, we have to prepare for the request, headers, logging, error handling, and parsing the data. There are layers of concerns across the request/response cycle. Currently we're putting them all inline, and they're all noisy and distract from the method's core functionality.

We can extract some of the logic into methods, but that still requires that we invoke those methods in our methods. Alternatively, we can take advantage of the fact that these layers of concerns are always around the HTTP request and response. Instread of extracting them out, we can push this logic into Faraday itself to become Faraday middlewares.

### Faraday and the Middleware Paradigm

Faraday was originally created by Rick Olson, inspired by the middleware paradigm of Rack. Rather than responding to requests like Rack does, Faraday is used to perform requests.

Here's an example of Faraday put to use:

```ruby
require 'faraday'

conn = Faraday.new(url: 'http://sushi.com') do |c|
    c.use Faraday::Request::UrlEncoded  # encode request params as "www-form-urlencoded"
    c.use Faraday::Response::Logger     # log request & response to STDOUT
    c.use Faraday::Adapter::NetHttp     # perform requests with Net::HTTP
end

res = conn.get '/nigiri/sake.json'      # GET http://sushi.com/nigiri/sake.json
res.body

conn.post '/nigiri', name: 'Maguro'     # POST "name=maguro" to http://sushi.com/nigiri
```

This doesn't give us much over vanilla `Net::HTTP`. The beauty, though, is that we can change how calls to `#get` or `#post` or whatever by adding or swapping middlewares in our call to `.new`.

Faraday middleware is written similarly to Rack middleware. Middleware is usually classes that define the `call(env)` method:

```ruby
class MyMiddleware
  def initialize(app, options = {})
    @app = app
    @options = options
  end

  def call(env)
    # information about the request is in the `env` hash
    $stderr.puts env[:url]
    # continue processing
    @app.call(env)
  end
end

# how to use it in a stack:
builder.use MyMiddleware, some_option: "value"
```

The `env` hash is in a different format from the Rack. Otherwise, this paradigm is mostly identical to that of Rack.

We can easily create a stack that handles all our present needs. Here's a use-case for the GitHub API:

```ruby
require 'logger'
# This is an imaginary 3rd-party extension for some add'l middleware:
require 'faraday_middleware'

conn = Faraday.new('https://api.github.com/') do |c|
  c.use FaradayMiddleware::ParseJson, content_type: 'application/json'
  c.use Faraday::Response::Logger, Logger.new('faraday.log')
  c.use FaradayMiddleware::FollowRedirects, limit: 3
  c.use Faraday::Response::RaiseError # raise exceptions for 4xx & 5xx responses
  c.use Faraday::Adapter::NetHttp
end

con.headers[:user_agent] = 'MyLib v1.2'

res = conn.get '/repos/technoweenie/faraday'
res.body['issues_count'] #=> 8
```

The custom middlewares still need to be implemented, but they can reside in separate files away from where we actually consume the API.

We can also switch from `Net::HTTP` to another library, which will allow us to perform many requests in parallel. This requires little to no changes to our existing code.

The nicest part about Faraday is that if you're using an open source API wrapper library that uses Faraday, we can insert our own middleware in its stack to add features that were not originally present. One use-case is to add caching in order to avoid hitting their HTTP request limits.

`faraday_middleware` actually does exist on GitHub, and it provides classes to parse JSON, XML, sign OAuth requests, cache responses, and more.

### Faraday Middleware

Again, here's a skeleton for Faraday Middleware:

```ruby
class MiddlewareSkeleton < Faraday::Middleware
  def initialize(app, options={})
    super(app)
    # Do any other setup
  end

  def call(env)
    # Do something with the request
    response = @app.call(env) # Process the request
    response.on_complete do
      # Do something with the response
    end
    response
  end
end
```

From the lesson:

"Faraday middlewares operate as a stack. Each one is instantiated by Faraday, and passed a reference to the next part of the stack, which is stored as `@app` in the call to `super` in `#initialize`. When a request is being processed, the first middleware's `call` method is called with the `env`, which is Faraday's abstraction of the entire request and response. A middleware can do whatever it needs to do and then pass control on to the next layer of the stack with `@app.call(env)`. An instance of `Faraday::Response` is returned back up the stack in reverse order and then returned by this method, which provides an opportunity to do work after the request has been processed downstream. It is best to perform this work by specifying an `on_complete` callback on the response in order to be compatible with streaming responses."

## Client Side Caching

### Intro to Caching

The concept of caching is pretty simple: store the results of doing something so it doesn't have to be done again. This can be anything, but it is most often something that is costly in terms of computation, transfer, or time. HTTP requests made across the internet are much slower than calls made to application components that are 'closer', such as databases or files on the filesystem. Handling these requests has a cost for the API provider as well, so it's best to minimize the number of API requests made, for the sake of both parties.

A browser's cache is a great example of a system that avoids costly transfers where possible. Using HTTP headers, websites can enable browsers to reuse most data between multiple pages. It also prevents the need to wait for these files to be sent over the network, which speeds up page rendering. Google recommends that a server's response times should be under 200ms.

Here are the different levels of caching:

- __HTTP response caching__: Most web browsers do this by default. The responses to every HTTP request made by the browser are stored in a cache and used whenever a duplicate request is made. The specific rules that govern what is cached and for how long are specified by HTTP headers. We'll cover some of these headers later on.

- __Domain object caching__: This is when an object in a system contains some data from an external source--this object is determined to be stale or not without maintaining a separate cache. For example, a price comparison site might collect data from many ecommerce sites and store all information for a product on a single table. This site would probably store the date and time that the data was collected.

- Between those types there is another caching strategy, where a parsed or otherwise processed representation of the response's value is cached, but it isn't a fully fledged domain object. "We might add this kind of cache to the stock calculation project we built earlier in this course. We only need to keep track of the price for a stock and when this value was last updated. As a result, we might store only these values in a cache instead of persisting the entire HTTP response (and if we used a cache that could auto-expire keys, we would only need to store the price)."

Caching HTTP responses is the most universal and re-usable form, but it also has the least opportunity to be optimized for efficiency as it knows nothing about how data from responses is being used. As caching systems become smarter and more aware of other parts of an application, they also become more coupled to those specific components and the system as a whole becomes more difficult to change. As a result, it ususally makes sense to start with caching raw HTTP responses, which is what we will be doing in this lesson.

### HTTP Caching

When an HTTP server sends over a response, it also gives us a bunch of headers. The `Cache-Control` header asks the browser to cache the response for up to `n` seconds, and the `ETag` header provides a "validation" token that can be used after the response has expired to check if the resource   has been modified.

Let's say we send a GET request at `/file` and receive the following headers:

```
200 OK
Content-Length: 1024
Cache-Control: max-age=120
ETag: "x234dff"
...
```

#### Validating Cached Responses with ETags

The server uses `ETag` to communicate a validation token. This enables efficient resource update checks--no data is transferred if the resource has not changed.

After our initial fetch's `Cache-Control` has expired, let's say the browser initiates a request for the same resource. The browser will first check the local cache, but finds it can't use it because the response has expired. The browser could send a new request, but this isn't efficient if the resource has changed--in such a case we wouldn't need to download the data again since it's already in cache.

Instead, we have a validation token (`ETag`) to help get around this. It usually comes in the form of a hash or some other fingerprint of the file's contents. The client sends it to the server on the next request in the form of one of the headers:

```
GET /file
If-None-Match: x234dff
```

The server then determines if the resource has changed by matching the `ETag` up with the file requested. If the tag matches, it sends back a `304 Not Modified` response:

```
304 Not Modified
Cache-Control: max-age=120
ETag: x234dff
```

The client now knows it doesn't have to redownload the resource.

As a web developer, we don't need to know the nitty-gritty of how the client chooses to cache its data. We just need to make sure we are providing the necessary ETag tokens.

#### `Cache-Control`

Each resource defines its own caching policy using the `Cache-Control` header. This tells the client who can cache the data, under what conditions, and for how long.

The fastest request is one that doesn't have to go out to the server. A cached response will let us eliminate all network latency and avoid data charges for data transfer. To achieve this, the server is allowed to provide a few `Cache-Control` directives.

##### `no-cache` and `no-store`

`no-cache` indicates that the returned response can't be used to satisfy a subsequent request to the same URL without first checking with the server to see if the response has changed. In this case, we can still store the data if an `ETag` is provided, but we'd still need at least one roundtrip to check if the resource has changed.

`no-store` disallows the client from storing any version of the returned response. This is useful if the response contains private banking data, for example. A full response must be downloaded with each request.

##### `public` vs. `private`

If the response is marked as `public`, then it can be cached, even if there is HTTP authentication associated with it, and even if the response status code isn't normally cacheable. This typically isn't required, since directives like `max-age` imply that the response is cacheable.

When a response is marked `private`, the response can be cached, but it is typically meant for a single user. Therefore, intermediate caches are not allowed to cache them. A browser can cache private pages, but (for example) a CDN cannot.

##### `max-age`

This is the amount of time that the response can be cached for, in seconds.

##### Optimal cache policy

https://developers.google.com/web/fundamentals/performance/optimizing-content-efficiency/images/http-cache-decision-tree.png

You should aim to cache as many resources as possible on the client for the longest possible period. Furthermore, validation tokens should be provided to enable efficient revalidation.

Among the top 300,000 sites, the browser can cache nearly half of all of their resources. Some sites cache more than 90% of their resources. It's always a good idea to make sure you've identified all cacheable resources and ensure they return appropriate `Cache-Control` and `ETag` headers.

#### Invalidating and Updating Cached Resources

### Conditional Requests

Caches are typically built with the assumption that the data they're storing is reasonably up-to-date.

A cache is said to be "invalid" or "stale" when it no longer holds data that is known to be recent enough for use. Typically this is determined based on how long the data has been in the cache. Some web APIs provide information to consumers about how long content should be cached for in the HTTP headers of their responses.

Here's an example from the GitHub API:

```
$ http https://api.github.com/repos/basecamp/local_time/commits/a4702051
HTTP/1.1 200 OK
Access-Control-Allow-Credentials: true
Access-Control-Allow-Origin: *
Access-Control-Expose-Headers: ETag, Link, X-GitHub-OTP, ...
Cache-Control: private, max-age=60, s-maxage=60
Content-Encoding: gzip
Content-Security-Policy: default-src 'none'
Content-Type: application/json; charset=utf-8
Date: Fri, 06 Feb 2015 18:01:04 GMT
ETag: W/"c9ba8bc677c4676b192651e1f9407cb2"
Last-Modified: Tue, 03 Feb 2015 14:15:08 GMT
Server: GitHub.com
Status: 200 OK
Strict-Transport-Security: max-age=31536000; includeSubdomains; preload
Transfer-Encoding: chunked
Vary: Accept, Authorization, Cookie, X-GitHub-OTP
Vary: Accept-Encoding
...
```

__Cache-Control__ says who can cache the content and for how long. `private` means that responses should only be cached by the end client, and not by intermediate proxies. `max-age` specifies in seconds how long the cached content can be used before it needs to be refetched.

Per the above example, our information can be cached for up to 60 seconds, and only by the client who requested it.

`ETag` and `Last-Modified` identify the specific version of the resource contained in this response. This becomes useful when a value from the cache is older than its max-age and needs to be refetched. We can provide one of these values to the server when fetching a resource again, and the server will be able to respond with a special response if the resource hasn't changed since it was last fetched.

__ETag__ headers are usually the computed hash for the returned content, althoguh API consumers must treat them as opaque tokens. That is, they are identifiers that have a meaning to the remote system, and their internal structure should not be relied on.

__Last-Modified__ headers are the date the resource was last modified.

Let's make a few requests from the GitHub API.

```
$ http https://api.github.com/repos/basecamp/local_time/commits/a4702051
HTTP/1.1 200 OK
Access-Control-Allow-Credentials: true
Access-Control-Allow-Origin: *
Access-Control-Expose-Headers: ETag, Link, X-GitHub-OTP, ...
Cache-Control: private, max-age=60, s-maxage=60
Content-Encoding: gzip
Content-Security-Policy: default-src 'none'
Content-Type: application/json; charset=utf-8
Date: Sat, 07 Feb 2015 02:29:47 GMT
ETag: W/"c9ba8bc677c4676b192651e1f9407cb2"
Last-Modified: Tue, 03 Feb 2015 14:15:08 GMT
Server: GitHub.com
Status: 200 OK
...

{
    "author": {
        "avatar_url": "https://avatars.githubusercontent.com/u/5355?v=3",
        "events_url": "https://api.github.com/users/javan/events{/privacy}",
        "followers_url": "https://api.github.com/users/javan/followers",
        ...
    }
}
```

The request received a complete response body. If we take the value we provided in the `ETag` header and pass it back to the server in the `If-None-Match` header when requesting the same resource, the server will only send the full response if it has been changed.

```
$ http https://api.github.com/repos/basecamp/local_time/commits/a4702051 If-None-Match:'"c9ba8bc677c4676b192651e1f9407cb2"'
HTTP/1.1 304 Not Modified
Access-Control-Allow-Credentials: true
Access-Control-Allow-Origin: *
Access-Control-Expose-Headers: ETag, Link, X-GitHub-OTP, ...
Cache-Control: private, max-age=60, s-maxage=60
Content-Security-Policy: default-src 'none'
Date: Fri, 06 Feb 2015 21:40:39 GMT
ETag: "c9ba8bc677c4676b192651e1f9407cb2"
Last-Modified: Tue, 03 Feb 2015 14:15:08 GMT
Server: GitHub.com
Status: 304 Not Modified
Strict-Transport-Security: max-age=31536000; includeSubdomains; preload
Vary: Accept-Encoding
...
```

The server returns a `304` and an empty response body because the resource hasn't changed since we last requested it.

We can also use the `Last-Modified` header for this same purpose, using the `If-Modified-Since` header:

```
$ http https://api.github.com/repos/basecamp/local_time/commits/a4702051 If-Modified-Since:'Tue, 03 Feb 2015 14:15:08 GMT'
HTTP/1.1 304 Not Modified
Access-Control-Allow-Credentials: true
Access-Control-Allow-Origin: *
Access-Control-Expose-Headers: ETag, Link, X-GitHub-OTP, ...
Cache-Control: private, max-age=60, s-maxage=60
Content-Security-Policy: default-src 'none'
Date: Fri, 06 Feb 2015 21:40:25 GMT
Last-Modified: Tue, 03 Feb 2015 14:15:08 GMT
Server: GitHub.com
Status: 304 Not Modified
Strict-Transport-Security: max-age=31536000; includeSubdomains; preload
Vary: Accept-Encoding
...
```

### Problems with In-Process Caching

If we run our `reports` script, we might notice that the caching middleware doesn't really improve the performance of our application. This is because our command line program creates a new instance of our client, and its own stack of Faraday middlewares. They do not share the same in-memory storage.

We can prove that our cache works by calling `user_info` on our client twice in one run of our program. This first creates a problem with our JSON parsing middleware, which converts our response into a hash from a string-like object. In our second time around, because the JSON parsing middleware is closer to the application than our caching middleware (which is closer to the network), the JSON parser is already receiving a cached version of the response, which was already a hash. We can't use `JSON.parse` on a hash.

This is a tricky bug, and the solution would be to save a clone of our response to memory, rather than the response itself.

We need to make a deep clone--the way to do that in Ruby is to load a Marshal dump:

```ruby
Marshal.load Marshal.dump(response)
```

We can push this into our `Storage::Memory` instance. There are a few advantages of serializing it this way, too. Now we only need to save and retrieve strings to our storage, which will allow us to use Redis and similar libs. Almost all tools understand strings.

Now that we have our caching mechanism abstracted away, we can now have our cache storage on an entirely separate process on our machine, or on another machine altogether.

For our assignment we are using `Memcached` as our caching solution.
