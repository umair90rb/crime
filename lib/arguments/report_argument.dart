class ReportArgument{
  final String uid;
  final String userName;
  final String userAvatar;
  final String incidentType;
  final String incidentLocation;
  final double incidentLong;
  final double incidentLat;
  final String incidentDate;
  final String incidentTime;
  final String incidentDetails;
  final String incidentVisuals;
  final String incidentVoices;
  final String status;
  final int views;
  final String reportingUserLocation;
  final String reportingTime;
  final String reportingDate;


  ReportArgument({this.uid, this.userName, this.userAvatar, this.incidentType, this.incidentLocation, this.incidentLong, this.incidentLat,
    this.incidentDate, this.incidentTime, this.incidentDetails, this.incidentVisuals, this.incidentVoices,
    this.status,
    this.views,
    this.reportingUserLocation,
    this.reportingTime,
    this.reportingDate
  });
}