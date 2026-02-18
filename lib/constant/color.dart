import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFFE2725B);
const Color backgroundColor = Color(0xFFF9F7EF);

const Color textBrown = Color(0xFF3D1E12);
const Color textDeepGrey = Color(0xFF2D2D2D);
const Color textGrey = Color(0xFF6B7280);

const Color secondaryColor = Color(0xFFC4C2B8);

const Color disabledButtonColor = Color(0xFFC7C8C2);


const Color pink = Color(0xFFFDEEE9);
const Color onPink = Color(0xFFE57373);


/*
1. 상태를 알리는 '신호등 컬러' (Functional Colors)
예산 관리 앱에서는 현재 상태가 '안전'한지 '위험'한지 직관적으로 보여줘야 합니다.

Success (안전/절약): #10B981 (Emerald Green). "이번 주 예산을 잘 지키고 있어요!" 같은 긍정적인 메시지나 프로그레스 바가 안정권일 때 사용합니다.

Warning (주의): #F59E0B (Amber). 예산의 70~80%를 넘겼을 때 주의를 주는 용도입니다. 테라코타와 톤이 비슷하면서도 확실히 구분됩니다.

Danger (초과/위험): #EF4444 (Soft Red). 목표 예산을 초과했을 때 사용합니다.

2. 깊이감을 주는 '뉴트럴 톤' (Neutral Tones)
크림색 배경 위에서 글씨를 쓰거나 경계선을 만들 때 필요합니다.

Text Primary: #374151 (Dark Gray). 순수한 검정색보다는 아주 짙은 회색을 써야 테라코타/크림과 만났을 때 눈이 편안합니다.

Text Secondary: #9CA3AF (Medium Gray). 날짜나 "아빠가 결제함" 같은 부가 정보를 적을 때 사용합니다.

Border/Divider: #E5E7EB (Light Gray). 카드 사이의 구분선이나 입력창 테두리에 쓰입니다.

3. 카테고리 구분을 위한 '뮤트 톤' (Muted Accents)
식비 안에서도 '식재료 마트'와 '외식'을 구분할 때 테라코타 하나만 쓰면 심심할 수 있어요.

Groceries: #8DA47E (Muted Sage). 채소나 신선 식품을 연상시키는 차분한 초록색입니다.

Eating Out: #D4A373 (Dusty Sand). 테라코타보다 연한 베이지 톤으로 외식 카테고리에 잘 어울립니다.


1. 주요 타이틀 및 텍스트 색상
Deep Espresso/Charcoal (#3D1E12 또는 #2D2D2D): 'Better spending, together.', 'MealTrack' 같은 굵은 타이틀과 핵심 숫자에 쓰인 색입니다. 완전한 검정(Pure Black)이 아닌 아주 짙은 갈색 톤이라 따뜻한 느낌을 유지해 줍니다.

Muted Slate/Gray (#6B7280): 'Manage your shared expenses...' 같은 본문 설명 글씨나 날짜 정보에 쓰인 색입니다. 시선이 분산되지 않도록 부드러운 회색조를 띄고 있어요.

2. 하단 내비게이션 및 보조 텍스트
Terracotta Accent (#E2725B): 'Home', 'History' 등 선택된 탭 아이콘이나 버튼 텍스트에 쓰여 통일감을 줍니다.

Soft Gray (#9CA3AF): 비활성화된 탭 메뉴나 덜 중요한 정보들에 쓰이는 연한 회색입니다.
*/