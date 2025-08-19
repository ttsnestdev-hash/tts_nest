import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';

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


  var attachedFiles = <PlatformFile>[].obs;

  Future<void> pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.any, // 🔹 allow all file types
    );

    if (result != null) {
      attachedFiles.addAll(result.files);
    }
  }

  void removeFile(int index) {
    attachedFiles.removeAt(index);
  }
}
