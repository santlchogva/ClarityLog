class Evidence {
  final String id;
  final String title;
  final String summary;
  final String detail;
  final String rationale;
  final String type; // 指南建议 / 系统综述 / 单项研究 / 个人记录观察
  final String scope;
  final String limitations;
  final String sourceUrl;
  final String sourceName;
  final String reviewDate;
  final bool pemRelevant; // If true, only show when PEM is NOT flagged

  const Evidence({
    required this.id,
    required this.title,
    required this.summary,
    required this.detail,
    required this.rationale,
    required this.type,
    required this.scope,
    required this.limitations,
    required this.sourceUrl,
    required this.sourceName,
    required this.reviewDate,
    this.pemRelevant = false,
  });
}

const List<Evidence> kEvidenceList = [
  Evidence(
    id: 'pem_activity',
    title: '留意活动后的变化',
    summary: '先观察自己的耐受情况',
    detail:
        '若活动后状态明显加重，记录活动内容和随后两天的变化，并与专业人员讨论。不要根据这条建议自行增加或减少活动量。',
    rationale:
        'CDC 在长新冠临床指导中指出，活动后不适（PEM）可能延迟 12–48 小时出现，需要个体化评估。',
    type: '指南建议',
    scope: '长新冠相关活动后不适。不是对所有脑雾人群的通用运动处方；不代表你已被诊断为长新冠。',
    limitations: '本建议来自长新冠相关指导，不适用于所有脑雾原因；具体活动方案需与专业人员制定。',
    sourceUrl:
        'https://www.cdc.gov/long-covid/hcp/clinical-guidance/index.html',
    sourceName: 'CDC · Long COVID Clinical Guidance',
    reviewDate: '2026-11-14',
    pemRelevant: true,
  ),
  Evidence(
    id: 'sleep_consistency',
    title: '保持规律的睡眠时间',
    summary: '固定的起床和入睡时间有助于睡眠质量',
    detail:
        '尝试每天同一时间起床，即使前一晚没睡好。规律的睡眠节律比延长卧床时间更有助于改善睡眠恢复感。',
    rationale:
        '睡眠节律紊乱与认知功能下降有关联；规律作息是改善睡眠质量的基础行为干预之一。',
    type: '指南建议',
    scope: '有睡眠不规律困扰的成年人；不适用于存在器质性睡眠障碍者，建议先咨询医生。',
    limitations: '个体差异较大；改变睡眠习惯需要时间，效果因人而异。',
    sourceUrl: 'https://www.sleepfoundation.org/sleep-hygiene',
    sourceName: 'Sleep Foundation · Sleep Hygiene',
    reviewDate: '2026-11-14',
  ),
  Evidence(
    id: 'water_intake',
    title: '注意日常饮水',
    summary: '轻度脱水可能影响注意力和清晰度',
    detail:
        '尝试留意每天的饮水量。轻度脱水（即感到口渴之前）可能影响短期记忆和注意力集中。不需要刻意记录精确毫升数。',
    rationale:
        '多项研究表明，轻度脱水（体重 1–2% 的水分丢失）可影响认知表现，包括注意力和工作记忆。',
    type: '单项研究',
    scope: '成年人日常认知表现；非针对严重脱水或特定疾病状态。',
    limitations:
        '证据来自实验室条件下的短期研究；日常生活中的影响程度因人而异；饮水量不是认知困难的唯一因素。',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/22190027/',
    sourceName: 'Physiology & Behavior · Mild Dehydration and Cognition',
    reviewDate: '2026-11-14',
  ),
  Evidence(
    id: 'b12_check',
    title: '维生素 B12 与认知',
    summary: '长期 B12 摄入不足可能与认知困难有关',
    detail:
        '若你长期以植物性饮食为主，或年龄较大，可以与医生讨论是否需要评估 B12 水平。不建议自行开始补充剂疗程。',
    rationale:
        'NICE NG239 将认知困难列为 B12 缺乏的可能表现之一，但症状不具有特异性，需通过血液检测确认。',
    type: '指南建议',
    scope: '有 B12 缺乏风险的人群（素食者、老年人、胃肠道吸收障碍者）；不适用于所有脑雾人群。',
    limitations:
        '认知症状不能单独诊断 B12 缺乏；确诊需要血液检测；补剂剂量须由医生指导。',
    sourceUrl: 'https://www.nice.org.uk/guidance/ng239',
    sourceName: 'NICE NG239 · Vitamin B12 Deficiency',
    reviewDate: '2026-11-14',
  ),
  Evidence(
    id: 'stress_awareness',
    title: '留意压力与清晰度的关系',
    summary: '持续高压可能加剧脑雾感受',
    detail:
        '尝试在记录中注明压力较高的日子，观察压力与你的清晰度是否有个人关联。这是观察工具，不是压力管理处方。',
    rationale:
        '长期心理压力与认知表现下降有关联；观察个人模式有助于识别可调整的生活因素。',
    type: '个人记录观察',
    scope: '适合任何想了解压力与状态关系的人；观察结果仅代表个人规律，不能作为诊断依据。',
    limitations: '压力自评主观性强；关联不代表因果；影响清晰度的因素很多。',
    sourceUrl:
        'https://www.apa.org/topics/stress/body',
    sourceName: 'APA · Stress Effects on the Body',
    reviewDate: '2026-11-14',
  ),
  Evidence(
    id: 'diet_variety',
    title: '饮食多样性与大脑健康',
    summary: '富含蔬菜、鱼类和全谷物的饮食模式与认知健康有正向关联',
    detail:
        '不需要严格执行某种饮食方案。先从记录自己实际吃了什么开始，观察饮食结构的规律。过度限制饮食本身也可能带来压力。',
    rationale:
        '地中海饮食等饮食模式与认知健康的正向关联在多项观察性研究中有报道，但因果关系尚未完全确立。',
    type: '系统综述',
    scope: '成年人长期饮食模式；不适用于有特定医疗饮食需求的人群。',
    limitations: '多数证据来自观察性研究，存在混杂因素；个体差异和整体生活方式影响结果。',
    sourceUrl: 'https://pubmed.ncbi.nlm.nih.gov/28914264/',
    sourceName: 'Nutrients · Mediterranean Diet and Cognitive Function',
    reviewDate: '2026-11-14',
  ),
  Evidence(
    id: 'menstrual_cognitive',
    title: '月经周期与认知感受',
    summary: '部分人在经期前后有清晰度变化，但个体差异很大',
    detail:
        '如果你发现某些周期阶段脑雾感受更明显，可以记录下来观察个人规律。研究显示，客观认知测试结果与主观脑雾感受并不总是一致。',
    rationale:
        'PLOS ONE 2025 元分析（DOI: 10.1371/journal.pone.0318576）显示，现有综合研究不支持预设所有女性经期客观认知能力下降。',
    type: '系统综述',
    scope: '有月经周期的人；仅适用于主观感受观察，不用于诊断或预测认知能力。',
    limitations: '客观测验与主观脑雾是不同结局；个人经历差异极大；不应据此预设经期认知必然下降。',
    sourceUrl:
        'https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0318576',
    sourceName: 'PLOS ONE · Menstrual Cycle Effects on Cognitive Performance',
    reviewDate: '2026-11-14',
  ),
  Evidence(
    id: 'seek_care',
    title: '何时应该寻求专业帮助',
    summary: '持续或加重的认知困难应与医生讨论',
    detail:
        '如果脑雾症状持续超过几周、明显影响日常生活或工作，或伴随其他新发症状，建议与医生讨论评估。这条建议不针对紧急情况——突发严重认知变化应立即就医。',
    rationale:
        '脑雾可能由多种原因引起，包括但不限于睡眠障碍、甲状腺问题、贫血、感染后症状等，部分原因可通过医疗评估识别和处理。',
    type: '指南建议',
    scope: '所有经历持续脑雾困扰的人；无论年龄、性别和既往健康状况。',
    limitations: '本建议不能替代实际就诊；不同地区医疗资源和诊断流程有差异。',
    sourceUrl:
        'https://www.cdc.gov/long-covid/hcp/clinical-guidance/index.html',
    sourceName: 'CDC · Long COVID Clinical Guidance',
    reviewDate: '2026-11-14',
  ),
];

Evidence? findEvidence(String id) {
  try {
    return kEvidenceList.firstWhere((e) => e.id == id);
  } catch (_) {
    return null;
  }
}
