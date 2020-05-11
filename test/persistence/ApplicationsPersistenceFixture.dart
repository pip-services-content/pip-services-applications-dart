import 'package:test/test.dart';
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
final APPLICATION3 = ApplicationV1(
    id: '3',
    name: MultiString({'en': 'App1'}),
    product: 'Product 2',
    copyrights: 'PipDevs 2008',
    min_ver: 0,
    max_ver: 9999
);

class ApplicationsPersistenceFixture {
  IApplicationsPersistence _persistence;

  ApplicationsPersistenceFixture(IApplicationsPersistence persistence) {
    expect(persistence, isNotNull);
    _persistence = persistence;
  }

  void _testCreateApplications() async {
    // Create the first application
    var application = await _persistence.create(null, APPLICATION1);

    expect(application, isNotNull);
    expect(APPLICATION1.name.get('en'), application.name.get('en'));
    expect(APPLICATION1.product, application.product);
    expect(APPLICATION1.copyrights, application.copyrights);

    // Create the second application
    application = await _persistence.create(null, APPLICATION2);
    expect(application, isNotNull);
    expect(APPLICATION2.name.get('en'), application.name.get('en'));
    expect(APPLICATION2.product, application.product);
    expect(APPLICATION2.copyrights, application.copyrights);

    // Create the third application
    application = await _persistence.create(null, APPLICATION3);
    expect(application, isNotNull);
    expect(APPLICATION3.name.get('en'), application.name.get('en'));
    expect(APPLICATION3.product, application.product);
    expect(APPLICATION3.copyrights, application.copyrights);
  }

void testCrudOperations() async {
    ApplicationV1 application1;

    // Create items
    await _testCreateApplications();

    // Get all applications
    var page = await _persistence.getPageByFilter(
        null, FilterParams(), PagingParams());
    expect(page, isNotNull);
    expect(page.data.length, 3);

    application1 = page.data[0];

    // Update the application
    application1.name = MultiString({'en': 'Updated Name 1'});

    var application = await _persistence.update(null, application1);
    expect(application, isNotNull);
    expect(application1.id, application.id);
    // expect('Updated Name 1', application.name.get('en'));

    // Delete the application
    application = await _persistence.deleteById(null, application1.id);
    expect(application, isNotNull);
    expect(application1.id, application.id);

    // Try to get deleted application
    application = await _persistence.getOneById(null, application1.id);
    expect(application, isNull);
  }

  void testGetWithFilters() async {
    // Create items
    await _testCreateApplications();

    // Filter by product
    var page = await _persistence.getPageByFilter(
        null, FilterParams.fromValue({'product': 'Product 1'}), PagingParams());
    expect(page.data.length, 2);

    // Filter by search
    // NEED TO FIX
    // page = await _persistence.getPageByFilter(
    //     null, FilterParams.fromValue({'search': 'Product 1'}), PagingParams());
    // expect(page.data.length, 2);
  }    

}