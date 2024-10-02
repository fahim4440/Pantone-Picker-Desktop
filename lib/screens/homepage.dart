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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pantoneDBHelper.initializePantoneDatabase();
  }

  final ImageRepository _imageRepository = ImageRepository();
  final PantoneDBHelper _pantoneDBHelper = PantoneDBHelper();

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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              // height: 100.0,
              // width: 300.0,
              child: Card(
                margin: const EdgeInsets.all(10.0),
                color: const Color.fromARGB(255, 225, 237, 240),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                elevation: 5.0,
                child: InkWell(
                  borderRadius: BorderRadius.circular(20.0),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const ProfilePage(),
                    ));
                  },
                  child: GreetingsCard(widget.name.split(" ").first),
                ),
              ),
            ),
            const SizedBox(height: 20.0,),
            Container(
              margin: const EdgeInsets.all(15.0),
              child: SearchColorTextField(context),
            ),
            Column(
              children: [
                BlocBuilder<ColorSearchBloc, ColorSearchState>(
                  builder: (context, state) {
                    if (state is ColorSearchLoadingState) {
                      return const Center(child: CircularProgressIndicator(),);
                    } else if (state is ColorSearchErrorState) {
                      return Center(child: Text(state.errorMessage),);
                    } else if (state is ColorSearchLoadedState) {
                      return ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.colors.length,
                        itemBuilder: (BuildContext context, int index) {
                          PantoneColor color = state.colors[index];
                          return Column(
                            children: [
                              InkWell(
                                borderRadius: BorderRadius.circular(5.0),
                                onTap: () {
                                  showDialog(context: context, builder: (context) =>
                                  AlertColorCard(context, color));
                                },
                                child: ColorListTile(context, color),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                                child: const Divider(color: Colors.blueGrey,),
                              ),
                            ],
                          );
                        },
                      );
                    } else if (state is ColorSearchInitial) {
                      return AnimationContainer();
                    }
                    return AnimationContainer();
                  },
                ),
                ContactFooter(),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'fromCamera',
            onPressed: () {
              _imageRepository.pickImageFromCamera(context);
            },
            child: const Icon(Icons.camera_alt),
          ),
          const SizedBox(width: 20.0,),
          FloatingActionButton(
            heroTag: 'fromGallery',
            onPressed: () {
              _imageRepository.pickImageFromGallery(context);
            },
            child: const Icon(Icons.image),
          ),
        ],
      ),
    );
  }
}