import 'package:get/get_connect/connect.dart';

class ApiProvider extends GetConnect {

  Future<Map> getStatus(ip) async {
    final response = await get(
        'http://' + ip + ':5000/status');
    var data = response.body["data"];
    if (response.status.hasError) {
      return Future.error("error");
    } else {
      print(data);
      return {
          'ip': ip,
          'beneficiarySet': data["beneficiarySet"],
          'ports': data["ports"],
          'serviceRunning': data["serviceRunning"],
          'syncState': data["syncState"],
          'walletPresent': data["walletPresent"]
      };
    }
  }

  Future<Map> getWallet(ip) async {
    final response = await get(
        'http://' + ip + ':5000/wallet');

    var data = response.body["data"];

    if (response.status.hasError) {
      return Future.error("error");
    } else {
      return {
        'address' : data != null ? data['address'] : null,
        'publicKey' : data != null ? data['publicKey'] : null
      };
    }
  }

  Future<Map> createWallet(ip, password) async {
    final form = FormData({
      'password' : password
    });
    final response = await post(
        'http://' + ip + ':5000/wallet',form);

    var data = response.body["data"];

    if (response.status.hasError) {
      return Future.error("error");
    } else {
      return {
          'address' : data['address'],
          'publicKey' : data['publicKey']
      };

    }
  }

  Future<Map> setConfig(ip, key, value) async {
    final form = FormData({
        'key' : key,
        'value' : value,
    });

    final response = await post(
        'http://' + ip + ':5000/config',form);

    var data = response.body["data"];

    if (response.status.hasError) {
      return Future.error("error");
    } else {
      return {
        key : data[key]
      };
    }
  }

  Future<Map> getConfig(ip) async {
    final response = await get(
        'http://' + ip + ':5000/config');

    var data = response.body["data"];

    if (response.status.hasError) {
      return Future.error("error");
    } else {
      return {
        'BeneficiaryAddr' : data != null ? data['BeneficiaryAddr'] : null,
      };
    }
  }

}