import 'package:logger/logger.dart';

class LogPrint {
  final Logger _logger;

  LogPrint() : _logger = Logger();

  void info({required String infoMsg}) {
    _logger.i(infoMsg);
  }

  void warning({
    required dynamic error,
    required String warningMsg,
    required StackTrace stackTrace,
  }) {
    _logger.w('$warningMsg \n $error \n $stackTrace');
  }

  void error({
    required dynamic error,
    required String errorMsg,
    required StackTrace stackTrace,
  }) {
    _logger.e('$errorMsg \n $error \n $stackTrace');
  }
}
