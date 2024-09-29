class UserModel {
  final String uid;   // Unique ID for the user
  final String email; // User's email address
  final String name; // User's name
  final bool loggedIn;

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.loggedIn,
  });

  // Convert UserModel object to a map (to store in Firestore)
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'loggedIn' : loggedIn,
    };
  }

  // Create a UserModel object from a map (from Firestore)
  factory UserModel.fromMap(Map<String, dynamic>? map) {
    return UserModel(
      uid: map?['uid'],       // Provide default empty values if map data is missing
      email: map?['email'],
      name: map?['name'],
      loggedIn: map?['loggedIn'],
    );
  }
}