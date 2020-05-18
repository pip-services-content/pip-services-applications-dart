import 'package:pip_services3_commons/pip_services3_commons.dart';

import '../../src/data/version1/ApplicationV1Schema.dart';
import '../../src/logic/IApplicationsController.dart';
import '../../src/data/version1/ApplicationV1.dart';

class ApplicationsCommandSet extends CommandSet {
  IApplicationsController _controller;

  ApplicationsCommandSet(IApplicationsController controller) : super() {
    _controller = controller;

    addCommand(_makeGetApplicationsCommand());
    addCommand(_makeGetApplicationByIdCommand());
    addCommand(_makeCreateApplicationCommand());
    addCommand(_makeUpdateApplicationCommand());
    addCommand(_makeDeleteApplicationByIdCommand());
  }

  ICommand _makeGetApplicationsCommand() {
    return Command(
        'get_applications',
        ObjectSchema(true)
            .withOptionalProperty('filter', FilterParamsSchema())
            .withOptionalProperty('paging', PagingParamsSchema()),
        (String correlationId, Parameters args) {
      var filter = FilterParams.fromValue(args.get('filter'));
      var paging = PagingParams.fromValue(args.get('paging'));
      return _controller.getApplications(correlationId, filter, paging);
    });
  }

  ICommand _makeGetApplicationByIdCommand() {
    return Command(
        'get_application_by_id',
        ObjectSchema(true)
            .withRequiredProperty('application_id', TypeCode.String),
        (String correlationId, Parameters args) {
      var applicationId = args.getAsString('application_id');
      return _controller.getApplicationById(correlationId, applicationId);
    });
  }

  ICommand _makeCreateApplicationCommand() {
    return Command(
        'create_application',
        ObjectSchema(true)
            .withRequiredProperty('application', ApplicationV1Schema()),
        (String correlationId, Parameters args) {
      var application = ApplicationV1();
      application.fromJson(args.get('application'));
      return _controller.createApplication(correlationId, application);
    });
  }

  ICommand _makeUpdateApplicationCommand() {
    return Command(
        'update_application',
        ObjectSchema(true)
            .withRequiredProperty('application', ApplicationV1Schema()),
        (String correlationId, Parameters args) {
      var application = ApplicationV1();
      application.fromJson(args.get('application'));
      return _controller.updateApplication(correlationId, application);
    });
  }

  ICommand _makeDeleteApplicationByIdCommand() {
    return Command(
        'delete_application_by_id',
        ObjectSchema(true)
            .withRequiredProperty('application_id', TypeCode.String),
        (String correlationId, Parameters args) {
      var applicationId = args.getAsString('application_id');
      return _controller.deleteApplicationById(correlationId, applicationId);
    });
  }
}
