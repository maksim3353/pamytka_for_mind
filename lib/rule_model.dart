
class rule {

  final String rule_name;
  final String subject;
  final int class_int;
  final String description;

  const rule({
  
    required this.rule_name,
    required this.subject,
    required this.class_int,
    required this.description,
  });

  factory rule.fromJson(Map<String, dynamic> j) => rule(
      
            
        rule_name: j['rule_name']?.toString() ?? '',
        subject: j['subject']?.toString() ?? '',
        class_int: (j['class_int'] as num?)?.toInt() ?? 0,
        description: j['description']?.toString() ?? '',
      );

  Map<String, dynamic> toJson() => {
        
        'rule_name': rule_name,
        'subject': subject,
        'class_int': class_int,
        'description': description,
      };
}