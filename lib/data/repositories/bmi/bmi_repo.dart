// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../../../services/error/error_handler.dart';
// import '../../../services/log/app_log.dart';
// import '../../constants/constants.dart';
import '../../models/bmi/bmi_model.dart';
import '../../models/response/app_response.dart';

abstract class BmiRepository {
  final ErrorHandler errorHandler;
  final SharedPreferences sharedPreferences;
  BmiRepository({
    required this.errorHandler,
    required this.sharedPreferences,
  });
  Future<AppResponse> fetch(int perPage);
  Future<AppResponse> add(BmiModel bmiModel);
  Future<AppResponse> update(BmiModel bmiModel);
  Future<AppResponse> delete(BmiModel bmiModel);
  Future<AppResponse> deleteAll();
}

// // Using Firebase as remote repository
// class FirebaseBmiRepo extends BmiRepository {
//   final FirebaseFirestore _firebaseFirestore;
//   FirebaseBmiRepo({
//     required FirebaseFirestore firebaseFirestore,
//     required super.errorHandler,
//     required super.sharedPreferences,
//   }) : _firebaseFirestore = firebaseFirestore;

//   @override
//   Future<AppResponse> add(BmiModel bmiModel) async {
//     try {
//       final String uid = sharedPreferences.getString(AppConstants.userIdKey)!;
//       await _firebaseFirestore
//           .collection(uid)
//           .doc(bmiModel.id)
//           .set(bmiModel.toMap());

//       AppLog.logValueAndTitle('Document Id', bmiModel.id);

//       // response.get().then((value) => print(value.data()))

//       return AppResponse.withSuccess(
//         data: bmiModel.toMap(),
//       );
//     } catch (e) {
//       return AppResponse.withError(
//         message: errorHandler.getErrorMessage(e),
//       );
//     }
//   }

//   @override
//   Future<AppResponse> update(BmiModel bmiModel) async {
//     try {
//       await _firebaseFirestore
//           .collection(sharedPreferences.getString(AppConstants.userIdKey)!)
//           .doc(bmiModel.id)
//           .update(bmiModel.toMap());

//       return AppResponse.withSuccess(
//         data: bmiModel.toMap(),
//       );
//     } catch (e) {
//       return AppResponse.withError(
//         message: errorHandler.getErrorMessage(e),
//       );
//     }
//   }

//   @override
//   Future<AppResponse> delete(BmiModel bmiModel) async {
//     try {
//       await _firebaseFirestore
//           .collection(sharedPreferences.getString(AppConstants.userIdKey)!)
//           .doc(bmiModel.id)
//           .delete();
//       return AppResponse.withSuccess(
//         data: {},
//       );
//     } catch (e) {
//       return AppResponse.withError(
//         message: errorHandler.getErrorMessage(e),
//       );
//     }
//   }

//   @override
//   Future<AppResponse> deleteAll() async {
//     try {
//       QuerySnapshot<Map<String, dynamic>> querySnapshot =
//           await _firebaseFirestore
//               .collection(sharedPreferences.getString(AppConstants.userIdKey)!)
//               .get();

//       for (var doc in querySnapshot.docs) {
//         await doc.reference.delete();
//       }
//       return AppResponse.withSuccess(
//         data: {},
//       );
//     } catch (e) {
//       return AppResponse.withError(
//         message: errorHandler.getErrorMessage(e),
//       );
//     }
//   }

//   @override
//   Future<AppResponse> fetch(int perPage) async {
//     try {
//       // Fetch records ten by ten
//       QuerySnapshot<Map<String, dynamic>> querySnapshot =
//           await _firebaseFirestore
//               .collection(
//                 sharedPreferences.getString(AppConstants.userIdKey)!,
//               )
//               .orderBy(
//                 'created_date',
//                 descending: true,
//               )
//               .limit(perPage)
//               .get();

//       final List<BmiModel> fetchedRecords = [];

//       fetchedRecords.addAll(
//         querySnapshot.docs.map((doc) => BmiModel.fromMap(doc.data())),
//       );

//       final Map<String, dynamic> response = {
//         'data': fetchedRecords,
//       };

//       return AppResponse.withSuccess(
//         data: response,
//       );
//     } catch (e) {
//       return AppResponse.withError(
//         message: errorHandler.getErrorMessage(e),
//       );
//     }
//   }
// }

// Using SQFLITE as local repository
class SqlBmiRepo extends BmiRepository {
  final Database _db;
  SqlBmiRepo({
    required Database database,
    required super.errorHandler,
    required super.sharedPreferences,
  }) : _db = database;

  @override
  Future<AppResponse> add(BmiModel bmiModel) async {
    try {
      await _db.insert(
        'Records',
        bmiModel.toMap(),
      );
      return AppResponse.withSuccess(
        data: bmiModel.toMap(),
      );
    } catch (e) {
      return AppResponse.withError(
        message: errorHandler.getErrorMessage(e),
      );
    }
  }

  @override
  Future<AppResponse> delete(BmiModel bmiModel) async {
    try {
      await _db.delete(
        'Records',
        where: 'id = ?',
        whereArgs: [
          bmiModel.id,
        ],
      );
      return AppResponse.withSuccess(
        data: bmiModel.toMap(),
      );
    } catch (e) {
      return AppResponse.withError(
        message: errorHandler.getErrorMessage(e),
      );
    }
  }

  @override
  Future<AppResponse> deleteAll() async {
    try {
      await _db.delete(
        'Records',
      );
      return AppResponse.withSuccess(
        data: {},
      );
    } catch (e) {
      return AppResponse.withError(
        message: errorHandler.getErrorMessage(e),
      );
    }
  }

  @override
  Future<AppResponse> fetch(int perPage) async {
    try {
      final List outList = await _db.rawQuery(
        'SELECT * FROM Records ORDER BY created_date DESC LIMIT $perPage',
      );

      final List<BmiModel> fetchedRecords = [];

      fetchedRecords.addAll(
        outList.map((e) => BmiModel.fromMap(
              e,
            )),
      );

      final Map<String, dynamic> response = {
        'data': fetchedRecords,
      };
      return AppResponse.withSuccess(
        data: response,
      );
    } catch (e) {
      return AppResponse.withError(
        message: errorHandler.getErrorMessage(e),
      );
    }
  }

  @override
  Future<AppResponse> update(BmiModel bmiModel) async {
    try {
      await _db.update(
        'Records',
        bmiModel.toMap(),
        where: 'id = ?',
        whereArgs: [
          bmiModel.id,
        ],
      );
      return AppResponse.withSuccess(
        data: bmiModel.toMap(),
      );
    } catch (e) {
      return AppResponse.withError(
        message: errorHandler.getErrorMessage(e),
      );
    }
  }
}
