
// Future<String> createAlbum(String message) async {
//   final uri =
//       'https://jointpoly-prd.mybluemix.net/api/message?{"input":{"text":"$message"},"context":{"conversation_id":"91a7167b-7fa7-46be-8c8d-61d8e03c22f2","system":{"initialized":true,"dialog_stack":[{"dialog_node":"root"}],"dialog_turn_counter":2,"dialog_request_counter":2,"branch_exited":true,"branch_exited_reason":"completed"},"iter":0,"course":"","school":"","counter":0,"netscore":"","crosspoly":false,"poly_array":[],"netscorenum":0,"polycontext":"Temasek Polytechnic","polytechnic":"Temasek Polytechnic","course_array":[],"school_array":[],"shortcourses":false,"npcoursefound":false,"rpcoursefound":false,"spcoursefound":false,"tpcoursefound":false,"disambiguation":false,"nypcoursefound":false,"iter_poly_array":0,"poly_comparison":false,"aboutcoursecheck":false,"artsstream_array":[],"iter_school_array":0,"admission_exercise":"","sciencestream_array":[],"courseinterest_array":[],"courserecommendation":false,"iter_artsstream_array":0,"moecourseinterest_array":[],"iter_sciencestream_array":0,"iter_courseinterest_array":0,"iter_moecourseinterest_array":0,"_id":"51c62f34-6613-4d6e-8f12-f81351a29028","prev_intent":"hi","nocourseinterest":true}}';
//   final headers = {'Content-Type': 'application/json'};
//   Map<String, dynamic> body = {
//     'input': {'text': 'asd'}
//   };
//   String jsonBody = json.encode(body);
//   final encoding = Encoding.getByName('utf-8');

//   Response response = await http.post(
//     uri,
//     headers: headers,
//     // body: jsonBody,
//     encoding: encoding,
//   );
//   print(response.body);
//   print(response.request);
//   return response.body;
// }

// Future<String> createAlbum(String message) async {
//   final client = Sigv4Client(
//     keyId: 'AKIA6QIMA3HZ2JHP656M',
//     accessKey: 'oYZJTGj626wA8OHQ53PF+bMRowaBRTJYrLSu4vGI',
//     region: 'us-east-1',
//     serviceName: 'lex',
//   );

//   final uri =
//       'https://runtime.lex.us-east-1.amazonaws.com/bot/TPChatBot/alias/Prod/user/tplexbot/text';

//   var secretKey = utf8.encode("oYZJTGj626wA8OHQ53PF+bMRowaBRTJYrLSu4vGI");

//   Map<String, dynamic> body = {'inputText': "Hello"};
//   String jsonBody = json.encode(body);
//   Map<String, dynamic> authorizationHeaders = {
//     'content-type': '',
//     'host': '',
//     'x-amz-date': ''
//   };

//   Map<String, dynamic> canonicalHeaders = {
//     'host': uri,
//     'x-amz-date': DateFormat('yyyyMMdd').format(DateTime.now())
//   };

//   var useThis = utf8.encode(
//       "${DateFormat('yyyyMMdd').format(DateTime.now())}/us-east-1/lex/aws4_request");

//   // String req = Sigv4.buildCanonicalRequest("POST", uri, 'bot/TPChatBot/alias/Prod/user/tplexbot/text',canonicalHeaders, "hello");

//   String authorization = Sigv4.buildAuthorizationHeader(
//       'AKIA6QIMA3HZ2JHP656M',
//       "${DateFormat('yyyyMMdd').format(DateTime.now())}/us-east-1/lex/aws4_request",
//       authorizationHeaders,
//       Sigv4.buildStringToSign(DateFormat('yyyyMMdd').format(DateTime.now()),
//           useThis.toString(), "wtf"));

//   final headers = {
//     'Content-Type': 'application/json',
//     'Authorization': authorization,
//     'X-Amz-Date': Sigv4.generateDatetime()
//   };
//   Response response = await http.post(
//     uri,
//     headers: headers,
//     body: jsonBody,
//     // encoding: encoding,
//   );
//   print(response.body);
//   print(response.request);
//   return response.body;
// }
