import 'dart:convert';
import 'package:search_app/model/address.dart';
import 'package:http/http.dart' as http;

abstract class DataSource{
  Future<List<Address>?> loadData(String keyword);
}

class MyDataSource implements DataSource{
  @override
  Future<List<Address>?> loadData(String keyword) async{
    var url = 'https://geocode.search.hereapi.com/v1/geocode?q=$keyword&limit=6&apiKey=3DIOGBNcDuUSsViIeS0Ggb3dzXeST8spRIPAmhTmAdI';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if(response.statusCode == 200){
      final body = utf8.decode(response.bodyBytes);
      var responseData = jsonDecode(body) as Map;
      if (responseData['items'] != null) {
        var addressItems = responseData['items'] as List;
        List<Address> addressList = addressItems.map((item) {
          var addressData = item['address'] as Map<String, dynamic>;
          return Address.getAddress(addressData);
        }).toList();
        return addressList;

      }else{
        return [];
      }
    }else{
      return [];
    }
  }

}