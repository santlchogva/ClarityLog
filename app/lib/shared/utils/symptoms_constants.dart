const List<String> kPrimarySymptoms = [
  '难集中',
  '容易忘事',
  '思考变慢',
  '找词困难',
  '精神疲惫',
];

const List<String> kSecondarySymptoms = [
  '疲劳',
  '头痛',
  '睡眠不恢复',
  '活动后加重',
];

const String kFallbackSymptom = '不确定';

const List<String> kAllSymptoms = [
  ...kPrimarySymptoms,
  ...kSecondarySymptoms,
  kFallbackSymptom,
];

const List<String> kSexOptions = ['女性', '男性', '其他', '暂不提供'];

const List<String> kAgeRangeOptions = [
  '18 岁以下',
  '18–24 岁',
  '25–34 岁',
  '35–44 岁',
  '45–54 岁',
  '55–64 岁',
  '65 岁及以上',
  '暂不提供',
];

const List<String> kMealTypes = ['早餐', '午餐', '晚餐', '加餐'];

const List<String> kActivityTypes = [
  '散步',
  '跑步',
  '骑车',
  '游泳',
  '家务',
  '认知活动',
  '其他',
];

const List<String> kFlowLevels = ['未记录', '少', '中', '多'];
const List<String> kPainLevels = ['未记录', '无', '轻', '中', '重'];
const List<String> kPostMealFeelings = ['好', '一般', '差', '不确定'];
