// const admin = require('firebase-admin');
// var serviceAccount = require("./tp-app-aff2e-firebase-adminsdk-v0eyn-689d367d7f.json");

// admin.initializeApp({
//     credential: admin.credential.cert(serviceAccount),
//     databaseURL: "https://tp-app-aff2e.firebaseio.com"
// });

// let db = admin.firestore();

// db
//     // .collection('courses')
//     // .doc('asc')
//     // .collection('courseList')
//     // .get()
//     .collectionGroup('courseList')
//     .where('courseName', '==', 'Information Technology')
//     .get()
//     .then(function (querySnapshot) {
//         querySnapshot.forEach(function (doc) {
//             console.log(doc.id, ' => ', doc.data());
//         });
//     });
