import 'package:test/test.dart';
import 'package:pip_services3_commons/pip_services3_commons.dart';

import 'package:pip_services_applications/pip_services_applications.dart';
import './ApplicationsPersistenceFixture.dart';

void main() {
  group('ApplicationsFilePersistence', () {
    ApplicationsFilePersistence persistence;
    ApplicationsPersistenceFixture fixture;

    setUp(() async {
      persistence = ApplicationsFilePersistence('data/applications.test.json');
      persistence.configure(ConfigParams());

      fixture = ApplicationsPersistenceFixture(persistence);

      await persistence.open(null);
      await persistence.clear(null);
    });

    tearDown(() async {
      await persistence.close(null);
    });

    test('CRUD Operations', () async {
      await fixture.testCrudOperations();
    });

    test('Get with Filters', () async {
      await fixture.testGetWithFilters();
    });
  });
}
