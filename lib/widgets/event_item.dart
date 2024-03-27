// import 'package:flutter/material.dart';
// import 'package:address_24/project/project_flutter_calendar/models/event.dart';

// class EventItem extends StatelessWidget {
//   const EventItem({
//     super.key,
//     required this.p,
//   });

//   final Event p;

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Row(
//           // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             CircleAvatar(
//               backgroundImage: NetworkImage(p.picture!.thumbnail!),
//               radius: 35,
//             ),
//             const SizedBox(
//               width: 20,
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [Text(p.name!), Text(p.description!)],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
