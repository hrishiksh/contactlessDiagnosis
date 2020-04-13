class Reports {
  final String parameter;
  final String value;
  final String imagePath;

  Reports({this.parameter, this.value, this.imagePath});
}

List<Reports> reportList = [
  Reports(
    parameter: 'Fever',
    value: '37 deg',
    imagePath: 'assets/thermo.svg',
  ),
  Reports(
      parameter: 'Blood Pressure',
      value: '68',
      imagePath: 'assets/heartbeat.svg'),
  Reports(
    parameter: 'Cough',
    value: 'No',
    imagePath: 'assets/cough.svg',
  ),
];
