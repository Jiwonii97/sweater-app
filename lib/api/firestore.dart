// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:sweater/providers/coordi_provider.dart';
// import 'package:provider/provider.dart';

// class GetFS extends StatelessWidget {
//   const GetFS({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     late CoordiInfo _coordiInfo;
//     _coordiInfo = Provider.of<CoordiInfo>(context);
//     FirebaseFirestore fs = FirebaseFirestore.instance;
//     QuerySnapshot qs;
//     return ElevatedButton(
//         onPressed: () async {
//           qs = await fs.collection('coordis').get();
//           _coordiInfo.addCoordiList(qs);
//           // print(qs.docs[0].runtimeType);
//         },
//         child: Text('click'));
//   }
// }


 // // QuerySnapshot lists = FirebaseFirestore.instance.collection('coordis').get(); 
  //   // final CoordiInfo coordiInfo =Provider.of<CoordiInfo>(context).addCoordiList(lists);
  //   FirebaseFirestore fs = FirebaseFirestore.instance;

  //   Future<QuerySnapshot> _getData() async {
  //     QuerySnapshot qs = await fs.collection('coordis').get();
  //     print(qs);
  //     return qs;
  //   }

  //   return FutureBuilder(
  //       future: _getData(),
  //       builder: (BuildContext context, AsyncSnapshot snapshot) {
  //         if (!snapshot.hasData) {
  //           return CircularProgressIndicator();
  //         }
  //         if (snapshot.hasError) {
  //           return Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: Text(
  //               'Error: ${snapshot.error}',
  //               style: TextStyle(fontSize: 15),
  //             ),
  //           );
  //         }
  //         return Text('aa');
  //       });
// class getFireStore extends StatefulWidget {
//   // const getFireStore({Key? key}) : super(key: key);

//   @override
//   _getFireStoreState createState() => _getFireStoreState();
// }

// class _getFireStoreState extends State<getFireStore> {
//   FirebaseFirestore fireStore = FirebaseFirestore.instance;

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: _getData(),
//         builder: (BuildContext context, AsyncSnapshot snapshot) {
//           if (!snapshot.hasData) {
//             return CircularProgressIndicator();
//           }
//           if (snapshot.hasError) {
//             return Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 'Error: ${snapshot.error}',
//                 style: TextStyle(fontSize: 15),
//               ),
//             );
//           } else
//             return ElevatedButton(onPressed: () {}, child: Text('aa'));
//         });
//   }

//   Future<QuerySnapshot> _getData() async {
//     QuerySnapshot qs = await fireStore.collection('coordis').get();
//     print(qs);
//     return qs;
//   }
// }

// Consumer<CoordiInfo>(
//         builder: (context, coordiInfo, child) => Text(coordiInfo.coordi));