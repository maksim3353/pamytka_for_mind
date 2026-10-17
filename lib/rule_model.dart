class rule {
  int class_int = 0;
  String subject = "subject";
  String rule_name = "name";
  String description = "description";

  rule({
    required this.description,
    required this.class_int,
    required this.rule_name,
    required this.subject,
  });

  factory rule.fromJson(Map<String, dynamic> json) {
    return rule(
      description: json["description"],
      class_int: json["class_int"],
      rule_name: json["rule_name"],
      subject: json["subject"],
    );
  }
    Map<String, dynamic> toJson() => {
        
        'rule_name': rule_name,
        'subject': subject,
        'class_int': class_int,
        'description': description,
      };
}
