import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

class SmartwatchScreen extends StatefulWidget {
  @override
  _SmartwatchScreenState createState() => _SmartwatchScreenState();
}

class _SmartwatchScreenState extends State<SmartwatchScreen>
    with TickerProviderStateMixin {
  bool _isConnecting = false;
  bool _isConnected = false;
  double _progress = 0.0;

  // Mock Data for discovered Bluetooth devices
  final List<String> _mockDevices = ["FitBand MI 4", "HealthSync Pro", "SmartTracker X"];
  String _selectedDevice = "";

  // Data retrieved after connection
  int _heartRate = 0;
  String _sleepCycle = '';
  String _stressLevel = '';

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Simulate Bluetooth Discovery Process
  Future<void> _startDeviceDiscovery() async {
    setState(() {
      _isConnecting = true;
      _progress = 0.0;
    });

    for (int i = 0; i <= 20; i++) {
      await Future.delayed(Duration(milliseconds: 100), () {
        setState(() {
          _progress += 0.05;
        });
      });

      if (i == 20) {
        _completeConnection();
      }
    }
  }

  // Complete the connection process
  void _completeConnection() {
    setState(() {
      _isConnecting = false;
      _isConnected = true;
      _selectedDevice = _mockDevices[Random().nextInt(_mockDevices.length)];

      // Generate mock health data
      _heartRate = Random().nextInt(40) + 60; // Heart rate: 60-100 BPM
      _sleepCycle = Random().nextBool() ? "Good" : "Disturbed";
      _stressLevel = Random().nextBool() ? "Low" : "High";
    });

    _animationController.forward(from: 0.0);
  }

  // Disconnect from the smartwatch
  void _disconnect() {
    setState(() {
      _isConnected = false;
      _selectedDevice = "";
      _heartRate = 0;
      _sleepCycle = '';
      _stressLevel = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1E88E5), Color(0xFF42A5F5)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                // Header
                Text(
                  "Smartwatch Connection",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),

                // Main Section
                Expanded(
                  child: _isConnecting
                      ? _buildDeviceDiscoveryUI()
                      : _isConnected
                      ? _buildConnectedUI()
                      : _buildDisconnectedUI(),
                ),

                // Action Button
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _isConnecting
                      ? null
                      : _isConnected
                      ? _disconnect
                      : _startDeviceDiscovery,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isConnecting
                        ? Colors.grey
                        : _isConnected
                        ? Colors.redAccent
                        : Colors.greenAccent,
                    padding: EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    _isConnecting
                        ? "Connecting..."
                        : _isConnected
                        ? "Disconnect"
                        : "Connect",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Device Discovery UI
  Widget _buildDeviceDiscoveryUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(
          value: _progress,
          color: Colors.white,
        ),
        SizedBox(height: 20),
        Text(
          "Searching for nearby devices...",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        SizedBox(height: 10),
        Text(
          "${(_progress * 100).toInt()}% Complete",
          style: TextStyle(color: Colors.white70),
        ),
        SizedBox(height: 20),
        _buildMockDeviceList(),
      ],
    );
  }

  // Connected UI
  Widget _buildConnectedUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ScaleTransition(
          scale: _animationController,
          child: Icon(Icons.watch, color: Colors.white, size: 100),
        ),
        SizedBox(height: 20),
        Text(
          "Connected to $_selectedDevice",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        SizedBox(height: 20),
        _buildDataCard(
          icon: Icons.favorite,
          title: "Heart Rate",
          value: "$_heartRate BPM",
          color: Colors.red,
        ),
        SizedBox(height: 20),
        _buildDataCard(
          icon: Icons.nightlight_round,
          title: "Sleep Cycle",
          value: _sleepCycle,
          color: Colors.blueAccent,
        ),
        SizedBox(height: 20),
        _buildDataCard(
          icon: Icons.self_improvement,
          title: "Stress Level",
          value: _stressLevel,
          color: Colors.orange,
        ),
      ],
    );
  }

  // Disconnected UI
  Widget _buildDisconnectedUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.watch, color: Colors.white, size: 120),
        SizedBox(height: 20),
        Text(
          "No smartwatch connected.",
          style: TextStyle(color: Colors.white70, fontSize: 18),
        ),
        SizedBox(height: 10),
        Text(
          "Tap the button below to connect to your smartwatch.",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white70, fontSize: 16),
        ),
      ],
    );
  }

  // Data Card Widget
  Widget _buildDataCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.2),
              child: Icon(icon, color: color),
            ),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(value, style: TextStyle(fontSize: 14)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Mock Bluetooth Device List
  Widget _buildMockDeviceList() {
    return Column(
      children: _mockDevices
          .map((device) => ListTile(
        leading: Icon(Icons.bluetooth, color: Colors.white),
        title: Text(
          device,
          style: TextStyle(color: Colors.white),
        ),
        trailing: Text(
          "Nearby",
          style: TextStyle(color: Colors.greenAccent),
        ),
      ))
          .toList(),
    );
  }
}
