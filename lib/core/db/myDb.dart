import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;

import '../model/product.dart';

class MyDb {
  Future<List<Product>> getAllProducts() async {
    FirebaseFirestore _fireStore = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>>? _querySnapshot =
        await _fireStore.collection('products').get();
    List<QueryDocumentSnapshot> _loadedItems = _querySnapshot.docs;
    var list = _loadedItems.map((QueryDocumentSnapshot doc) {
      return Product.fromFirestore(doc);
    }).toList();

    return list;
  }

  Future<String> addProduct(Product product) async {



    FirebaseFirestore _fireStore = FirebaseFirestore.instance;
    var snapShot = await _fireStore.collection('products').add(
      {
        'curtainHeight': product.curtainHeight,
        'curtainWidth': product.curtainPriceForSelling,
        'curtainRealPrice': product.curtainRealPrice,
        'curtainSellPrice': product.curtainSellPrice,
        'benefit': product.benefit,
        'date': product.createdDate,
        'finishDate': product.finishDate,
        'collectionType': product.collectionType,
        'status': product.status,
      },
    );
    return snapShot.path;
  }

  Future<String> deleteProduct(Product product) async {
    FirebaseFirestore _fireStore = FirebaseFirestore.instance;
    var snapShot = await _fireStore
        .collection('products')
        .doc(product.id)
        .delete()
        .then((value) {});

    return snapShot.toString();
  }

  // Future<String> updateProduct(Product product) async {
  //   FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  //   final firebase_storage.Reference ref =
  //   firebase_storage.FirebaseStorage.instance.ref().child(product.imageName);
  //
  //   final firebase_storage.UploadTask uploadTask = ref.putFile(product.image!);
  //
  //
  //   await uploadTask.whenComplete(() => print('File uploaded'));
  //   final firebase_storage.Reference getImagePath =
  //   firebase_storage.FirebaseStorage.instance.ref().child(product.imageName);
  //
  //   final String downloadURL = await getImagePath.getDownloadURL();
  //
  //
  //   print("Id"+product.id.toString());
  //   var snapShot = await _fireStore
  //       .collection('products')
  //       .doc(product.id)
  //       .update({
  //         "id": product.id,
  //         'name': product.name,
  //         'information': product.information,
  //         'color': product.color,
  //         'ram': product.ram,
  //         'version': product.version,
  //         'storage': product.storage,
  //         'productBuyType': product.productBuyType,
  //         'productPrice': product.productPrice,
  //         'productDate': product.productDate,
  //         'image': downloadURL,
  //       })
  //       .then((value) {})
  //       .whenComplete(() => null);
  //
  //   return snapShot.toString();
  // }
}
