import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:job_app/cores/utils/popups/alert_dialog.dart';
import 'package:job_app/cores/utils/popups/loaders.dart';
import 'package:job_app/routes/app_routes.dart';

class ApplyNowController extends GetxController {
  static ApplyNowController get instance => Get.find();
  var uploadedFileName = ''.obs;
  var isFileUploaded = false.obs;
  var isLoading = false.obs;
  var fileType = ''.obs;
  var fileSize = 0.obs;
  var filePath = ''.obs;
  var isPreviewing = false.obs;

  Future<void> pickFile() async {
    // if (!await NetworkManager.instance.isConnected()) {
    //   Loaders.errorSnackBar(
    //     title: 'Network Error',
    //     message: 'No internet connection.',
    //   );
    //   return;
    // }

    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'],
      );

      if (result != null) {
        PlatformFile file = result.files.first;
        uploadedFileName.value = file.name;
        isFileUploaded.value = true;
        fileType.value = file.extension ?? '';
        fileSize.value = (file.size / 1024).toInt(); // Convert size to KB
        filePath.value = file.path ?? '';

        Loaders.successSnackBar(
          title: 'Success',
          message: 'CV uploaded successfully!',
        );
      }
    } catch (e) {
      Loaders.errorSnackBar(
        title: 'Error',
        message: 'Failed to upload CV. Please try again.',
      );
    }
  }

  void removeFile() {
    uploadedFileName.value = '';
    isFileUploaded.value = false;

    Loaders.successSnackBar(
      title: 'Success',
      message: 'CV removed successfully!',
    );
  }

  void previewFile() async {
    if (!isFileUploaded.value) {
      Loaders.warningSnackBar(
        title: 'Warning',
        message: 'Please upload your CV first',
      );
      return;
    }

    if (fileType.value == 'pdf') {
      isPreviewing.value = true;
      await Future.delayed(const Duration(milliseconds: 500));
      Get.toNamed(AppRoutes.previewPdf);
    } else {
      Loaders.warningSnackBar(
        title: 'Warning',
        message: 'Preview is only available for PDF files.',
      );
    }
  }

  Future<void> submitApplication() async {
    // if (!await NetworkManager.instance.isConnected()) {
    //   Loaders.errorSnackBar(
    //     title: 'Network Error',
    //     message: 'No internet connection.',
    //   );
    //   return;
    // }

    if (!isFileUploaded.value) {
      Loaders.warningSnackBar(
        title: 'Warning',
        message: 'Please upload your CV first',
      );
      return;
    }

    try {
      isLoading.value = true;

      // Simulate network request
      await Future.delayed(const Duration(seconds: 2));

      SweetAlert.show(
        type: SweetAlertType.success,
        title: 'Success',
        subTitle: 'Application submitted successfully!',
        onConfirm: () {
          Get.back();
        },
      );

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Loaders.errorSnackBar(
        title: 'Error',
        message: 'Failed to submit application. Please try again.',
      );
    }
  }
}
