import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:task6/services/shared_preferences_service.dart';

import '../Helper/constants.dart';

class ProfileScreen extends StatelessWidget {

  final PrefService _prefService = PrefService();

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFAB72C0),
          shape: const RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(20),
              bottomStart: Radius.circular(20))),
          leading: IconButton(
            onPressed: (){},
            icon: IconButton(
              onPressed: ()
              {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_outlined,),
            ),
          ),
          title: const Text(
            'Profile',
            style: TextStyle(
              fontSize: 22,
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(0),
            children: [
              Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height:20,
                    ),
                    CircleAvatar(
                      radius: 95,
                      backgroundColor:  const Color(0xFFAB72C0),
                      child: CircleAvatar(
                        radius: 91,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 89,
                          backgroundColor: Colors.white,
                          child: CachedNetworkImage(
                            imageUrl: "https://miro.medium.com/max/785/0*Ggt-XwliwAO6QURi.jpg",
                            fit: BoxFit.contain,
                            imageBuilder: (context, imageProvider) => CircleAvatar(
                                radius: 86,
                                backgroundImage: imageProvider
                            ),
                            placeholder: (context, url) => const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 7,
                            ),
                            errorWidget: (context, url, error) => const Icon(Icons.error),
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 20,
                      ),
                      child: Text(
                        'Adam Philips',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    Text(
                      '@adamphilips',
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(380, 45),
                          backgroundColor:const Color(0xFFAB72C0),
                          shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(11.0)) ,
                        ),
                        onPressed: () async{

                          await _prefService.removeCache("password").whenComplete((){
                            Navigator.of(context).pushNamed(loginRoute);
                          });
                        },
                        child: const Text(
                          'Log out',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Divider(
                      color: Colors.black12,
                      thickness: 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          TextButton(
                            onPressed: (){},
                            child: const Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.settings,
                                  color: Color(0xFFAB72C0),
                                  size: 30,
                                ),
                                SizedBox(width: 20,),
                                Text(
                                  'Settings',
                                  style: TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFAB72C0),
                                    letterSpacing: 1,
                                  ),),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: (){},
                            child: const Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.person,
                                  color: Color(0xFFAB72C0),
                                  size: 30,
                                ),
                                SizedBox(width: 20,),
                                Text(
                                  'Friend',
                                  style: TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFAB72C0),
                                    letterSpacing: 1,
                                  ),),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: (){},
                            child: const Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.people,
                                  color: Color(0xFFAB72C0),
                                  size: 30,
                                ),
                                SizedBox(width: 20,),
                                Text(
                                  'New Group',
                                  style: TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFAB72C0),
                                    letterSpacing: 1,
                                  ),),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
