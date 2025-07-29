class Urls{
  static const String _baseUrl="http://35.73.30.144:2005/api/v1";

  static const String registrationUrl="$_baseUrl/Registration";
  static const String loginUrl="$_baseUrl/Login";
  static const String createNewTaskUrl="$_baseUrl/createTask";
  static const String getNewTaskListUrl="$_baseUrl/listTaskByStatus/New";
  static const String getCompletedTaskListUrl="$_baseUrl/listTaskByStatus/Completed";
  static const String getCancelledTaskListUrl="$_baseUrl/listTaskByStatus/Cancelled";
  static const String getProgressTaskListUrl="$_baseUrl/listTaskByStatus/Progress";
  static const String getTaskStatusCountListUrl="$_baseUrl/taskStatusCount";
  static String editTaskStatusUrl(String taskId,String statusId)=>"$_baseUrl/updateTaskStatus/$taskId/$statusId";

}