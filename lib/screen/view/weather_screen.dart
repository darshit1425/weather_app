import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/screen/modal/weather_modal.dart';
import 'package:weather_app/screen/provider/weather_provider.dart';

class Home_screen extends StatefulWidget {
  const Home_screen({Key? key}) : super(key: key);

  @override
  State<Home_screen> createState() => _Home_screenState();
}

class _Home_screenState extends State<Home_screen> {
  Weather_Provider? weather_providerTrue;
  Weather_Provider? weather_providerFalse;
  TextEditingController txtSearch = TextEditingController(text: "Surat");

  @override
  Widget build(BuildContext context) {
    weather_providerFalse =
        Provider.of<Weather_Provider>(context, listen: false);
    weather_providerTrue = Provider.of<Weather_Provider>(context, listen: true);
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(),
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              child: Image.asset(
                "assets/images/we.jpg",
                fit: BoxFit.fill,
              ),
            ),
            FutureBuilder(
              future: weather_providerTrue!.getData(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(
                    "${snapshot.error}",
                    style: TextStyle(fontSize: 50, color: Colors.white),
                  );
                } else if (snapshot.hasData) {
                  WeatherModel? weatherModel = snapshot.data;
                  return Center(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            color: Colors.blueAccent.shade700,
                            child: TextField(
                              style: TextStyle(color: Colors.white),
                              controller: txtSearch,
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                hintText: "search city ",
                                hintStyle: TextStyle(color: Colors.white),
                                border: InputBorder.none,
                                prefixIcon: IconButton(
                                  onPressed: () {
                                    weather_providerFalse!
                                        .ChangeValue(txtSearch.text);
                                    print("=====${txtSearch.text}");
                                  },
                                  icon: Icon(Icons.search),
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 50,),

                        Text(
                          "${weatherModel!.main.temp}",
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // Text("${weatherModel.clouds!.all}",style: TextStyle(color: Colors.white),),
                        Align(
                          //alignment: Alignment.bottomCenter,
                          child: Text(
                            "${weatherModel.name}",
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 25),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),

                        Text(
                          "${weatherModel.cod}",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.black87,
                  ),
                );
              },
            ),

            // Padding(
            //   padding: const EdgeInsets.only(top: 50),
            //   child: TextField(
            //     style: TextStyle(color: Colors.white),
            //     controller: txtSearch,
            //   ),
            // ),
            // Center(
            //   child: Padding(
            //     padding: EdgeInsets.only(top: 50),
            //     child: ElevatedButton(
            //         onPressed: () {
            //           weather_providerFalse!.ChangeValue(txtSearch.text);
            //           print("=====${txtSearch.text}");
            //         },
            //         child: Text("Search")),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
