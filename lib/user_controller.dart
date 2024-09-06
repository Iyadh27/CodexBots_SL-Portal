// user_controller.dart
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserController extends GetxController {
  // Define a reactive variable to store the UID
  var uid = ''.obs;

  // User details
 var fullName = ''.obs;
  var passportNumber = ''.obs;
  var nationality = ''.obs;
  var dateOfBirth = ''.obs;
  var travelDate = ''.obs;
  var returnDate = ''.obs;
  var contactNumber = ''.obs;
  var email = ''.obs;
  var gender = ''.obs;

  // Observable variables for travel form details
  var purposeOfVisit = ''.obs;
  var intendedDateOfTravel = ''.obs;
  var durationOfStay = ''.obs;
  var accommodationDetails = ''.obs;
  var previousTravelHistory = ''.obs;

  // Function to set the UID when the user logs in or signs up
  void setUid(String userId) {
    uid.value = userId;
  }


   String getUserId() {
    // Replace this with actual user ID fetching logic
    return uid.value;
  }

  // Function to set form details
  void setFormDetails({
    required String fullName,
    required String passportNumber,
    required String nationality,
    required String dateOfBirth,
    required String travelDate,
    required String returnDate,
    required String contactNumber,
    required String email,
    required String gender,
  }) {
    this.fullName.value = fullName;
    this.passportNumber.value = passportNumber;
    this.nationality.value = nationality;
    this.dateOfBirth.value = dateOfBirth;
    this.travelDate.value = travelDate;
    this.returnDate.value = returnDate;
    this.contactNumber.value = contactNumber;
    this.email.value = email;
    this.gender.value = gender;
  }

  // Function to save data to Firestore
  Future<void> saveToFirestore() async {
    if (uid.value.isNotEmpty) {
      try {
        await FirebaseFirestore.instance.collection('users').doc(uid.value).set({
          'fullName': fullName.value,
          'passportNumber': passportNumber.value,
          'nationality': nationality.value,
          'dateOfBirth': dateOfBirth.value,
          'travelDate': travelDate.value,
          'returnDate': returnDate.value,
          'contactNumber': contactNumber.value,
          'email': email.value,
          'gender': gender.value,
        });
        Get.snackbar('Success', 'Data saved successfully!');
      } catch (e) {
        print('Error saving data: $e');
        Get.snackbar('Error', 'Failed to save data.');
      }
    }
  }

  // Function to clear user data when logging out
  void clearUserData() {
    uid.value = '';
    fullName.value = '';
    passportNumber.value = '';
    nationality.value = '';
    dateOfBirth.value = '';
    travelDate.value = '';
    returnDate.value = '';
    contactNumber.value = '';
    email.value = '';
    gender.value = '';
  }
}
