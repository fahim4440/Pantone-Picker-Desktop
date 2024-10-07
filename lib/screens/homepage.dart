import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pantone_book/bloc/search_color/color_search_bloc.dart';
import 'package:pantone_book/model/pantone_model.dart';
import 'package:pantone_book/widgets/alert_color_card.dart';
import 'package:pantone_book/widgets/contact_footer.dart';
import 'package:pantone_book/widgets/search_color_text_field.dart';
import '../repository/image_repository.dart';
import '../services/pantone_database/db_helper.dart';
import '../widgets/animation_container.dart';
import '../widgets/color_list_tile.dart';
import '../widgets/greetings_card.dart';
import 'profile_page.dart';

class Homepage extends StatefulWidget {
  final String name;
  const Homepage({super.key, required this.name});

  @override
  State<Homepage> createState() => _HomepageState();
}


class _HomepageState extends State<Homepage> {
  final ImageRepository _imageRepository = ImageRepository();
  final PantoneDBHelper _pantoneDBHelper = PantoneDBHelper();
  int _selectedIndex = 0; // Track selected page

  @override
  void initState() {
    super.initState();
    _pantoneDBHelper.initializePantoneDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pantone Picker',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 225, 237, 240),
        elevation: 3.0,
      ),
      body: Row(
        children: [
          // Sidebar
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index; // Update selected index
              });
            },
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.home),
                label: Text('Home'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.person),
                label: Text('Profile'),
              ),
              // Add more destinations if needed
            ],
          ),
          Expanded(
            child: IndexedStack( // Use IndexedStack to switch pages
              index: _selectedIndex,
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Card(
                                margin: const EdgeInsets.symmetric(vertical: 10.0),
                                color: const Color.fromARGB(255, 225, 237, 240),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                elevation: 5.0,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(20.0),
                                  onTap: () {
                                    setState(() {
                                      _selectedIndex = 1; // Navigate to profile on tap
                                    });
                                  },
                                  child: GreetingsCard(widget.name.split(" ").first),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20.0),
                            Expanded(child: SearchColorTextField(context)),
                            const SizedBox(width: 20.0),
                          ],
                        ),
                        const SizedBox(height: 20.0),
                        BlocBuilder<ColorSearchBloc, ColorSearchState>(
                          builder: (context, state) {
                            if (state is ColorSearchLoadingState) {
                              return const Center(child: CircularProgressIndicator());
                            } else if (state is ColorSearchErrorState) {
                              return Center(child: Text(state.errorMessage));
                            } else if (state is ColorSearchLoadedState) {
                              return GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 10.0,
                                  crossAxisSpacing: 10.0,
                                  childAspectRatio: 2,
                                ),
                                itemCount: state.colors.length,
                                itemBuilder: (BuildContext context, int index) {
                                  PantoneColor color = state.colors[index];
                                  return InkWell(
                                    borderRadius: BorderRadius.circular(20.0),
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertColorCard(context, color),
                                      );
                                    },
                                    child: ColorListTile(context, color),
                                  );
                                },
                              );
                            } else if (state is ColorSearchInitial) {
                              return AnimationContainer();
                            }
                            return AnimationContainer();
                          },
                        ),
                        const SizedBox(height: 20.0),
                        ContactFooter(),
                      ],
                    ),
                  ),
                ),
                const ProfilePage(), // Add ProfilePage here
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'fromGallery',
        onPressed: () {
          _imageRepository.pickImageFromGallery(context);
        },
        child: const Icon(Icons.image),
      ),
    );
  }
}


// class _HomepageState extends State<Homepage> {
//   final ImageRepository _imageRepository = ImageRepository();
//   final PantoneDBHelper _pantoneDBHelper = PantoneDBHelper();

//   @override
//   void initState() {
//     super.initState();
//     _pantoneDBHelper.initializePantoneDatabase();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Pantone Picker',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         backgroundColor: const Color.fromARGB(255, 225, 237, 240),
//         elevation: 3.0,
//       ),
//       body: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Sidebar
//           NavigationRail(
//             selectedIndex: 0,
//             onDestinationSelected: (int index) {
//               // Handle navigation here
//             },
//             destinations: [
//               NavigationRailDestination(
//                 icon: MaterialButton(
//                   onPressed: () {
//                     Navigator.pushReplacement(context, MaterialPageRoute(
//                       builder: (context) => Homepage(name: widget.name,),
//                     ));
//                   },
//                   child: const Icon(Icons.home),
//                 ),
//                 label: const Text('Home'),
//               ),
//               NavigationRailDestination(
//                 icon: MaterialButton(
//                   onPressed: () {
//                     Navigator.pushReplacement(context, MaterialPageRoute(
//                       builder: (context) => const ProfilePage(),
//                     ));
//                   },
//                   child: const Icon(Icons.person),
//                 ),
//                 label: const Text('Profile'),
//               ),
//               // Add more destinations if needed
//             ],
//           ),
//           Expanded(
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Expanded(
//                           child: Card(
//                             margin: const EdgeInsets.symmetric(vertical: 10.0),
//                             color: const Color.fromARGB(255, 225, 237, 240),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(20.0),
//                             ),
//                             elevation: 5.0,
//                             child: InkWell(
//                               borderRadius: BorderRadius.circular(20.0),
//                               onTap: () {
//                                 Navigator.push(context, MaterialPageRoute(
//                                   builder: (context) => const ProfilePage(),
//                                 ));
//                               },
//                               child: GreetingsCard(widget.name.split(" ").first),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(width: 20.0),
//                         Expanded(child: SearchColorTextField(context)),
//                         const SizedBox(width: 20.0),
//                       ],
//                     ),
//                     const SizedBox(height: 20.0),
//                     BlocBuilder<ColorSearchBloc, ColorSearchState>(
//                       builder: (context, state) {
//                         if (state is ColorSearchLoadingState) {
//                           return const Center(child: CircularProgressIndicator());
//                         } else if (state is ColorSearchErrorState) {
//                           return Center(child: Text(state.errorMessage));
//                         } else if (state is ColorSearchLoadedState) {
//                           return GridView.builder(
//                             shrinkWrap: true,
//                             physics: const NeverScrollableScrollPhysics(),
//                             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                               crossAxisCount: 3, // Adjust based on screen width
//                               mainAxisSpacing: 10.0,
//                               crossAxisSpacing: 10.0,
//                               childAspectRatio: 2,
//                             ),
//                             itemCount: state.colors.length,
//                             itemBuilder: (BuildContext context, int index) {
//                               PantoneColor color = state.colors[index];
//                               return InkWell(
//                                 borderRadius: BorderRadius.circular(5.0),
//                                 onTap: () {
//                                   showDialog(
//                                     context: context,
//                                     builder: (context) => AlertColorCard(context, color),
//                                   );
//                                 },
//                                 child: ColorListTile(context, color),
//                               );
//                             },
//                           );
//                         } else if (state is ColorSearchInitial) {
//                           return AnimationContainer();
//                         }
//                         return AnimationContainer();
//                       },
//                     ),
//                     const SizedBox(height: 20.0),
//                     ContactFooter(),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: Row(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           FloatingActionButton(
//             heroTag: 'fromCamera',
//             onPressed: () {
//               _imageRepository.pickImageFromCamera(context);
//             },
//             child: const Icon(Icons.camera_alt),
//           ),
//           const SizedBox(width: 20.0),
//           FloatingActionButton(
//             heroTag: 'fromGallery',
//             onPressed: () {
//               _imageRepository.pickImageFromGallery(context);
//             },
//             child: const Icon(Icons.image),
//           ),
//         ],
//       ),
//     );
//   }
// }




// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:pantone_book/bloc/search_color/color_search_bloc.dart';
// import 'package:pantone_book/model/pantone_model.dart';
// import 'package:pantone_book/widgets/alert_color_card.dart';
// import 'package:pantone_book/widgets/contact_footer.dart';
// import 'package:pantone_book/widgets/search_color_text_field.dart';
// import '../repository/image_repository.dart';
// import '../services/pantone_database/db_helper.dart';
// import '../widgets/animation_container.dart';
// import '../widgets/color_list_tile.dart';
// import '../widgets/greetings_card.dart';
// import 'profile_page.dart';

// class Homepage extends StatefulWidget {
//   final String name;
//   const Homepage({super.key, required this.name});

//   @override
//   State<Homepage> createState() => _HomepageState();
// }

// class _HomepageState extends State<Homepage> {

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _pantoneDBHelper.initializePantoneDatabase();
//   }

//   final ImageRepository _imageRepository = ImageRepository();
//   final PantoneDBHelper _pantoneDBHelper = PantoneDBHelper();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Pantone Picker',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         backgroundColor: const Color.fromARGB(255, 225, 237, 240),
//         elevation: 3.0,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             SizedBox(
//               // height: 100.0,
//               // width: 300.0,
//               child: Card(
//                 margin: const EdgeInsets.all(10.0),
//                 color: const Color.fromARGB(255, 225, 237, 240),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20.0),
//                 ),
//                 elevation: 5.0,
//                 child: InkWell(
//                   borderRadius: BorderRadius.circular(20.0),
//                   onTap: () {
//                     Navigator.push(context, MaterialPageRoute(
//                       builder: (context) => const ProfilePage(),
//                     ));
//                   },
//                   child: GreetingsCard(widget.name.split(" ").first),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20.0,),
//             Container(
//               margin: const EdgeInsets.all(15.0),
//               child: SearchColorTextField(context),
//             ),
//             Column(
//               children: [
//                 BlocBuilder<ColorSearchBloc, ColorSearchState>(
//                   builder: (context, state) {
//                     if (state is ColorSearchLoadingState) {
//                       return const Center(child: CircularProgressIndicator(),);
//                     } else if (state is ColorSearchErrorState) {
//                       return Center(child: Text(state.errorMessage),);
//                     } else if (state is ColorSearchLoadedState) {
//                       return ListView.builder(
//                         shrinkWrap: true,
//                         scrollDirection: Axis.vertical,
//                         physics: const NeverScrollableScrollPhysics(),
//                         itemCount: state.colors.length,
//                         itemBuilder: (BuildContext context, int index) {
//                           PantoneColor color = state.colors[index];
//                           return Column(
//                             children: [
//                               InkWell(
//                                 borderRadius: BorderRadius.circular(5.0),
//                                 onTap: () {
//                                   showDialog(context: context, builder: (context) =>
//                                   AlertColorCard(context, color));
//                                 },
//                                 child: ColorListTile(context, color),
//                               ),
//                               Container(
//                                 margin: const EdgeInsets.only(left: 10.0, right: 10.0),
//                                 child: const Divider(color: Colors.blueGrey,),
//                               ),
//                             ],
//                           );
//                         },
//                       );
//                     } else if (state is ColorSearchInitial) {
//                       return AnimationContainer();
//                     }
//                     return AnimationContainer();
//                   },
//                 ),
//                 ContactFooter(),
//               ],
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: Row(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           FloatingActionButton(
//             heroTag: 'fromCamera',
//             onPressed: () {
//               _imageRepository.pickImageFromCamera(context);
//             },
//             child: const Icon(Icons.camera_alt),
//           ),
//           const SizedBox(width: 20.0,),
//           FloatingActionButton(
//             heroTag: 'fromGallery',
//             onPressed: () {
//               _imageRepository.pickImageFromGallery(context);
//             },
//             child: const Icon(Icons.image),
//           ),
//         ],
//       ),
//     );
//   }
// }