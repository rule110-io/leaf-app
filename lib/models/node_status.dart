import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NodeStatus {
  String ip;
  bool beneficiarySet;
  Map ports;
  bool serviceRunning;
  String syncState;
  bool walletPresent;
  String? address;
  String? publicKey;
  String? beneficiaryAddr;

  Map<String, Color> colors = {
    "ONLINE" : Colors.green,
    "OFFLINE" : Colors.red,
    "NEEDS_INITIALIZATION" : Colors.white,
    "NEEDS_GENERATE_ID" : Colors.yellow
  };

  Map<String, String> statuses = {
    "ONLINE" : "Online",
    "OFFLINE" : "Offline",
    "NEEDS_INITIALIZATION" : "Not Configured",
    "NEEDS_GENERATE_ID" : "ID generation needed"
  };

  NodeStatus({
    required this.ip,
    required this.beneficiarySet,
    required this.ports,
    required this.serviceRunning,
    required this.syncState,
    required this.walletPresent,
    this.address,
    this.publicKey,
    this.beneficiaryAddr,
  });

  Color? statusColor (){
    return colors[syncState];
  }

  String? statusString (){
    return statuses[syncState];
  }


  Map<String, dynamic> toMap() {
    return {
      'ip' : ip,
      'beneficiarySet': beneficiarySet,
      'ports': ports,
      'serviceRunning' : serviceRunning,
      'syncState' : syncState,
      'walletPresent' : walletPresent
    };
  }
}
