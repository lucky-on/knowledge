[Link to the course on LinkedIn Learning](https://www.linkedin.com/learning/microservices-design-patterns)

# Service types
- Data Service

  Connects to data source, any valid source of data
  Product service, Inventory service etc.

- Business service

  Higher level that is built on top of Data serves, can be around a single Data domain if complex enough, for example Order domain that needs Order, Customer, Inventory domains

- Translation service

  Any abstraction on 3rd party operation, so you can change interaction with 3rd party you do not have to change APIs to internal Business or Data services

- Edge service

  Responsible for service data to users and external services.
  Often used to slim down payloads to make them Mobile friendly.
  Can be a powerful layer of the Platform.

- Ancillary service

  Services that you do not write, but that you run in the run time of the Platform. Message queue services, cache services, AA services, etc

- Operational components

  Log and metrics aggregators and shippers, metrics

- Diagnostic components

  From simple shell script that you execute from your local machine to containers running on your run time to diagnose, troubleshoot and improve system performance

# Micro-services and Cloud native

- Cloud native is an architectural style.
- Designed to facilitate operating in the cloud
- Designed to be portable and scalable
- MS is focused on data, business, or function domain
- 
