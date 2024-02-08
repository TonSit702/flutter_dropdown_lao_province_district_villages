import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Select Address',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple),
      ),
      home: DropdownWidget(),
    );
  }
}

class DropdownWidget extends StatefulWidget {
  @override
  _DropdownWidgetState createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  List<dynamic> _provinces = [];
  String? _selectedProvince;
  List<dynamic> _districts = [];
  String? _selectedDistrict;
  List<dynamic> _villages = [];
  String? _selectedVillage;

  @override
  void initState() {
    super.initState();
    _fetchProvinceData();
  }

  Future<void> _fetchProvinceData() async {
    try {
      Response response =
          await Dio().get('http://192.168.100.1:3000/get_province_data/');
      setState(() {
        _provinces = response.data;
      });
    } catch (error) {
      // Handle error
      print('Error fetching province data: $error');
    }
  }

  Future<void> _fetchDistrictData(String prId) async {
    try {
      Response response = await Dio()
          .get('http://192.168.100.1:3000/get_district_data/?pr_id=$prId');
      setState(() {
        _districts = response.data;
      });
    } catch (error) {
      // Handle error
      print('Error fetching district data: $error');
    }
  }

  Future<void> _fetchVillageData(String drId) async {
    try {
      Response response = await Dio()
          .get('http://192.168.100.1:3000/get_village_data/?dr_id=$drId');
      setState(() {
        _villages = response.data;
      });
    } catch (error) {
      // Handle error
      print('Error fetching village data: $error');
    }
  }

  void _printSelectedData() {
    String provinceName = '';
    String districtName = '';
    String villageName = '';

    // Find the selected province name
    if (_selectedProvince != null) {
      for (var province in _provinces) {
        if (province['pr_id'].toString() == _selectedProvince) {
          provinceName = province['pr_name'];
          break;
        }
      }
    }

    // Find the selected district name
    if (_selectedDistrict != null) {
      for (var district in _districts) {
        if (district['dr_id'].toString() == _selectedDistrict) {
          districtName = district['dr_name'];
          break;
        }
      }
    }

    // Find the selected village name
    if (_selectedVillage != null) {
      for (var village in _villages) {
        if (village['vill_id'].toString() == _selectedVillage) {
          villageName = village['vill_name'];
          break;
        }
      }
    }

    // Print the selected names
    if (provinceName.isNotEmpty &&
        districtName.isNotEmpty &&
        villageName.isNotEmpty) {
      print('Selected data: $provinceName, $districtName, $villageName');
    } else {
      print('Please select all dropdowns first.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Address'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButtonFormField<String>(
              value: _selectedProvince,
              onChanged: (newValue) {
                setState(() {
                  _selectedProvince = newValue;
                  _selectedDistrict = null; // Reset district selection
                  _selectedVillage = null; // Reset village selection
                  // Fetch districts for the selected province
                  _fetchDistrictData(newValue!);
                });
              },
              items: _provinces.map<DropdownMenuItem<String>>((province) {
                return DropdownMenuItem<String>(
                  value: province['pr_id'].toString(),
                  child: Text(province['pr_name']),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'Select Province',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButtonFormField<String>(
              value: _selectedDistrict,
              onChanged: (newValue) {
                setState(() {
                  _selectedDistrict = newValue;
                  _selectedVillage = null; // Reset village selection
                  // Fetch villages for the selected district
                  _fetchVillageData(newValue!);
                });
              },
              items: _districts.map<DropdownMenuItem<String>>((district) {
                return DropdownMenuItem<String>(
                  value: district['dr_id'].toString(),
                  child: Text(district['dr_name']),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'Select District',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButtonFormField<String>(
              value: _selectedVillage,
              onChanged: (newValue) {
                setState(() {
                  _selectedVillage = newValue;
                  print('Selected Village: $_selectedVillage');
                });
              },
              items: _villages.map<DropdownMenuItem<String>>((village) {
                return DropdownMenuItem<String>(
                  value: village['vill_id'].toString(),
                  child: Text(village['vill_name']),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'Select Village',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _printSelectedData,
              child: Text('Print Selected Data'),
            ),
          ),
        ],
      ),
    );
  }
}
