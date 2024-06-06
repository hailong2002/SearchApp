import 'package:search_app/source/source.dart';

import '../model/address.dart';

abstract class Repository{
  Future<List<Address>?> loadData(String keyword);
}

class MyRepository implements Repository{

  final MyDataSource source = MyDataSource();

  @override
  Future<List<Address>?> loadData(String keyword) async{
    List<Address> addressList = [];
    await source.loadData(keyword).then((address) => addressList.addAll(address!));
    return addressList;
  }

}

