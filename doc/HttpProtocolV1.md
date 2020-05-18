# HTTP Protocol (version 1) <br> Applications Microservice

Applications microservice implements a HTTP compatible API, that can be accessed on configured port.
All input and output data is serialized in JSON format. Errors are returned in [standard format]().

* [ApplicationV1 class](#class1)
* [DataPage<ApplicationV1> class](#class2)
* [POST /applications/get_applications](#operation1)
* [POST /applications/get_application_by_id](#operation2)
* [POST /applications/create_application](#operation3)
* [POST /applications/update_application](#operation4)
* [POST /applications/delete_application_id](#operation5)

## Data types

### <a name="class1"></a> ApplicationV1 class

Represents an application

**Properties:**
- id: string - unique application id
- name: string - application name
- description: string - application description
- product: string - product name
- copyrights: string - copyrights
- min_ver: number - minimum version
- max_ver: number - maximum version

### <a name="class2"></a> DataPage<ApplicationV1> class

Represents a paged result with subset of requested applications

**Properties:**
- data: [Application] - array of retrieved Application page
- count: int - total number of objects in retrieved resultset

## Operations

### <a name="operation1"></a> Method: 'POST', route '/applications/get_applications'

Retrieves a collection of applications according to specified criteria

**Request body:** 
- correlation_id: string - (optional) unique id that identifies distributed transaction
- filter: Object
  - tags: string - (optional) a comma-separated list of tags with topic names
  - status: string - (optional) application editing status
  - author: string - (optional) author name in any language 
- paging: Object
  - skip: int - (optional) start of page (default: 0). Operation returns paged result
  - take: int - (optional) page length (max: 100). Operation returns paged result

**Response body:**
Array of Application objects, DataPage<ApplicationV1> object is paging was requested or error

### <a name="operation2"></a> Method: 'POST', route '/applications/get_application_by_id'

Retrieves a single application specified by its unique id

**Request body:** 
- correlation_id: string - (optional) unique id that identifies distributed transaction
- application_id: string - unique application id

**Response body:**
Application object, null if object wasn't found or error 

### <a name="operation3"></a> Method: 'POST', route '/applications/create_application'

Creates a new application

**Request body:**
- correlation_id: string - (optional) unique id that identifies distributed transaction
- application: ApplicationV1 - Application object to be created. If object id is not defined it is assigned automatically.

**Response body:**
Created Application object or error

### <a name="operation4"></a> Method: 'POST', route '/applications/update_application'

Updates application specified by its unique id

**Request body:** 
- correlation_id: string - (optional) unique id that identifies distributed transaction
- application: ApplicationV1 - Application object with new values. Partial updates are supported

**Response body:**
Updated Application object or error 
 
### <a name="operation5"></a> Method: 'POST', route '/applications/delete_application_by_id'

Deletes application specified by its unique id

**Request body:** 
- correlation_id: string - (optional) unique id that identifies distributed transaction
- application_id: string - unique application id

**Response body:**
Occured error or null for success
 
