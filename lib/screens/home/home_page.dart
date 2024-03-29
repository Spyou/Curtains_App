import 'package:curtains_app/blocs/home_bloc/home_bloc.dart';
import 'package:curtains_app/blocs/home_bloc/home_event.dart';
import 'package:curtains_app/blocs/home_bloc/home_state.dart';
import 'package:curtains_app/screens/add/add_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeBloc homeBloc;

  @override
  void initState() {
    super.initState();
    homeBloc = BlocProvider.of<HomeBloc>(context);

    homeBloc.add(GetHomeListEvent());
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            child: const Center(
              child: Icon(Icons.add),
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AddScreen()));
            }),
        body: BlocConsumer<HomeBloc, HomeState>(listener: (context, state) {
  },
  builder: (context, state) {
    return NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                toolbarHeight: 80,
                title: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://media.kitsu.io/anime/45857/poster_image/large-1ebb56f346edda6bcde9cdffa9b89316.jpeg'),
                        radius: 30,
                      ),
                      SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Good Morning',
                            style: TextStyle(fontSize: 13),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            'Said',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                floating: true,
                centerTitle: false,
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        OctIcons.bell,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: IconButton(
                      onPressed: () {
                        homeBloc.add(GetHomeListEvent());
                      },
                      icon: const Icon(
                        Icons.refresh,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ];
          },
          body: SingleChildScrollView(
            child: Builder(
              builder: (context) {
                if(state is GetHomeList){
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Divider(),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            const Text(
                              'Order Details',
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Row(
                                children: [
                                  Text(
                                    'Today',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 7,
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    size: 15,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 15, top: 2, right: 0),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 7),
                                  height: 80,
                                  width: 180,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          const Text(
                                            'Total Orders',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const Spacer(),
                                          IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                Icons.more_vert_rounded,
                                                size: 20,
                                              )),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Row(
                                        children: [
                                          Text(
                                            '12',
                                            style: TextStyle(
                                              fontSize: 28,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                        child: Container(
                          height: 210,
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Curtains Overview - Today',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Color.fromARGB(255, 0, 206, 7),
                                    radius: 12,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Available Curtains',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    '4',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Color(0xFFFFD500),
                                    radius: 12,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Received Curtains',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    '2',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Color(0xFF4A89FF),
                                    radius: 12,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Sold Curtains',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    '9',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ListView.builder(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 5),
                            shrinkWrap: true,
                            itemCount: state.homeList.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              var product=state.homeList[index];
                              return Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 7),
                                  child: ListTile(
                                    onTap: () {},
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    tileColor: Colors.grey[200],
                                    title: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Mijoz ${index + 1} ',
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const Spacer(),
                                           Text(
                                            product.createdDate.toString(),
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                product.collectionType,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Spacer(),
                                              Text("Haqiyqiy narx :  ",style: TextStyle(fontSize: 14,color: Colors.black),),
                                              Text(
                                                "${product.curtainRealPrice}",
                                                style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),

                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                           Row(
                                             children: [
                                               Text(
                                                "Bo`yi ${product.curtainHeight}",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                               ),
                                               Spacer(),
                                               Text("Foyda :  ",style: TextStyle(fontSize: 14,color: Colors.black),),
                                               Text(
                                                 "${product.benefit}",
                                                 style: TextStyle(
                                                   fontSize: 17,
                                                   fontWeight: FontWeight.bold,
                                                   color: Colors.black,
                                                 ),
                                               ),

                                             ],
                                           ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                           Row(
                                            children: [
                                              Text(
                                                "Eni ${product.curtainWidth}",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Spacer(),
                                              Text("Sotilgan narx: ",style: TextStyle(fontSize: 14,color: Colors.black),),
                                              Text(
                                                "${product.curtainSellPrice}",
                                                style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ));
                            }),
                      )
                    ],
                  );

                }
                if (state is HomeErrorState){
                  return Container(child: Center(child: Text(state.error),), );
                }
                if (state is LoadingHomeState){
                  return Container(child: Center(child: CircularProgressIndicator(),),);
                }
                else{
                  return Container(child: Center(child: Text("Nothing   ")),);
                }
              }
            ),
          ),
        );
  },
));
  }
}
