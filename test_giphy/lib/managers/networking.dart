import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:test_giphy/models/gif.dart';

class NetworkManager {

  Future<List<GifFile>> getGifs(String searchTerm) async {

    List<GifFile> gifs = [];
    
    final _apiKey = 'PBtMCauAksBzHMdKa5bhHaoogzxaLbnu';
    final _maxObjectsToReturn = 2147483647;

    var url =
        "https://api.giphy.com/v1/gifs/search?api_key=$_apiKey&q=$searchTerm&limit=$_maxObjectsToReturn";
    
    var response = await http.get(url);
    if (response.statusCode == 200) {

      
      var jsonResponse = convert.jsonDecode(response.body);

      for (var item in jsonResponse['data']) {

        var url = item['images']['original_still']['url'];

        gifs.add(
            GifFile(url)
            );
            print(url);
      }
    } else {
      print("Request failed with status: ${response.statusCode}.");
    }

    return gifs;
  }
}
