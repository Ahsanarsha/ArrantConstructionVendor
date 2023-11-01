class ProjectManager {
  String? id;
  String? name;
  String? imageUrl;
  String? email;
  String? contactNumber;

  ProjectManager();

  ProjectManager.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'] != null ? jsonMap['id'].toString() : '';
      name = jsonMap['name'] ?? '';
      imageUrl = jsonMap['profile_url'] ?? '';
      email = jsonMap['email'] ?? '';
      contactNumber = jsonMap['contact_no'] ?? ''; //Change to int
    } catch (e) {
      print("Project Manager Model Error: $e");
    }
  }
}
