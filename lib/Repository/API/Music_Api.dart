import 'dart:convert';

import 'package:http/http.dart';
import 'package:music/Repository/API/api_client.dart';

import '../Model_Class/MusicModel.dart';

class MusicAPI{
  ApiClient apiClient=ApiClient();

  Future<MusicModel>getMusic()async{
    String path ='https://jio-saavan-unofficial.p.rapidapi.com/getsong';
    var body = {
      "encrypted_media_url": "ID2ieOjCrwfgWvL5sXl4B1ImC5QfbsDyBlrJGTfFbyAhRCAkx//LGIlozHj/EqcPOiQvaQf6g3CFte9EDf+yEhw7tS9a8Gtq"
    };

    Response response = await apiClient.invokeAPI(path, 'POST', jsonEncode(body));
    return MusicModel.fromJson(jsonDecode(response.body));
  }
}