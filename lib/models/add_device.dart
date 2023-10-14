// To parse this JSON data, do
//
//     final addDeviceModel = addDeviceModelFromJson(jsonString);

import 'dart:convert';

AddDeviceModel addDeviceModelFromJson(String str) => AddDeviceModel.fromJson(json.decode(str));

String addDeviceModelToJson(AddDeviceModel data) => json.encode(data.toJson());

class AddDeviceModel {
    bool active;
    String deviceId;
    String deviceSerialNumber;
    String name;
    String simId;
    String topic;
    String zone;

    AddDeviceModel({
        required this.active,
        required this.deviceId,
        required this.deviceSerialNumber,
        required this.name,
        required this.simId,
        required this.topic,
        required this.zone,
    });

    factory AddDeviceModel.fromJson(Map<String, dynamic> json) => AddDeviceModel(
        active: json["active"],
        deviceId: json["deviceId"],
        deviceSerialNumber: json["deviceSerialNumber"],
        name: json["name"],
        simId: json["simId"],
        topic: json["topic"],
        zone: json["zone"],
    );

    Map<String, dynamic> toJson() => {
        "active": active,
        "deviceId": deviceId,
        "deviceSerialNumber": deviceSerialNumber,
        "name": name,
        "simId": simId,
        "topic": topic,
        "zone": zone,
    };
}
