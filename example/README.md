# Examples for Applications Microservice

This is applications microservice from Pip.Services library. 
It keeps a list of supported applications that are referenced from other content microservices.

Define configuration parameters that match the configuration of the microservice's external API
```dart
// Service/Client configuration
var httpConfig = ConfigParams.fromTuples(
	"connection.protocol", "http",
	"connection.host", "localhost",
	"connection.port", 8080
);
```

Instantiate the service
```dart
persistence = ApplicationsMemoryPersistence();
persistence.configure(ConfigParams());

controller = ApplicationsController();
controller.configure(ConfigParams());

service = ApplicationsHttpServiceV1();
service.configure(httpConfig);

var references = References.fromTuples([
    Descriptor('pip-services-applications', 'persistence', 'memory',
        'default', '1.0'),
    persistence,
    Descriptor('pip-services-applications', 'controller', 'default',
        'default', '1.0'),
    controller,
    Descriptor(
        'pip-services-applications', 'service', 'http', 'default', '1.0'),
    service
]);

controller.setReferences(references);
service.setReferences(references);

await persistence.open(null);
await service.open(null);
```

Instantiate the client and open connection to the microservice
```dart
// Create the client instance
var client = ApplicationsHttpClientV1(config);

// Configure the client
client.configure(httpConfig);

// Connect to the microservice
try{
  await client.open(null)
}catch() {
  // Error handling...
}       
// Work with the microservice
// ...
```

Now the client is ready to perform operations
```dart
// Create a new application
final APPLICATION = ApplicationV1.fromMap({
    id: 'my_app',
    name: 'My Application',
    product: 'My Samples'
});

    // Create the application
    try {
      var application = await client.createApplication('123', APPLICATION);
      // Do something with the returned application...
    } catch(err) {
      // Error handling...     
    }
```

```dart
// Get the list of applications for 'My Samples' product
try {
var page = await client.getApplications(
    null,
    {
        product: 'My Samples'
    },
    {
        total: true,
        skip: 0,
        take: 10
    });
    // Do something with page...

    } catch(err) { // Error handling}
``` 

In the help for each class there is a general example of its use. Also one of the quality sources
are the source code for the [**tests**](https://github.com/pip-services-content/pip-services-applications-dart/tree/master/test).
