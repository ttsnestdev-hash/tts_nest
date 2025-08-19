import 'package:get/get.dart';

class AddTaskController extends GetxController {
  var isPublic = false.obs;
  var isBillable = false.obs;

  var subject = "".obs;
  var hourlyRate = 0.0.obs;
  var startDate = "".obs;
  var dueDate = "".obs;

  var priorityList = ["Low", "Medium", "High"].obs;
  var relatedList = ["Project", "Invoice", "Customer"].obs;
  var assignedList = ["a", "b", "c"].obs;
  var followUpList = ["a", "b", "c"].obs;
  var selectedPriority = "Low".obs;
  var selectedRelated = "Project".obs;
  var selectedAssigned = "a".obs;
  var selectedFollowUp = "a".obs;

}
