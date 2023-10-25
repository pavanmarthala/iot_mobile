// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditDevice extends StatefulWidget {
  final String deviceId;

  const EditDevice({
    Key? key,
    required this.deviceId,
  }) : super(key: key);

  @override
  _EditDeviceState createState() => _EditDeviceState();
}

class _EditDeviceState extends State<EditDevice> {
  // Define user details with default values
  String name = "N/A";
  String deviceId = "N/A";
  bool powerAvailable = false;
  String topic = "N/A";
  String deviceSerialNumber = "N/A";
  bool deviceState = false;
  String lastDeviceState = "N/A";
  bool givenState = false;
  String lastGivenState = "N/A";
  String zone = "N/A";
  String subscriptionValid = "N/A";
  String device_id = "N/A";
  String IMSI = "N/A";
  String Operator = "N/A";
  String Ip = "N/A";
  String signal_quality = "N/A";
  String location = "N/A";
  String mob_num = "N/A";
  String minVol = "N/A";
  String lastPowerAvailable = "N/A";
  String maxCurrent = "";
  String minCurrent = "N/A";
  String maxVoltage = "N/A";
  String minVoltage = "N/A";
  String deviceLastPing = "N/A";
  String loadLastPing = "N/A";
  String powerLastPing = "N/A";
  String lastPing = "N/A";
  String deviceSleepTime = "N/A";
  String nthMessage = "N/A";
  String simId = "N/A";
  bool active = false;
  bool metaCheckRequired = false;
  bool meta1CheckRequired = false;
  String deviceModel = "N/A";
  String fcmRegistrationTokens = "N/A";
  String modem_info = "N/A";
  String CCID = "N/A";
  String IMEI = "N/A";
  String maxVol = "N/A";
  String minCur = "N/A";
  String maxCur = "N/A";
  List<String> accountIds = [];
  // Controller for the editable text fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController deviceIdController = TextEditingController();
  final TextEditingController powerAvailableController =
      TextEditingController();
  final TextEditingController topicController = TextEditingController();
  final TextEditingController deviceSerialNumberController =
      TextEditingController();
  final TextEditingController deviceStateController = TextEditingController();
  final TextEditingController lastDeviceStateController =
      TextEditingController();
  final TextEditingController givenStateController = TextEditingController();
  final TextEditingController lastGivenStateController =
      TextEditingController();
  final TextEditingController zoneController = TextEditingController();
  final TextEditingController subscriptionValidController =
      TextEditingController();
  final TextEditingController device_idController = TextEditingController();
  final TextEditingController IMSIController = TextEditingController();
  final TextEditingController OperatorController = TextEditingController();
  final TextEditingController IpController = TextEditingController();
  final TextEditingController signal_qualityController =
      TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController mob_numController = TextEditingController();
  final TextEditingController minVolController = TextEditingController();
  final TextEditingController lastPowerAvailableController =
      TextEditingController();
  final TextEditingController maxVoltageController = TextEditingController();
  final TextEditingController maxCurrentController = TextEditingController();
  final TextEditingController minCurrentController = TextEditingController();
  final TextEditingController deviceLastPingController =
      TextEditingController();
  final TextEditingController minVoltageController = TextEditingController();
  final TextEditingController loadLastPingController = TextEditingController();
  final TextEditingController lastPingController = TextEditingController();
  final TextEditingController deviceSleepTimeController =
      TextEditingController();
  final TextEditingController nthMessageController = TextEditingController();
  final TextEditingController simIdController = TextEditingController();
  final TextEditingController activeController = TextEditingController();
  final TextEditingController metaCheckRequiredController =
      TextEditingController();
  final TextEditingController meta1CheckRequiredController =
      TextEditingController();
  final TextEditingController deviceModelController = TextEditingController();
  final TextEditingController fcmRegistrationTokensController =
      TextEditingController();
  final TextEditingController modemInfoController = TextEditingController();
  final TextEditingController CCIDController = TextEditingController();
  final TextEditingController IMEIController = TextEditingController();
  final TextEditingController maxVolController = TextEditingController();
  final TextEditingController minCurController = TextEditingController();
  final TextEditingController maxCurController = TextEditingController();
  final TextEditingController powerLastPingController = TextEditingController();

  bool isEditing = false;
  List<String> editingAccountIds = [];
  @override
  void initState() {
    super.initState();
    // Fetch user details from the API
    fetchUserDetails();
  }

  // Function to fetch user details from the API
  Future<void> fetchUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jwtToken = prefs.getString('jwt_token');

    if (jwtToken == null) {
      // Handle the case where the token is not found
      return;
    }

    final response = await http.get(
      Uri.https('console-api.theja.in', '/admin/getDevice/${widget.deviceId}'),
      headers: {
        "Authorization": "Bearer $jwtToken",
      },
    );

    if (response.statusCode == 200) {
      final userData = json.decode(response.body);

      if (userData != null) {
        name = userData['name'] ?? 'N/A';
        deviceId = userData['deviceId'] ?? 'N/A';
        powerAvailable = userData['powerAvailable'] ?? false;
        topic = userData['topic'] ?? 'N/A';
        deviceSerialNumber = userData['deviceSerialNumber'] ?? 'N/A';
        deviceState = userData['deviceState'] ?? false;
        lastDeviceState = userData['lastDeviceState'] ?? 'N/A';
        givenState = userData['givenState'] ?? false;
        lastGivenState = userData['lastGivenState'] ?? 'N/A';
        zone = userData['zone'] ?? 'N/A';
        subscriptionValid = userData['subscriptionValidity'] ?? 'N/A';
        final meta1 = userData['meta1'] ?? {};
        device_id = meta1.containsKey('device_id') ? meta1['device_id'] : 'N/A';
        IMSI = meta1.containsKey('IMSI') ? meta1['IMSI'] : 'N/A';
        Operator = meta1.containsKey('Operator') ? meta1['Operator'] : 'N/A';
        Ip = meta1.containsKey('Ip') ? meta1['Ip'] : 'N/A';
        signal_quality = meta1.containsKey('signal_quality')
            ? meta1['signal_quality']
            : 'N/A';
        mob_num =
            meta1.containsKey('mob_num') ? meta1['mob_num'].toString() : 'N/A';

        location = meta1.containsKey('location')
            ? meta1['location'].toString()
            : 'N/A';
        minVol =
            meta1.containsKey('minVol') ? meta1['minVol'].toString() : 'N/A';

        maxVol =
            meta1.containsKey('maxVol') ? meta1['maxVol'].toString() : 'N/A';
        minCur =
            meta1.containsKey('minCur') ? meta1['minCur'].toString() : 'N/A';
        maxCur =
            meta1.containsKey('maxCur') ? meta1['maxCur'].toString() : 'N/A';

        lastPowerAvailable = userData['lastPowerAvailable'] ?? 'N/A';
        maxCurrent = userData['maxCurrent']?.toString() ?? 'N/A';
        minCurrent = userData['minCurrent']?.toString() ?? 'N/A';
        maxVoltage = userData['maxVoltage']?.toString() ?? 'N/A';
        minVoltage = userData['minVoltage']?.toString() ?? 'N/A';
        deviceLastPing = userData['deviceLastPing'] ?? 'N/A';
        loadLastPing = userData['loadLastPing'] ?? 'N/A';
        powerLastPing = userData['powerLastPing'] ?? 'N/A';
        lastPing = userData['lastPing'] ?? 'N/A';
        deviceSleepTime = userData['deviceSleepTime']?.toString() ?? 'N/A';
        nthMessage = userData['nthMessage']?.toString() ?? 'N/A';
        simId = userData['simId'] ?? 'N/A';
        active = userData['active'] ?? 'N/A';
        metaCheckRequired = userData['metaCheckRequired'] ?? 'N/A';
        meta1CheckRequired = userData['meta1CheckRequired'] ?? 'N/A';
        deviceModel = userData['deviceModel'] ?? 'N/A';
        fcmRegistrationTokens = userData['fcmRegistrationTokens'] ?? 'N/A';

        final meta = userData['meta'] ?? {};

        modem_info =
            meta.containsKey('modem_info') ? meta['modem_info'] : 'N/A';

        CCID = meta.containsKey('CCID') ? meta['CCID'] : 'N/A';

        IMEI = meta.containsKey('IMEI') ? meta['IMEI'] : 'N/A';
        accountIds = List<String>.from(userData['accountIds']);
      }

      // Initialize the controllers with the fetched user details
      nameController.text = name;
      deviceIdController.text = deviceId;
      powerAvailableController.text = powerAvailable.toString();
      topicController.text = topic;
      deviceSerialNumberController.text = deviceSerialNumber;
      deviceStateController.text = deviceState.toString();
      lastDeviceStateController.text = lastDeviceState;
      givenStateController.text = givenState.toString();
      lastGivenStateController.text = lastGivenState;
      zoneController.text = zone;
      subscriptionValidController.text = subscriptionValid;
      device_idController.text = device_id;
      IMSIController.text = IMSI;
      OperatorController.text = Operator;
      IpController.text = Ip;
      signal_qualityController.text = signal_quality;
      locationController.text = location;
      mob_numController.text = mob_num;
      minVolController.text = minVol;
      lastPowerAvailableController.text = lastPowerAvailable;
      maxCurrentController.text = maxCurrent.toString();
      minCurrentController.text = minCurrent.toString();
      maxVoltageController.text = maxVoltage.toString();
      minVoltageController.text = minVoltage.toString();
      deviceLastPingController.text = deviceLastPing;
      loadLastPingController.text = loadLastPing;
      powerLastPingController.text = powerLastPing;
      lastPingController.text = lastPing;
      deviceSleepTimeController.text = deviceSleepTime;
      nthMessageController.text = nthMessage.toString();
      simIdController.text = simId;
      activeController.text = active.toString();
      metaCheckRequiredController.text = metaCheckRequired.toString();
      meta1CheckRequiredController.text = meta1CheckRequired.toString();
      deviceModelController.text = deviceModel;
      fcmRegistrationTokensController.text = fcmRegistrationTokens;
      modemInfoController.text = modem_info;
      CCIDController.text = CCID;
      IMEIController.text = IMEI;
      maxVolController.text = maxVol.toString();
      minCurController.text = minCur.toString();
      maxCurController.text = maxCur.toString();

      setState(() {
        // Update your state variables and controllers as needed
      });
    } else {
      // Handle the error when the API request fails
      print('Failed to fetch user details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffcbcbcb),
      appBar: AppBar(
        title: Text('Device Details'),
        actions: [
          isEditing
              ? IconButton(
                  icon: Icon(Icons.save),
                  onPressed: () {
                    // Save the edited user details here
                    setState(() {
                      name = nameController.text;
                      powerAvailable = powerAvailableController.text == 'true';
                      deviceId = deviceIdController.text;
                      topic = topicController.text;
                      deviceSerialNumber = deviceSerialNumberController.text;
                      deviceState = deviceStateController.text == 'true';
                      lastDeviceState = lastDeviceStateController.text;
                      givenState = givenStateController.text == 'true';
                      lastGivenState = lastGivenStateController.text;
                      zone = zoneController.text;
                      subscriptionValid = subscriptionValidController.text;
                      device_id = device_idController.text;
                      IMSI = IMSIController.text;
                      Operator = OperatorController.text;
                      Ip = IpController.text;
                      signal_quality = signal_qualityController.text;
                      location = locationController.text;
                      mob_num = mob_numController.text;
                      minVol = minVolController.text;
                      lastPowerAvailable = lastPowerAvailableController.text;
                      maxCurrent = maxCurrentController.text;
                      minCurrent = minCurrentController.text;
                      maxVoltage = maxVoltageController.text;
                      minVoltage = minVoltageController.text;
                      deviceLastPing = deviceLastPingController.text;
                      loadLastPing = loadLastPingController.text;
                      powerLastPing = powerLastPingController.text;
                      lastPing = lastPingController.text;
                      deviceSleepTime = deviceSleepTimeController.text;
                      nthMessage = nthMessageController.text;
                      simId = simIdController.text;
                      active = activeController.text == 'true';
                      metaCheckRequired =
                          metaCheckRequiredController.text == 'true';
                      meta1CheckRequired =
                          meta1CheckRequiredController.text == 'true';
                      deviceModel = deviceModelController.text;
                      fcmRegistrationTokens =
                          fcmRegistrationTokensController.text;
                      modem_info = modemInfoController.text;
                      CCID = CCIDController.text;
                      IMEI = IMEIController.text;
                      maxVol = maxVolController.text;
                      minCur = minCurController.text;
                      maxCur = maxCurController.text;
                      accountIds = editingAccountIds;
                      isEditing = false;
                    });
                  },
                )
              : IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    setState(() {
                      isEditing = true;
                      editingAccountIds = List.from(accountIds);
                    });
                  },
                ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            _UserDetail("deviceId", deviceIdController, false),
            _buildUserDetail(
                "device Serial Number", deviceSerialNumberController, true),
            _buildUserDetail("Name", nameController, true),
            _buildUserDetail("Zone", zoneController, true),
            _UserDetail("deviceState", deviceStateController, false),
            _UserDetail("lastDeviceState", lastDeviceStateController, false),
            _UserDetail("givenState", givenStateController, false),
            _UserDetail("lastGivenState", lastGivenStateController, false),
            _UserDetail("power Available", powerAvailableController, false),
            _UserDetail("topic", topicController, false),
            // Display the accountIds as a list of text fields
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                height: 150,
                width: 380,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.black, // Border color
                    width: 1.0, // Border width
                    style: BorderStyle
                        .solid, // Border style (you can use dotted or dashed too)
                  ),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Text(
                        'Account IDs',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Wrap(
                          children: <Widget>[
                            for (int i = 0; i < accountIds.length; i++)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    width: 160,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Colors.black, // Border color
                                        width: 1.0, // Border width
                                        style: BorderStyle
                                            .solid, // Border style (you can use dotted or dashed too)
                                      ),
                                    ),
                                    child: Center(child: Text(accountIds[i]))),
                              ),

                            // Display the editing accountIds
                            if (isEditing)
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: <Widget>[
                                    for (int i = 0;
                                        i < editingAccountIds.length;
                                        i++)
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: TextField(
                                              controller: TextEditingController(
                                                  text: editingAccountIds[i]),
                                              onChanged: (value) {
                                                // Update the editingAccountIds list
                                                editingAccountIds[i] = value;
                                              },
                                            ),
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.delete),
                                            onPressed: () {
                                              setState(() {
                                                editingAccountIds.removeAt(i);
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          editingAccountIds.add("");
                                        });
                                      },
                                      child: Text("Add"),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            _buildUserDetail(
                "Subscription Valid", subscriptionValidController, false),
            _UserDetail(
                "lastPowerAvailable", lastPowerAvailableController, false),
            _UserDetail("maxCurrent", maxCurrentController, false),
            _UserDetail("minCurrent", minCurrentController, false),
            _UserDetail("maxVoltage", maxVoltageController, false),
            _UserDetail("minVoltage", minVoltageController, false),
            _UserDetail("deviceLastPing", deviceLastPingController, false),
            _UserDetail("loadLastPing", loadLastPingController, false),
            _UserDetail("powerLastPing", powerLastPingController, false),
            _UserDetail("lastPing", lastPingController, false),
            _UserDetail("deviceSleepTime", deviceSleepTimeController, false),
            _UserDetail("nthMessage", nthMessageController, false),
            _UserDetail("simId", simIdController, false),
            _UserDetail("active", activeController, false),
            _UserDetail(
                "metaCheckRequired", metaCheckRequiredController, false),
            _UserDetail(
                "meta1CheckRequired", meta1CheckRequiredController, false),
            _UserDetail("deviceModel", deviceModelController, false),
            _UserDetail("fcmRegistrationTokens",
                fcmRegistrationTokensController, false),
            _UserDetail("modem_info", modemInfoController, false),
            _UserDetail("CCID", CCIDController, false),
            _UserDetail("IMEI", IMEIController, false),
            Padding(
              padding: const EdgeInsets.only(
                  left: 10, top: 10, right: 10, bottom: 20),
              child: Container(
                height: 407,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.black, // Border color
                    width: 1.0, // Border width
                    style: BorderStyle.solid, // Border style
                  ),
                ),
                child: ListView(
                  children: [
                    Center(
                      child: Text(
                        'meta1',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                    _UserDetail("device Id", device_idController, false),
                    _UserDetail("IMSI", IMSIController, false),
                    _UserDetail("Operator", OperatorController, false),
                    _UserDetail("IP", IpController, false),
                    _UserDetail(
                        "signal quality", signal_qualityController, false),
                    _UserDetail("location", locationController, false),
                    _UserDetail("Mobile Number", mob_numController, false),
                    _UserDetail("minVol ", minVolController, false),
                    _UserDetail("maxVol", maxVolController, false),
                    _UserDetail("minCur", minCurController, false),
                    _UserDetail("maxCur", maxCurController, false),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 10, top: 10, right: 10, bottom: 20),
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.black, // Border color
                    width: 1.0, // Border width
                    style: BorderStyle.solid, // Border style
                  ),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(children: [
                    Center(
                      child: Text(
                        'meta',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                    _UserDetail("device Id", device_idController, false),
                    _UserDetail("modem_info", modemInfoController, false),
                    _UserDetail("CCID", CCIDController, false),
                    _UserDetail("IMEI", IMEIController, false),
                  ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserDetail(
      String label, TextEditingController controller, bool editable) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 15, right: 10),
      child: Container(
        width: 380,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.black, // Border color
            width: 1.0, // Border width
            style: BorderStyle.solid, // Border style
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              isEditing
                  ? TextField(
                      controller: controller,
                    )
                  : Text(
                      controller.text,
                      style: TextStyle(fontSize: 16.0),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _UserDetail(
      String label, TextEditingController controller, bool editable) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 15, right: 10),
      child: Container(
        width: 380,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.black, // Border color
            width: 1.0, // Border width
            style: BorderStyle.solid, // Border style
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              editable
                  ? TextField(
                      controller: controller,
                    )
                  : Text(
                      controller.text,
                      style: TextStyle(fontSize: 16.0),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
