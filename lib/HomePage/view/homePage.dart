import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:untitled/HomePage/helpers/dbHelper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController nameController = TextEditingController();

  final GlobalKey<FormState> updateForm = GlobalKey<FormState>();

  late Future getData;

  @override
  void initState() {
    DBHelper.dbHelper.initDB();
    getData = DBHelper.dbHelper.fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.red,systemNavigationBarColor: Colors.red));
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.bookmark_border,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.file_upload_outlined,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder(
        // future: ApiHelper.apiHelper.fetchData(),
        future: DBHelper.dbHelper.fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.hasError}"),
            );
          } else if (snapshot.hasData) {
            List<Map<String, dynamic>>? data = snapshot.data;
            return ListView.builder(
              itemCount: 49,
              itemBuilder: (context, index) {
                return ListTile(
                  isThreeLine: true,
                  leading: Container(
                    height: 100,
                    width: 70,
                    decoration: BoxDecoration(
                      color: Colors.red.shade200,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image(
                      image: NetworkImage("${data![index]['image']}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text("${data[index]['name']}"),
                  subtitle: Text(
                    "${data[index]['categoryName']} \nPrice:${data[index]['price']} \nRate: ${data[index]['averageRating']}",
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        width: 25,
                      ),
                      IconButton(
                        onPressed: () async {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Form(
                                key: updateForm,
                                child: AlertDialog(
                                  title: const Text("UPDATE DATA"),
                                  content: TextFormField(
                                    controller: nameController,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  actions: [
                                    Row(
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {},
                                          child: const Text("Update"),
                                        ),
                                        const SizedBox(
                                          width: 30,
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: const Text("Close"),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      IconButton(
                        onPressed: () async {
                          int item = await DBHelper.dbHelper
                              .deleteData(id: data[index]['id']);

                          if (item == 1) {
                            setState(() {
                              getData = DBHelper.dbHelper.fetchData();
                            });
                          }
                        },
                        icon: const Icon(
                          Icons.delete_rounded,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                );
              },
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
