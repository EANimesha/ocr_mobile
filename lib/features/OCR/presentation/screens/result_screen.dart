import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ocr_mobile/features/OCR/presentation/bloc/bloc.dart';

class ResultScreen extends StatelessWidget {
  final File image;
  const ResultScreen(this.image, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ocrBloc = BlocProvider.of<OcrBloc>(context);
    ocrBloc.add(GetOcrResult(image));

    return Scaffold(
      appBar: AppBar(
        title: Text('OCR App Result'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.blueGrey.shade400,
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: BlocListener<OcrBloc, OcrState>(
                listener: (context, state) {
                  if (state is OcrErrorState) {
                    errorAlert(context,state.message);
                  }
                },
                child: BlocBuilder<OcrBloc, OcrState>(
                  builder: (context, state) {
                    if (state is OcrInitialState) {
                      return welcome();
                    } else if (state is OcrLoadingState) {
                      return loading(context);
                    } else if (state is OcrLoadedState) {
                      return result(state.ocrResult.textResult);
                    } else if (state is OcrErrorState) {
                      return Text(' ');
                    } else {
                      return Text(' ');
                    }
                  },
                ),
              ),
            )
          ),
      ),
    );
  }

//loading widget
  Widget loading(BuildContext context) {
    return Container(
      height:MediaQuery.of(context).size.height ,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[CircularProgressIndicator(), Text('Converting....')],
      ),
    );
  }

//result widget
  Widget result(String textResult) {
    return Text(
      textResult != null ? textResult : 'Null Result',
      style: TextStyle(fontSize: 20.0),
    );
  }

//welcome message widget
  Widget welcome() {
    return Text(
      'Welcome To the App!!',
      style: TextStyle(color: Colors.white),
    );
  }

//error alert box message
Future<void> errorAlert(BuildContext context, String message) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Error Occured'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              final nav = Navigator.of(context);
              nav.pop();
              nav.pop();
            },
          ),
        ],
      );
    },
  );
}
}
