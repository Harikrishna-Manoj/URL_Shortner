import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:url_shortner/Bloc/home_bloc/home_bloc.dart';
import 'package:url_shortner/presentation/screen_home/widgets/widgets.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});
  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    late String shortedData = '';
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: gradiantAppBar(),
      body: SafeArea(
          child: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.cyan, Colors.blue, Colors.indigo[700]!]),
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 20, left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              TextField(
                controller: textEditingController,
                decoration: InputDecoration(
                    label: const Text(
                      "Paste URL",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10))),
              ),
              const SizedBox(height: 50),
              BlocConsumer<HomeBloc, HomeState>(listener: (context, state) {
                state.dataFeatchingSuccess == true
                    ? FlutterToastr.show("Link generated", context)
                    : FlutterToastr.show("Something went wrong", context);
              }, builder: (context, state) {
                shortedData = state.url;
                return Text(
                  "Shorted link : ${shortedData == '' ? "No link" : shortedData}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15),
                );
              }),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      textEditingController.text.isEmpty ||
                              RegExp(r"\s").hasMatch(textEditingController.text)
                          ? FlutterToastr.show("Empty field", context)
                          : BlocProvider.of<HomeBloc>(context).add(
                              GetShortedUrl(
                                  textEditingController.text.trim(), context));
                    },
                    icon: const Icon(Icons.short_text),
                    label: const Text(
                      "Get link",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    style: ButtonStyle(
                        elevation: const MaterialStatePropertyAll(10),
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.indigo[700]),
                        shape: MaterialStateProperty
                            .all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: const BorderSide(color: Colors.white)))),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      if (shortedData == '') {
                        FlutterToastr.show("No link copied", context);
                      } else {
                        BlocProvider.of<HomeBloc>(context)
                            .add(CopyToKeyboard());

                        FlutterToastr.show("Link copied", context);
                      }
                    },
                    icon: const Icon(Icons.copy),
                    label: const Text(
                      "Copy link",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    style: ButtonStyle(
                        elevation: const MaterialStatePropertyAll(10),
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.indigo[700]),
                        shape: MaterialStateProperty
                            .all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: const BorderSide(color: Colors.white)))),
                  )
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
