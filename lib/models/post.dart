class Post{

  String id, title, content, dateWritten, featuredImage;
  int votesUp, votesDown;
  List<int> votersUp, votersDown;
  int userId, categoryId;

  Post({required this.id, required this.title, required this.content, required this.dateWritten, required this.featuredImage, required this.votesUp, required this.votesDown, required this.votersUp, required this.votersDown, required this.userId, required this.categoryId});

}