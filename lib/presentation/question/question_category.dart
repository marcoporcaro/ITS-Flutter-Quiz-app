enum QuestionCategory {
  general_knowledge,
  sports,
  animals,
  videogames;

  int getCategoryValue() {
    switch(this) {
      case QuestionCategory.general_knowledge:
        return 9;
      case QuestionCategory.sports:
        return 21;
      case QuestionCategory.animals:
        return 27;
      case QuestionCategory.videogames:
        return 15;
    }
  }

  String getDisplayName() {
    switch(this) {
      case QuestionCategory.general_knowledge:
        return "General Knowledge";
      case QuestionCategory.sports:
        return "Sports";
      case QuestionCategory.animals:
        return "Animals";
      case QuestionCategory.videogames:
        return "Video Games";
    }
  }
}