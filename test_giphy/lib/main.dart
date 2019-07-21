import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:test_giphy/managers/networking.dart';
import 'package:test_giphy/models/gif.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Search Gif from GIPHY'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var _searchController = TextEditingController();
  var resultString = 'car';

  Future<List<GifFile>> _resultList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onSubmitted: (value) {
                  setState(() {
                    _resultList = NetworkManager().getGifs(value);
                    //print(resultString);
                  });
                  
                },
                controller: _searchController,
                decoration: InputDecoration(
                  labelText: 'Enter your request',
                  hintText: 'eg. car, man, smile',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0))
                  )
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: _resultList,
                builder: (context, snapshot) {
                  print('SNAPSHOT: $snapshot');
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        "Some error occurred",
                        style: TextStyle(fontSize: 16.0, color: Colors.red),
                      )
                      );
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Container(
                          constraints: BoxConstraints.tightFor(width: 0.0, height: 200.0),
                          child: ListTile(
                            contentPadding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                            title: Image.network(
                              snapshot.data[index].url,
                              fit: BoxFit.fitWidth,
                              ),
                          ), 
                        );
                      },
                    );
                  } 
                  
                  else {
                    return Container(color: Colors.white,);//Center(child: CircularProgressIndicator());
                  }
                }
              ),
            )
          ],
        ),
      ),
    );
  }

  
}

