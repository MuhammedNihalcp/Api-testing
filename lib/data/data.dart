// import 'dart:developer';
import 'package:api_integration/data/chat_model/user_all_list_model.dart';
import 'package:api_integration/data/url.dart';
import 'package:dio/dio.dart';
 
abstract class ApiCalls{
  Future<UserAllList?> getAllChat();
}

class ChatDB implements ApiCalls{
  final dio = Dio();
  final url = Url();
  @override
  Future<UserAllList?> getAllChat()async {
    try{
      //  print('entered');
    Response response = await dio.get(url.baseUri+url.getAddress);
    if(response.statusCode! >=200||response.statusCode! <=299){
      // log(response.data.toString());
      return UserAllList.fromJson(response.data);
    }else{
      return UserAllList(message: 'Give the error message from API');
    }
    }catch(e){
      if(e is DioError){
        if(e.response?.data == null){
          return UserAllList(message: 'Something worng!');
        }else{
          return UserAllList(message: e.response!.data['message']);
        }
      }else{
        return UserAllList(message: e.toString());
      }
    }
  
  }
}
