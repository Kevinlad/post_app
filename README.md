# knovator_task
Post Application
* Overview
  This Flutter application displays a list of posts fetched from a remote API. Users can view detailed information about each post and mark posts as read. 

* Architectural Choices
  1. State Management
      GetX: Used for state management in this application. GetX is chosen for its simplicity and performance benefits. It allows reactive programming with minimal boilerplate code, making it easier to manage state        and dependencies.
  2. Networking
      HTTP Package: Used for making HTTP requests to fetch posts and post details. It provides a simple API for network operations.
  3. Persistence
      SharedPreferences: Used for persisting the read status of posts. It is a key-value store that allows saving simple data types persistently.
  4. Error Handling
     No Internet Connection: A dialog is displayed if there is no internet connection while fetching posts or post details.

* Third-Party Libraries
  1. GetX: For state management and routing.
  2. HTTP: For making HTTP requests.
  3. SharedPreferences: For local data storage.
    
* Drive Link for video and apk:
https://drive.google.com/drive/folders/105tI5wpOzD7TcQTIzSjhkq1GFmG7hSLh?usp=drive_link
