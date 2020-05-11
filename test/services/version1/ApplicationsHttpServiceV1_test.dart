import 'dart:convert';
import 'package:test/test.dart';
import 'package:http/http.dart' as http;
import 'package:pip_services3_commons/pip_services3_commons.dart';
import 'package:pip_services_applications_dart/pip_services_applications_dart.dart';

final APPLICATION1 = ApplicationV1(
    id: '1',
    name: MultiString({'en': 'App1'}),
    product: 'Product 1',
    copyrights: 'PipDevs 2018',
    min_ver: 0,
    max_ver: 9999
);
final APPLICATION2 = ApplicationV1(
    id: '2',
    name: MultiString({'en': 'App1'}),
    product: 'Product 1',
    copyrights: 'PipDevs 2018',
    min_ver: 0,
    max_ver: 9999
);

var httpConfig = ConfigParams.fromTuples([
  'connection.protocol',
  'http',
  'connection.host',
  'localhost',
  'connection.port',
  3000
]);

void main() {
  group('ApplicationsHttpServiceV1', () {
    ApplicationsMemoryPersistence persistence;
    ApplicationsController controller;
    ApplicationsHttpServiceV1 service;
    http.Client rest;
    String url;

    setUp(() async {
      url = 'http://localhost:3000';
      rest = http.Client();

      persistence = ApplicationsMemoryPersistence();
      persistence.configure(ConfigParams());

      controller = ApplicationsController();
      controller.configure(ConfigParams());

      service = ApplicationsHttpServiceV1();
      service.configure(httpConfig);

      var references = References.fromTuples([
        Descriptor('pip-services-applications', 'persistence', 'memory', 'default', '1.0'),
        persistence,
        Descriptor('pip-services-applications', 'controller', 'default', 'default', '1.0'),
        controller,
        Descriptor('pip-services-applications', 'service', 'http', 'default', '1.0'),
        service
      ]);

      controller.setReferences(references);
      service.setReferences(references);

      await persistence.open(null);
      await service.open(null);
    });

    tearDown(() async {
      await service.close(null);
      await persistence.close(null);
    });

    test('CRUD Operations', () async {
      ApplicationV1 application1;

      // Create the first application
      var resp = await rest.post(url + '/v1/applications/create_application',
          headers: {'Content-Type': 'application/json'},
          body: json.encode({'application': APPLICATION1}));
      var application = ApplicationV1();
      application.fromJson(json.decode(resp.body));
      expect(application, isNotNull);
      expect(APPLICATION1.name.get('en'), application.name.get('en'));
      expect(APPLICATION1.product, application.product);
      expect(APPLICATION1.copyrights, application.copyrights);

      // Create the second application
      resp = await rest.post(url + '/v1/applications/create_application',
          headers: {'Content-Type': 'application/json'},
          body: json.encode({'application': APPLICATION2}));
      application = ApplicationV1();
      application.fromJson(json.decode(resp.body));
      expect(application, isNotNull);
      expect(APPLICATION2.name.get('en'), application.name.get('en'));
      expect(APPLICATION2.product, application.product);
      expect(APPLICATION2.copyrights, application.copyrights);

      // Get all applications
      resp = await rest.post(url + '/v1/applications/get_applications',
          headers: {'Content-Type': 'application/json'},
          body: json
              .encode({'filter': FilterParams(), 'paging': PagingParams()}));
      var page = DataPage<ApplicationV1>.fromJson(json.decode(resp.body), (item) {
        var application = ApplicationV1();
        application.fromJson(item);
        return application;
      });
      expect(page, isNotNull);
      expect(page.data.length, 2);

      application1 = page.data[0];

      // Update the application
      application1.name = MultiString({'en': 'Updated Name 1'});

      resp = await rest.post(url + '/v1/applications/update_application',
          headers: {'Content-Type': 'application/json'},
          body: json.encode({'application': application1}));
      application = ApplicationV1();
      application.fromJson(json.decode(resp.body));
      expect(application, isNotNull);
      expect(application1.id, application.id);
      expect('Updated Name 1', application.name.get('en'));

      // Delete the application
      resp = await rest.post(url + '/v1/applications/delete_application_by_id',
          headers: {'Content-Type': 'application/json'},
          body: json.encode({'application_id': application1.id}));
      application = ApplicationV1();
      application.fromJson(json.decode(resp.body));
      expect(application, isNotNull);
      expect(application1.id, application.id);

      // Try to get deleted application
      resp = await rest.post(url + '/v1/applications/get_application_by_id',
          headers: {'Content-Type': 'application/json'},
          body: json.encode({'application_id': application1.id}));
      expect(resp.body, isEmpty);
    });
  });
}
