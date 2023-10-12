class MockApi {
  static Future<Map<String, dynamic>> getStatusData(bool isSwitched) async {
    // Simulate a delay to mimic a network request
    await Future.delayed(Duration(seconds: 2));
    // bool isSwitched = true;
    
    // Mock the response data
    return {
       "powerStatus": isSwitched ? "ON" : "OFF",
      "motorStatus": isSwitched ? "ON" : "OFF",
      "motorSwitch": isSwitched,
    };
  }
}
