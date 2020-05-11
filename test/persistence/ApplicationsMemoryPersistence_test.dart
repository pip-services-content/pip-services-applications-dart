import 'package:test/test.dart';
import 'package:pip_services3_commons/pip_services3_commons.dart';

import 'package:pip_services_applications_dart/pip_services_applications_dart.dart';
import './ApplicationsPersistenceFixture.dart';

void main() {
  group('ApplicationsMemoryPersistence', () {
    ApplicationsMemoryPersistence persistence;
    ApplicationsPersistenceFixture fixture;

    setUp(() async {
      persistence = ApplicationsMemoryPersistence();
      persistence.configure(ConfigParams());

      fixture = ApplicationsPersistenceFixture(persistence);

      await persistence.open(null);
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
