import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_app/models/direction_details_model.dart';
import 'package:user_app/models/user_model.dart';

final FirebaseAuth fAuth = FirebaseAuth.instance;
UserModel? userModel;
User? currentFirebaseUser;
List dList = [];
DirectionDetailInfo? tripDirectionDetailInfo;
String? chosenDriverId = '';
String? cloudMessagingServerToken =
    "key=AAAAI6rzPU8:APA91bHOXsnK8XXNxgG7MknJUDJUvYnN6W1KUTi-E8mJtXRe_8kF7nzfrgQURoXftSavlRF_IlF0NtBvWSei7Y3Oy-_NVLBQEmkyfOZx2tz9NRdXxfBXCeVF1t4-H9yRfd_j9odINI_e";
String userDropOffAddress = "";

String driverCarDetails = '';
String driverName = '';
String driverPhone = '';
double countRatingStar = 0.0;
String titleStarRating = "";
