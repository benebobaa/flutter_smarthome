import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smarthome/view_model/switch_provider.dart';
import 'package:flutter_smarthome/view/color/colors.dart';
import 'package:flutter_smarthome/view/widgets/custom_card.dart';
import 'package:flutter_smarthome/view/widgets/custom_card2.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final user = FirebaseAuth.instance.currentUser!;

  final dbRef = FirebaseDatabase.instance.ref();

  bool cek = false;

  @override
  Widget build(BuildContext context) {
    final switchProvider = Provider.of<SwitchProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: primaryColor,
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(
                  'https://i.pinimg.com/564x/d3/43/fb/d343fb1394fc1c63197955cc6247f547.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              accountName: const Text(''),
              accountEmail: Text(
                user.email!,
                style: const TextStyle(fontSize: 15),
              ),
            ),
            ListTile(
              title: Row(
                children: const <Widget>[
                  Icon(Icons.outlet_sharp),
                  Padding(
                    padding: EdgeInsets.only(left: 25.0),
                    child: Text(
                      'Sign Out',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              onTap: () {
                FirebaseAuth.instance.signOut();
              },
            ),
          ],
        ),
      ),
      body: StreamBuilder(
        stream: dbRef.child('Hasil_Pembacaan').onValue,
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              !snapshot.hasError &&
              snapshot.data!.snapshot.value != null) {
            var api = snapshot.data!.snapshot.child('api').value;
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.menu,
                            color: Colors.white,
                            size: 32,
                          ),
                          onPressed: () =>
                              _scaffoldKey.currentState!.openDrawer(),
                        ),
                        Text(
                          'Home',
                          style: GoogleFonts.oswald(
                            textStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 27,
                                letterSpacing: 2),
                          ),
                        ),
                        Container(
                          height: size.height * 0.040,
                          width: size.width * 0.090,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 10,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.notifications_none,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.03),
                    Row(
                      children: [
                        Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                              color: Colors.white,
                              width: 3,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              'https://i.pinimg.com/564x/d3/43/fb/d343fb1394fc1c63197955cc6247f547.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: size.width * 0.05),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Hello',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 35,
                              ),
                            ),
                            SizedBox(height: size.height * 0.01),
                            Text(
                              user.email!,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 23,
                                  fontStyle: FontStyle.italic),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.05),
                    Container(
                      height: 80,
                      width: size.width * 1,
                      decoration: BoxDecoration(
                        color: lightblue,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: Offset(3, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 50, right: 50),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  '${snapshot.data!.snapshot.child('suhu').value.toString()}??C',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  '${snapshot.data!.snapshot.child('kelembapan').value.toString()}%',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Temperature',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                Text(
                                  'Humidity',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey[600],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomCard(
                          bgcolor: card1,
                          status: switchProvider.homeTxt,
                          icon: switchProvider.homeIcn,
                          color: switchProvider.color1,
                          title: 'Home',
                          sendBool: () {
                            cek = !cek;
                            switchProvider.home = cek;
                          },
                        ),
                        CustomCard2(title: api.toString()),
                      ],
                    ),
                    SizedBox(height: size.height * 0.03),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomCard(
                          bgcolor: card4,
                          status: switchProvider.lampTxt,
                          color: switchProvider.color2,
                          title: 'Lampu',
                          sendBool: () {
                            cek = !cek;
                            switchProvider.lamp = cek;
                          },
                          icon: switchProvider.lampIcn,
                        ),
                        CustomCard(
                            bgcolor: card3,
                            color: switchProvider.color3,
                            title: 'Fan',
                            sendBool: () {
                              cek = !cek;
                              switchProvider.fan = cek;
                            },
                            icon: switchProvider.fanIcn,
                            status: switchProvider.fanTxt)
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
