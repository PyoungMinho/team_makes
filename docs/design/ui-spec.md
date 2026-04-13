# UI 디자인 스펙 — 반려동물 건강 안심 플랫폼

> 작성: UI 디자이너 / 2026-04-13
> 기반 문서: 프로젝트 방향서(2026-04-11), 기획 최종안
> 기술 스택: React Native (Expo) + Nativewind v4 (Tailwind 기반)
> 적용 범위: iOS 우선, Android Phase 1 확장 / 라이트·다크모드 동시 설계

---

## 1. 브랜딩 & 톤앤매너

### 브랜드 포지셔닝

"응급 상황에서도 흔들리지 않는 조용한 안심"

보호자는 반려동물이 아플 때 극도로 불안하다. 이 앱은 그 불안을 증폭시키는 것이 아니라 차분하게 잡아주는 역할을 해야 한다. 의료 데이터를 다루는 앱이지만, 차가운 병원 느낌이 아닌 "신뢰할 수 있는 이웃 수의사"의 온기를 가져야 한다.

### 브랜드 키워드

- 신뢰 (Trust): 의료 데이터를 맡길 수 있다는 확신
- 안심 (Reassurance): 응급 상황에서 패닉하지 않도록 돕는 차분함
- 온기 (Warmth): 반려동물과 보호자의 정서적 유대 반영
- 명료함 (Clarity): 위기 상황에서 정보를 빠르게 파악할 수 있는 명확함

### 시각적 성격

| 속성 | 방향 |
|---|---|
| 전체 톤 | 소프트하되 의료적 신뢰감 유지 |
| 모서리 | 둥근 모서리 (radius 12~20px) — 딱딱하지 않은 친근함 |
| 그림자 | 얕은 소프트 섀도 — 플랫 + 레이어 구분 |
| 일러스트 | 미니멀 라인 아이콘 + 포인트 필 컬러 |
| 사진 | 원형 크롭 펫 사진 (프로필), 그리드형 (갤러리) |
| 애니메이션 | 빠르고 의도적인 마이크로인터랙션 (200~300ms) |

---

## 2. 컬러 시스템

### 설계 원칙

- Primary는 신뢰/안심을 상징하는 **Teal-Blue** 계열로 설정
- Accent는 반려동물의 따뜻한 감성을 반영하는 **Warm Amber**
- 응급 탭의 긴장감을 위해 Error/Warning 컬러는 채도를 높게 유지
- 다크모드에서도 모든 Semantic 컬러의 WCAG AA 기준 (대비비 4.5:1 이상) 충족

### 2-1. Primary 컬러

```
Brand Teal

Light mode:
  primary-50:  #f0fdfa  — 배경 틴트, 선택 상태 배경
  primary-100: #ccfbf1  — 카드 호버 배경
  primary-200: #99f6e4  — 체크박스 배경
  primary-300: #5eead4  — 비활성 아이콘
  primary-400: #2dd4bf  — 보조 버튼 보더
  primary-500: #14b8a6  — 메인 Primary 색상 (버튼, 탭 활성)
  primary-600: #0d9488  — 버튼 hover/pressed
  primary-700: #0f766e  — 강조 텍스트
  primary-800: #115e59  — 다크모드 배경 위 텍스트
  primary-900: #134e4a  — 최고 강조

Dark mode:
  primary-400 → 활성 아이콘, 탭바 선택
  primary-500 → 버튼 배경
  primary-300 → 비활성 상태
```

**Tailwind 토큰 키**: `primary-*`
**Nativewind 클래스 예시**: `bg-primary-500`, `text-primary-700`, `border-primary-400`

### 2-2. Secondary 컬러

```
Warm Amber (온기, 반려동물 감성)

Light mode:
  secondary-50:  #fffbeb
  secondary-100: #fef3c7
  secondary-200: #fde68a
  secondary-300: #fcd34d
  secondary-400: #fbbf24
  secondary-500: #f59e0b  — 메인 Secondary (펫 프로필 강조, 배지)
  secondary-600: #d97706
  secondary-700: #b45309
  secondary-800: #92400e
  secondary-900: #78350f

Dark mode:
  secondary-300 → 아이콘 강조
  secondary-400 → 버튼/배지 배경
```

**Tailwind 토큰 키**: `secondary-*`

### 2-3. Accent 컬러

```
Soft Coral (CTA 보조, 감성 포인트)

  accent-400: #fb7185
  accent-500: #f43f5e  — 응급 진입 버튼 강조, "지금 응급" 배너
  accent-600: #e11d48
```

**Tailwind 토큰 키**: `accent-*`
**용도**: 응급 탭 CTA, 면책 고지 배너 포인트, 좋아요/즐겨찾기

### 2-4. Semantic 컬러

#### Success (완료, 정상, 접종 완료)
```
Light: #16a34a (green-600)
Dark:  #4ade80 (green-400)
Background Light: #f0fdf4 (green-50)
Background Dark:  #14532d / 30% opacity
```
**Nativewind**: `text-green-600 dark:text-green-400`, `bg-green-50 dark:bg-green-950`

#### Warning (주의, 준응급, 접종 임박)
```
Light: #d97706 (amber-600)
Dark:  #fbbf24 (amber-400)
Background Light: #fffbeb (amber-50)
Background Dark:  #451a03 / 30% opacity
```
**Nativewind**: `text-amber-600 dark:text-amber-400`, `bg-amber-50 dark:bg-amber-950`

#### Error (응급, 오류, 삭제 확인)
```
Light: #dc2626 (red-600)
Dark:  #f87171 (red-400)
Background Light: #fef2f2 (red-50)
Background Dark:  #450a0a / 30% opacity
```
**Nativewind**: `text-red-600 dark:text-red-400`, `bg-red-50 dark:bg-red-950`

#### Info (정보, 팁, 안내)
```
Light: #2563eb (blue-600)
Dark:  #60a5fa (blue-400)
Background Light: #eff6ff (blue-50)
Background Dark:  #1e3a5f / 30% opacity
```
**Nativewind**: `text-blue-600 dark:text-blue-400`, `bg-blue-50 dark:bg-blue-950`

### 2-5. Neutral (Gray 스케일)

```
Light mode 기준:

  neutral-0:   #ffffff  — 최상위 배경, 카드 배경
  neutral-50:  #f9fafb  — 앱 배경 (스크린 기본)
  neutral-100: #f3f4f6  — 입력 필드 배경, 구분선
  neutral-200: #e5e7eb  — 비활성 보더
  neutral-300: #d1d5db  — placeholder
  neutral-400: #9ca3af  — 보조 아이콘
  neutral-500: #6b7280  — Caption 텍스트
  neutral-600: #4b5563  — Body 보조 텍스트
  neutral-700: #374151  — Body 메인 텍스트
  neutral-800: #1f2937  — Heading 텍스트
  neutral-900: #111827  — 최고 강조 텍스트

Dark mode 매핑:
  배경:         #0f172a  (slate-950) — 스크린 배경
  카드 배경:    #1e293b  (slate-800)
  보더:         #334155  (slate-700)
  보조 텍스트:  #94a3b8  (slate-400)
  메인 텍스트:  #e2e8f0  (slate-200)
  강조 텍스트:  #f8fafc  (slate-50)
```

### 2-6. tailwind.config.js 컬러 토큰 정의

```js
// tailwind.config.js
module.exports = {
  theme: {
    extend: {
      colors: {
        primary: {
          50:  '#f0fdfa',
          100: '#ccfbf1',
          200: '#99f6e4',
          300: '#5eead4',
          400: '#2dd4bf',
          500: '#14b8a6',
          600: '#0d9488',
          700: '#0f766e',
          800: '#115e59',
          900: '#134e4a',
        },
        secondary: {
          50:  '#fffbeb',
          100: '#fef3c7',
          200: '#fde68a',
          300: '#fcd34d',
          400: '#fbbf24',
          500: '#f59e0b',
          600: '#d97706',
          700: '#b45309',
          800: '#92400e',
          900: '#78350f',
        },
        accent: {
          400: '#fb7185',
          500: '#f43f5e',
          600: '#e11d48',
        },
        // Semantic은 Tailwind 기본 green/amber/red/blue 활용
        surface: {
          // 다크모드 전용 surface 토큰
          DEFAULT: '#ffffff',       // light
          dark:    '#0f172a',       // dark screen bg
          card:    '#ffffff',       // light card
          'card-dark': '#1e293b',   // dark card
        },
      },
    },
  },
}
```

### 2-7. CSS 변수 (global.css — Nativewind v4)

```css
/* global.css */
:root {
  --color-primary:    #14b8a6;
  --color-secondary:  #f59e0b;
  --color-accent:     #f43f5e;
  --color-bg:         #f9fafb;
  --color-surface:    #ffffff;
  --color-text-main:  #1f2937;
  --color-text-sub:   #6b7280;
  --color-border:     #e5e7eb;
}

@media (prefers-color-scheme: dark) {
  :root {
    --color-primary:    #2dd4bf;
    --color-secondary:  #fbbf24;
    --color-accent:     #fb7185;
    --color-bg:         #0f172a;
    --color-surface:    #1e293b;
    --color-text-main:  #e2e8f0;
    --color-text-sub:   #94a3b8;
    --color-border:     #334155;
  }
}
```

---

## 3. 타이포그래피

### 3-1. 폰트 패밀리 선택

#### Primary Font: Pretendard

- 선택 이유: 한국어-영어 혼용 앱에 최적. Apple SD Gothic Neo 대비 가독성 우수. OFL 라이선스로 상업 사용 무료. iOS/Android 동일 렌더링 품질
- 파일 규격: Static OTF (Variable Font 불가 — React Native 제한)
- 필요 웨이트: Regular(400), Medium(500), SemiBold(600), Bold(700)

```
Pretendard-Regular.otf    → font-pretendard-regular
Pretendard-Medium.otf     → font-pretendard-medium
Pretendard-SemiBold.otf   → font-pretendard-semibold
Pretendard-Bold.otf       → font-pretendard-bold
```

#### Fallback (시스템 폰트)

```
iOS:     -apple-system (San Francisco)
Android: Roboto
```

### 3-2. 타이포그래피 스케일

| 레벨 | 이름 | size | lineHeight | weight | Nativewind 클래스 |
|---|---|---|---|---|---|
| Display | - | 32px | 40px | Bold (700) | `text-[32px] leading-[40px] font-pretendard-bold` |
| H1 | 화면 제목 | 28px | 36px | Bold (700) | `text-[28px] leading-[36px] font-pretendard-bold` |
| H2 | 섹션 헤딩 | 22px | 30px | SemiBold (600) | `text-[22px] leading-[30px] font-pretendard-semibold` |
| H3 | 카드 제목 | 18px | 26px | SemiBold (600) | `text-[18px] leading-[26px] font-pretendard-semibold` |
| H4 | 서브 제목 | 16px | 24px | Medium (500) | `text-base leading-6 font-pretendard-medium` |
| Body L | 본문 큰 | 16px | 24px | Regular (400) | `text-base leading-6 font-pretendard-regular` |
| Body M | 본문 기본 | 14px | 22px | Regular (400) | `text-sm leading-[22px] font-pretendard-regular` |
| Body S | 보조 본문 | 13px | 20px | Regular (400) | `text-[13px] leading-5 font-pretendard-regular` |
| Label | 버튼/탭 레이블 | 15px | 20px | SemiBold (600) | `text-[15px] leading-5 font-pretendard-semibold` |
| Caption | 부가 정보 | 12px | 16px | Regular (400) | `text-xs leading-4 font-pretendard-regular` |
| Caption Bold | 강조 캡션 | 12px | 16px | Medium (500) | `text-xs leading-4 font-pretendard-medium` |
| Overline | 카테고리 태그 | 11px | 16px | SemiBold (600) | `text-[11px] leading-4 font-pretendard-semibold tracking-wider` |

### 3-3. tailwind.config.js 폰트 설정

```js
theme: {
  extend: {
    fontFamily: {
      'pretendard-regular':  ['Pretendard-Regular'],
      'pretendard-medium':   ['Pretendard-Medium'],
      'pretendard-semibold': ['Pretendard-SemiBold'],
      'pretendard-bold':     ['Pretendard-Bold'],
    },
    fontSize: {
      // Tailwind 기본 외 커스텀
      '11': ['11px', { lineHeight: '16px' }],
      '13': ['13px', { lineHeight: '20px' }],
      '15': ['15px', { lineHeight: '20px' }],
      '28': ['28px', { lineHeight: '36px' }],
      '32': ['32px', { lineHeight: '40px' }],
    },
  },
}
```

### 3-4. 텍스트 컬러 적용 규칙

| 용도 | Light | Dark | Nativewind |
|---|---|---|---|
| 주요 텍스트 | neutral-800 (#1f2937) | slate-200 (#e2e8f0) | `text-neutral-800 dark:text-slate-200` |
| 보조 텍스트 | neutral-500 (#6b7280) | slate-400 (#94a3b8) | `text-neutral-500 dark:text-slate-400` |
| 비활성 텍스트 | neutral-300 (#d1d5db) | slate-600 (#475569) | `text-neutral-300 dark:text-slate-600` |
| 링크/강조 | primary-600 (#0d9488) | primary-400 (#2dd4bf) | `text-primary-600 dark:text-primary-400` |
| 에러 텍스트 | red-600 (#dc2626) | red-400 (#f87171) | `text-red-600 dark:text-red-400` |

---

## 4. 스페이싱 & 그리드

### 4-1. 기본 스페이싱 단위

기본 단위: **4px (1 unit)**
모든 스페이싱은 4의 배수로 설계.

| 토큰 | px | Tailwind 클래스 | 용도 |
|---|---|---|---|
| space-1 | 4px | `p-1`, `m-1` | 아이콘 내부 패딩 |
| space-2 | 8px | `p-2`, `m-2` | 배지, 태그 내부 패딩 |
| space-3 | 12px | `p-3`, `m-3` | 버튼 세로 패딩 |
| space-4 | 16px | `p-4`, `m-4` | 카드 내부 패딩, 섹션 간격 기본 |
| space-5 | 20px | `p-5`, `m-5` | 카드 헤더 패딩 |
| space-6 | 24px | `p-6`, `m-6` | 화면 좌우 여백 (Screen Padding) |
| space-8 | 32px | `p-8`, `m-8` | 섹션 간 여백 |
| space-10 | 40px | `p-10`, `m-10` | 대형 섹션 구분 |
| space-12 | 48px | `p-12`, `m-12` | 온보딩 섹션 간격 |
| space-16 | 64px | `p-16`, `m-16` | 빈 상태 여백 |
| space-20 | 80px | `p-20`, `m-20` | 탭바 높이 버퍼 |

### 4-2. 화면 레이아웃 그리드

```
화면 좌우 여백 (Screen Padding): 20px (space-5)
컬럼 수: 4 컬럼 (모바일 기준)
컬럼 간격 (Gutter): 12px
콘텐츠 최대 너비: 화면 너비 - 40px

Safe Area:
  - 상단: StatusBar 높이 + 4px
  - 하단: TabBar 높이(83px) + Safe Area Inset
```

**Nativewind 적용**:
```
<View className="px-5">  {/* 화면 좌우 여백 */}
<View className="gap-3">  {/* 컴포넌트 간 간격 */}
```

### 4-3. Border Radius 스케일

| 토큰 | px | Tailwind | 용도 |
|---|---|---|---|
| radius-sm | 6px | `rounded` | 태그, 배지, 소형 버튼 |
| radius-md | 10px | `rounded-xl` (사실상 10px 커스텀) | 입력 필드, 소형 카드 |
| radius-lg | 12px | `rounded-xl` | 기본 카드, 버튼 |
| radius-xl | 16px | `rounded-2xl` | 대형 카드, 바텀시트 상단 |
| radius-2xl | 20px | `rounded-[20px]` | 펫 프로필 카드, 온보딩 카드 |
| radius-full | 9999px | `rounded-full` | 아바타, 토글, 알약형 배지 |

```js
// tailwind.config.js
borderRadius: {
  'DEFAULT': '6px',
  'md': '10px',
  'lg': '12px',
  'xl': '16px',
  '2xl': '20px',
  '3xl': '24px',
  'full': '9999px',
},
```

### 4-4. 그림자 (Shadow) 스케일

```
shadow-xs:  { shadowOffset: {w:0,h:1}, shadowRadius:2, shadowOpacity:0.06 }  — 카드 미세 구분
shadow-sm:  { shadowOffset: {w:0,h:2}, shadowRadius:4, shadowOpacity:0.08 }  — 기본 카드
shadow-md:  { shadowOffset: {w:0,h:4}, shadowRadius:8, shadowOpacity:0.10 }  — 버튼, 탭바
shadow-lg:  { shadowOffset: {w:0,h:8}, shadowRadius:16, shadowOpacity:0.12 } — 모달, 바텀시트
shadow-xl:  { shadowOffset: {w:0,h:16}, shadowRadius:32, shadowOpacity:0.14 } — 응급 CTA 버튼
```

다크모드에서는 그림자 대신 border-1 (slate-700) 로 레이어 구분.

---

## 5. 컴포넌트 라이브러리

### 5-1. 버튼 (Button)

#### 버튼 Variant

**Primary Button**
```
용도: 주요 CTA (기록 저장, 펫 등록, 응급 전송)
Light: bg-primary-500, text-white
Dark:  bg-primary-500, text-white
Pressed: bg-primary-600
Disabled: bg-neutral-200, text-neutral-400

Nativewind:
  <TouchableOpacity
    className="bg-primary-500 active:bg-primary-600
               disabled:bg-neutral-200
               rounded-xl px-5 py-3.5
               items-center justify-center"
  >
    <Text className="text-white text-[15px] leading-5
                     font-pretendard-semibold">
      버튼 텍스트
    </Text>
  </TouchableOpacity>
```

**Secondary Button**
```
용도: 보조 CTA (취소, 더보기, 공유)
Light: bg-white, border border-primary-400, text-primary-600
Dark:  bg-transparent, border border-primary-400, text-primary-400
Pressed: bg-primary-50 dark:bg-primary-900/20

Nativewind:
  className="bg-white dark:bg-transparent
             border border-primary-400
             rounded-xl px-5 py-3.5"
  Text: "text-primary-600 dark:text-primary-400"
```

**Ghost Button**
```
용도: 텍스트형 버튼 (스킵, 나중에, 링크형)
Light: bg-transparent, text-neutral-600
Dark:  bg-transparent, text-slate-400
Pressed: bg-neutral-100 dark:bg-slate-800

Nativewind:
  className="bg-transparent active:bg-neutral-100
             dark:active:bg-slate-800
             rounded-xl px-5 py-3.5"
  Text: "text-neutral-600 dark:text-slate-400"
```

**Danger Button**
```
용도: 삭제, 의료기록 제거, 계정 탈퇴
Light: bg-red-600, text-white
Dark:  bg-red-600, text-white
Pressed: bg-red-700

Nativewind:
  className="bg-red-600 active:bg-red-700
             rounded-xl px-5 py-3.5"
  Text: "text-white font-pretendard-semibold"
```

**Emergency Button (응급 탭 전용)**
```
용도: 응급 탭 메인 CTA ("지금 증상 말하기")
bg-accent-500, text-white, shadow-xl
pulse 애니메이션 적용 (위급 인지용)

Nativewind:
  className="bg-accent-500 active:bg-accent-600
             rounded-2xl px-6 py-4 shadow-xl"
  Text: "text-white text-[17px] font-pretendard-bold"
```

#### 버튼 Size 스펙

| 사이즈 | 높이 | 가로 패딩 | 폰트 | 용도 |
|---|---|---|---|---|
| XL | 56px | 24px | 17px Bold | 온보딩, 응급 CTA |
| L (기본) | 48px | 20px | 15px SemiBold | 화면 내 주요 버튼 |
| M | 40px | 16px | 14px SemiBold | 인라인 버튼 |
| S | 32px | 12px | 13px Medium | 태그형 버튼, 필터 |
| Icon-only | 44px(W) x 44px(H) | - | - | 헤더 아이콘 버튼 (최소 터치 44px) |

---

### 5-2. 인풋 (Input)

#### Text Input

```
구조: Label + Input Field + Helper/Error Text

기본 상태:
  bg-neutral-100 dark:bg-slate-800
  border border-transparent rounded-xl
  px-4 py-3 (높이 약 48px)
  text-neutral-800 dark:text-slate-200
  placeholder: text-neutral-400 dark:text-slate-500

Focus 상태:
  border-primary-500
  bg-white dark:bg-slate-700
  ring-2 ring-primary-200 dark:ring-primary-900

Error 상태:
  border-red-500
  bg-red-50 dark:bg-red-950/30

Disabled:
  bg-neutral-100 dark:bg-slate-900
  text-neutral-400 dark:text-slate-600
  opacity-60

Nativewind:
  <View className="gap-1.5">
    <Text className="text-sm font-pretendard-medium
                     text-neutral-700 dark:text-slate-300">
      레이블
    </Text>
    <TextInput
      className="bg-neutral-100 dark:bg-slate-800
                 border border-transparent
                 focus:border-primary-500
                 rounded-xl px-4 py-3
                 text-base text-neutral-800
                 dark:text-slate-200
                 font-pretendard-regular"
      placeholder="입력해주세요"
      placeholderTextColor="#9ca3af"
    />
    <Text className="text-xs text-neutral-500
                     dark:text-slate-400">
      도움말 텍스트
    </Text>
  </View>
```

#### TextArea (의료기록 메모)

```
minHeight: 100px, maxHeight: 200px
나머지 스타일은 Text Input과 동일
multiline={true}, textAlignVertical="top"

className="bg-neutral-100 dark:bg-slate-800
           rounded-xl px-4 py-3 min-h-[100px]
           border border-transparent
           focus:border-primary-500"
```

#### Search Input

```
아이콘: 왼쪽 Search 아이콘 (16px)
지우기: 오른쪽 X 버튼 (텍스트 입력 시 표시)
bg-neutral-100 dark:bg-slate-800
rounded-full px-4 py-2.5
height: 44px

Nativewind:
  <View className="flex-row items-center
                   bg-neutral-100 dark:bg-slate-800
                   rounded-full px-4 h-11 gap-2">
    <SearchIcon size={16} color="#9ca3af" />
    <TextInput className="flex-1 text-sm
                          text-neutral-800 dark:text-slate-200" />
  </View>
```

#### Select (Picker)

```
외형: Text Input과 동일
오른쪽: ChevronDown 아이콘
iOS: ActionSheet 스타일 Picker
Android: native Picker

className="flex-row items-center justify-between
           bg-neutral-100 dark:bg-slate-800
           rounded-xl px-4 py-3 h-12"
```

#### Checkbox

```
체크 전:
  width: 20px, height: 20px
  border: 2px, border-color: neutral-300
  rounded: 4px
  bg: transparent

체크 후:
  bg-primary-500
  border-primary-500
  체크 아이콘: white, 12px

Nativewind (커스텀 구현):
  <Pressable
    className={`w-5 h-5 rounded border-2
      ${checked
        ? 'bg-primary-500 border-primary-500'
        : 'bg-transparent border-neutral-300 dark:border-slate-600'
      } items-center justify-center`}
  >
    {checked && <CheckIcon size={12} color="white" />}
  </Pressable>
```

#### Radio Button

```
외형: Checkbox와 동일 구조, rounded-full
선택 후 내부 원 채우기 (dot 스타일)

inner dot: width 10px, height 10px, rounded-full
bg-primary-500 (선택 시)
```

#### Toggle Switch

```
iOS 네이티브 Switch 사용
trackColor: { false: '#d1d5db', true: '#14b8a6' }
thumbColor: '#ffffff'
ios_backgroundColor: '#d1d5db'
```

---

### 5-3. 카드 컴포넌트

#### 펫 프로필 카드 (Pet Card)

```
용도: 홈 탭 상단 스와이프 카드 (멀티펫)
크기: 너비 화면 - 40px, 높이 auto (최소 120px)
bg-white dark:bg-slate-800
rounded-2xl shadow-md
padding: 16px

레이아웃:
  [펫 사진 72px 원형] [펫 이름 H3] [종/나이 Body S]
                       [최근 접종 D-day 배지]
                       [빠른 기록 추가 버튼]

Nativewind:
  <View className="bg-white dark:bg-slate-800
                   rounded-2xl p-4 shadow-md
                   flex-row items-center gap-4">
    <Image className="w-[72px] h-[72px] rounded-full
                      bg-neutral-100" />
    <View className="flex-1 gap-1">
      <Text className="text-[18px] leading-[26px]
                       font-pretendard-semibold
                       text-neutral-800 dark:text-slate-200">
        펫 이름
      </Text>
      <Text className="text-sm text-neutral-500
                       dark:text-slate-400">
        말티즈 · 3세
      </Text>
    </View>
  </View>
```

#### 의료기록 카드 (Medical Record Card)

```
용도: 타임라인 아이템
크기: 전체 너비, 높이 auto
bg-white dark:bg-slate-800
rounded-xl border-l-4 (카테고리별 색상)
shadow-xs
padding: 12px 16px

왼쪽 보더 컬러:
  진료: border-l-primary-500
  접종: border-l-secondary-500
  검진: border-l-blue-500
  처방: border-l-purple-500

레이아웃:
  상단: [날짜 Caption] [카테고리 배지]
  중단: [병원명 Body M Bold] [진단/처치 내용 Body S]
  하단: [비용 Caption] [첨부파일 아이콘]

Nativewind:
  <View className="bg-white dark:bg-slate-800
                   rounded-xl border-l-4
                   border-l-primary-500
                   shadow-xs px-4 py-3 gap-2">
```

#### 챗봇 메시지 버블

**사용자 메시지 (User Bubble)**
```
정렬: 오른쪽
bg-primary-500
text-white
rounded-2xl rounded-tr-sm  ← 꼬리 표현
max-width: 75%
padding: 10px 14px
font: Body M, Regular

Nativewind:
  className="bg-primary-500 rounded-2xl rounded-tr-sm
             px-3.5 py-2.5 max-w-[75%] self-end"
  Text: "text-white text-sm font-pretendard-regular"
```

**AI 메시지 버블 (Bot Bubble)**
```
정렬: 왼쪽
bg-neutral-100 dark:bg-slate-800
text-neutral-800 dark:text-slate-200
rounded-2xl rounded-tl-sm
max-width: 80%
padding: 10px 14px

Nativewind:
  className="bg-neutral-100 dark:bg-slate-800
             rounded-2xl rounded-tl-sm
             px-3.5 py-2.5 max-w-[80%] self-start"
```

**타이핑 인디케이터 버블**
```
AI Bubble 스타일 동일
내부: 3개 dot 펄스 애니메이션 (200ms 딜레이)
dot: w-2 h-2 rounded-full bg-neutral-400
```

**면책 고지 버블 (항상 챗봇 최하단 고정)**
```
bg-amber-50 dark:bg-amber-950/30
border border-amber-200 dark:border-amber-800
rounded-xl px-4 py-3
text-amber-700 dark:text-amber-400
font: Caption, Regular
아이콘: InfoCircle (amber-500)
```

#### 증상 빠른선택 카드 (Symptom Quick Card)

```
용도: 응급 탭 — 8개 증상 카테고리 그리드
크기: (화면너비 - 40px - 12px) / 2 × 2, 높이 80px
bg-white dark:bg-slate-800
rounded-xl border border-neutral-200
          dark:border-slate-700
padding: 12px

레이아웃: 아이콘 (32px) + 텍스트 (Body S)
선택 시: bg-primary-50 border-primary-400
          dark:bg-primary-900/20 dark:border-primary-500

Nativewind:
  <Pressable
    className={`rounded-xl border p-3 flex-row
                items-center gap-2
      ${selected
        ? 'bg-primary-50 border-primary-400 dark:bg-primary-900/20 dark:border-primary-500'
        : 'bg-white dark:bg-slate-800 border-neutral-200 dark:border-slate-700'
      }`}
  >
```

#### 빈 상태 카드 (Empty State)

```
전체 화면 센터 정렬
아이콘: 64px, color neutral-300 dark:slate-600
제목: H3, neutral-600 dark:slate-400
설명: Body S, neutral-400 dark:slate-500
CTA 버튼: Primary (있을 경우)

Nativewind:
  <View className="flex-1 items-center justify-center
                   gap-4 px-8 py-16">
```

---

### 5-4. 네비게이션

#### 탭바 (Bottom Tab Bar)

```
높이: 83px (Safe Area 포함 시 iOS 기준 약 83px)
bg-white dark:bg-slate-900
border-t border-neutral-100 dark:border-slate-800
shadow-md

탭 항목: 3개 균등 분할
각 탭: 44px 터치 영역, 아이콘(24px) + 레이블(11px)

비활성:
  아이콘: neutral-400 dark:slate-500
  텍스트: neutral-400 dark:slate-500

활성:
  아이콘: primary-500 (filled 버전)
  텍스트: primary-600 dark:primary-400
  텍스트 weight: SemiBold

응급 탭 아이콘:
  비활성: 아웃라인 하트비트 아이콘, neutral-400
  활성: 필드 하트비트 아이콘, accent-500
  (응급 탭은 특별히 accent 컬러 사용 — 긴장감 부여)

Nativewind:
  <View className="flex-row bg-white dark:bg-slate-900
                   border-t border-neutral-100
                   dark:border-slate-800 shadow-md
                   pb-[env(safe-area-inset-bottom)]">
    {/* 각 탭 아이템 */}
    <Pressable className="flex-1 items-center
                          justify-center pt-2 pb-1 gap-1">
      <Icon size={24} color={isActive ? '#14b8a6' : '#9ca3af'} />
      <Text className={`text-[11px] leading-4
        font-pretendard-semibold
        ${isActive
          ? 'text-primary-600 dark:text-primary-400'
          : 'text-neutral-400 dark:text-slate-500'
        }`}>
        내 아이
      </Text>
    </Pressable>
  </View>
```

#### 헤더 (Navigation Header)

```
높이: 56px (+ SafeAreaTop)
bg-white dark:bg-slate-900
border-b border-neutral-100 dark:border-slate-800

구성 요소:
  - 왼쪽: 뒤로가기 버튼 (ChevronLeft, 24px) 또는 앱 로고
  - 가운데: 화면 제목 (H4, 15px SemiBold)
  - 오른쪽: 액션 버튼 (아이콘, 최대 2개)

제목 정렬: 좌측 정렬 (iOS 네이티브 패턴)

특수 헤더 — 응급 탭:
  bg-white dark:bg-slate-900
  제목: "응급 상담" text-accent-500
  아이콘: PhoneCall (야간병원 연결 버튼) — accent-500

Nativewind:
  <View className="flex-row items-center px-4
                   bg-white dark:bg-slate-900
                   border-b border-neutral-100
                   dark:border-slate-800 h-14">
    <Pressable className="w-11 h-11 items-center
                          justify-center -ml-1">
      <ChevronLeftIcon size={24} color="#374151" />
    </Pressable>
    <Text className="flex-1 text-[15px] leading-5
                     font-pretendard-semibold
                     text-neutral-800 dark:text-slate-200">
      화면 제목
    </Text>
  </View>
```

#### 바텀시트 (Bottom Sheet)

```
오버레이: bg-black/50
시트 배경: bg-white dark:bg-slate-900
상단 모서리: rounded-t-3xl (24px)
상단 핸들: w-10 h-1 rounded-full bg-neutral-300
           dark:bg-slate-600 mx-auto mt-3

높이 스냅:
  - 25%: 미니 시트 (확인/취소)
  - 50%: 기본 시트 (옵션 선택)
  - 90%: 확장 시트 (날짜 선택, 상세 입력)

padding: px-5 py-4

Nativewind:
  <View className="bg-white dark:bg-slate-900
                   rounded-t-3xl px-5 pt-4 pb-8">
    <View className="w-10 h-1 rounded-full
                     bg-neutral-300 dark:bg-slate-600
                     self-center mb-6" />
    {/* 컨텐츠 */}
  </View>
```

---

### 5-5. 알림 / 토스트 / 모달

#### 토스트 (Toast)

```
위치: 화면 하단 (탭바 위 8px)
또는 화면 상단 (StatusBar 아래 8px, 에러/경고)
width: 화면 너비 - 40px, max-width: 360px
border-radius: rounded-xl
padding: px-4 py-3

Variant:
  Success: bg-green-600, text-white, CheckCircle 아이콘
  Warning: bg-amber-500, text-white, AlertTriangle 아이콘
  Error:   bg-red-600, text-white, XCircle 아이콘
  Info:    bg-neutral-800 dark:bg-slate-700, text-white, Info 아이콘

레이아웃: [아이콘 20px] [메시지 Body S] [닫기 X 버튼 (선택)]
자동 닫힘: 3초 (Success/Info), 5초 (Warning/Error)

Nativewind:
  <View className="flex-row items-center gap-3
                   bg-green-600 rounded-xl
                   px-4 py-3 mx-5 shadow-lg">
    <CheckCircleIcon size={20} color="white" />
    <Text className="flex-1 text-white text-sm
                     font-pretendard-regular">
      저장되었습니다.
    </Text>
  </View>
```

#### 모달 (Modal)

```
오버레이: bg-black/50
모달 박스:
  bg-white dark:bg-slate-800
  rounded-2xl
  mx-5 (화면 좌우 20px)
  padding: px-6 py-6
  max-height: 80%

구성:
  제목: H3 (18px SemiBold) — 텍스트 가운데 정렬
  본문: Body M — 텍스트 가운데 정렬 (짧을 경우) / 좌측 정렬 (목록)
  버튼 영역: 하단, 세로 스택 또는 가로 2버튼 (Primary + Secondary)
  닫기: 오른쪽 상단 X 아이콘 (Ghost, 선택적)

버튼 배치 규칙:
  - 주요 액션 버튼은 항상 Primary, 최하단
  - 취소는 Ghost, 주요 버튼 위

Nativewind:
  <View className="bg-white dark:bg-slate-800
                   rounded-2xl px-6 py-6 mx-5
                   shadow-xl gap-4">
    <Text className="text-[18px] font-pretendard-semibold
                     text-neutral-800 dark:text-slate-200
                     text-center">
      모달 제목
    </Text>
    <Text className="text-sm text-neutral-600
                     dark:text-slate-400 text-center">
      설명 텍스트
    </Text>
    <View className="gap-2 mt-2">
      {/* Primary Button */}
      {/* Ghost Button */}
    </View>
  </View>
```

#### 알림 배너 (Inline Banner)

```
용도: 면책 고지, 중요 안내, 서비스 공지
bg-amber-50 dark:bg-amber-950/30
border border-amber-200 dark:border-amber-700
rounded-xl px-4 py-3
text-amber-800 dark:text-amber-300

Nativewind:
  <View className="bg-amber-50 dark:bg-amber-950/30
                   border border-amber-200
                   dark:border-amber-700
                   rounded-xl px-4 py-3
                   flex-row gap-3 items-start">
    <AlertTriangleIcon size={18} color="#d97706" />
    <Text className="flex-1 text-xs text-amber-800
                     dark:text-amber-300
                     font-pretendard-regular">
      이 앱은 수의사의 진료를 대체하지 않습니다.
    </Text>
  </View>
```

---

### 5-6. 트리아지 결과 배지 (Triage Badge)

이 앱의 핵심 기능인 응급도 분류 결과는 즉각적으로 인식 가능해야 한다. 색상 + 아이콘 + 텍스트 3중 신호를 사용한다.

#### 응급 (Emergency)

```
레벨: 즉시 응급실 방문 필요
배지 배경: bg-red-600
텍스트: "응급" — text-white font-pretendard-bold
아이콘: AlertCircle (solid, white)
테두리: border-2 border-red-700
pulse 애니메이션 적용 (시각적 긴장감)

크기 Variant:
  Large: rounded-xl px-4 py-2 text-base
  Small: rounded-full px-3 py-1 text-xs

Nativewind (Large):
  className="flex-row items-center gap-2
             bg-red-600 rounded-xl px-4 py-2"
  Text: "text-white text-base font-pretendard-bold"

Nativewind (Small):
  className="flex-row items-center gap-1
             bg-red-600 rounded-full px-3 py-1"
  Text: "text-white text-xs font-pretendard-bold"
```

#### 준응급 (Urgent)

```
레벨: 당일 진료 권장 (수 시간 내)
배지 배경: bg-amber-500
텍스트: "준응급" — text-white font-pretendard-bold
아이콘: Clock (solid, white)
테두리: border-2 border-amber-600

Nativewind (Large):
  className="flex-row items-center gap-2
             bg-amber-500 rounded-xl px-4 py-2"
  Text: "text-white text-base font-pretendard-bold"
```

#### 경과관찰 (Watch)

```
레벨: 자택 관찰 가능, 증상 악화 시 내원
배지 배경: bg-green-600
텍스트: "경과관찰" — text-white font-pretendard-semibold
아이콘: Eye (outline, white)

Nativewind (Large):
  className="flex-row items-center gap-2
             bg-green-600 rounded-xl px-4 py-2"
  Text: "text-white text-base font-pretendard-semibold"
```

#### 트리아지 결과 카드 (전체 결과 화면)

```
응급 시:
  bg-red-50 dark:bg-red-950/30
  border-2 border-red-500
  rounded-2xl p-5

준응급 시:
  bg-amber-50 dark:bg-amber-950/30
  border-2 border-amber-500
  rounded-2xl p-5

경과관찰 시:
  bg-green-50 dark:bg-green-950/30
  border-2 border-green-500
  rounded-2xl p-5

카드 내 구성:
  상단: 트리아지 배지 (Large)
  중단: 한 줄 권고 메시지 (H3)
  하단: 세부 안내 (Body M)
  CTA: 근처 병원 보기 (Primary) / 증상 재설명 (Ghost)
  최하단: 면책 고지 (Caption, amber)
```

#### D-day 배지 (접종 일정)

```
D-7 이내: bg-red-100 text-red-700 dark:bg-red-900/30 dark:text-red-400
D-30 이내: bg-amber-100 text-amber-700 dark:bg-amber-900/30 dark:text-amber-400
D-30 초과: bg-neutral-100 text-neutral-600 dark:bg-slate-700 dark:text-slate-400

Nativewind:
  className="rounded-full px-2.5 py-1 text-[11px]
             font-pretendard-semibold"
```

#### 의료기록 카테고리 배지

```
진료:     bg-primary-100 text-primary-700
접종:     bg-secondary-100 text-secondary-700
검진:     bg-blue-100 text-blue-700
처방:     bg-purple-100 text-purple-700
기타:     bg-neutral-100 text-neutral-600

Dark mode:
진료:     dark:bg-primary-900/30 dark:text-primary-400
접종:     dark:bg-secondary-900/30 dark:text-secondary-400
검진:     dark:bg-blue-900/30 dark:text-blue-400
처방:     dark:bg-purple-900/30 dark:text-purple-400
기타:     dark:bg-slate-700 dark:text-slate-400

크기: rounded-full px-2.5 py-1 text-xs font-pretendard-medium
```

---

## 6. 스페셜 컴포넌트

### 6-1. OCR 촬영 화면 오버레이

```
카메라 뷰 위 오버레이:
  반투명 검정 배경 (중앙 영수증 영역만 투명)
  투명 영역: rounded-xl 흰색 보더 2px dashed
  안내 텍스트: "영수증을 박스 안에 맞춰주세요"
              bg-black/70 rounded-xl px-4 py-2
              text-white text-sm

촬영 버튼:
  w-[72px] h-[72px] rounded-full
  border-4 border-white bg-white/30
  내부 원: w-[56px] h-[56px] rounded-full bg-white
```

### 6-2. 타임라인 컴포넌트 (의료기록)

```
수직 타임라인:
  왼쪽 선: w-px bg-neutral-200 dark:bg-slate-700
  노드 점: w-3 h-3 rounded-full
           진료: bg-primary-500
           접종: bg-secondary-500
           검진: bg-blue-500
  간격: gap-0 (선이 이어지도록)

각 아이템: 왼쪽 노드 + 오른쪽 의료기록 카드
카드 상단 여백: mt-0 (선과 카드 정렬)
```

### 6-3. 프로그레스 인디케이터 (온보딩)

```
스텝 수: 3-4단계
비활성: w-2 h-2 rounded-full bg-neutral-200 dark:bg-slate-700
활성: w-6 h-2 rounded-full bg-primary-500 (pill 형태)
간격: gap-1.5
전환 애니메이션: 너비 w-2 → w-6 (spring 300ms)
```

### 6-4. 스켈레톤 로딩 (Skeleton)

```
색상:
  Light: bg-neutral-200 (기본) → bg-neutral-100 (shimmer)
  Dark:  bg-slate-700 (기본) → bg-slate-600 (shimmer)

shimmer 방향: 왼쪽 → 오른쪽, 1.2초 반복

사용 위치:
  - 펫 카드 로딩
  - 의료기록 타임라인 로딩
  - 챗봇 응답 대기 시 (타이핑 인디케이터로 대체 가능)

Nativewind:
  className="bg-neutral-200 dark:bg-slate-700
             rounded-xl animate-pulse"
```

---

## 7. 아이콘 스타일

### 7-1. 아이콘 세트 선택

**Primary: Lucide Icons (react-native-lucide-icons 또는 lucide-react-native)**

선택 이유:
- MIT 라이선스, 상업 사용 완전 무료
- 1,500개 이상 아이콘 (의료/동물 관련 포함)
- Stroke 기반 아웃라인 스타일 — 깔끔하고 현대적
- React Native 지원 공식 패키지 존재
- strokeWidth, size, color Props 커스터마이징 용이

### 7-2. 아이콘 사용 규칙

| 규칙 | 내용 |
|---|---|
| 기본 strokeWidth | 1.5px (비활성/일반) |
| 강조 strokeWidth | 2px (활성/중요 상태) |
| 탭바 아이콘 | 비활성 outline 1.5px → 활성 filled 또는 2.5px stroke |
| 최소 터치 영역 | 아이콘 크기 무관하게 터치 영역은 44x44px 보장 |
| 아이콘 컬러 | 단독 컬러 사용 (그라디언트 없음) |
| 아이콘 크기 | 16 / 20 / 24 / 32 / 40 / 64px |

### 7-3. 탭바 아이콘 지정

| 탭 | 비활성 아이콘 | 활성 아이콘 | 아이콘명 |
|---|---|---|---|
| 내 아이 | PawPrint outline | PawPrint fill (커스텀) | PawPrint |
| 응급 | HeartPulse outline | HeartPulse stroke 2.5 | HeartPulse |
| 더보기 | Menu / Grid2x2 | Menu filled | LayoutGrid |

### 7-4. 주요 화면별 아이콘 매핑

| 기능 | 아이콘 | 크기 |
|---|---|---|
| 뒤로가기 | ChevronLeft | 24 |
| 닫기 | X | 20 |
| 추가 | Plus | 20 / 24 |
| 편집 | Pencil | 16 |
| 삭제 | Trash2 | 16 |
| 카메라 (OCR) | Camera | 24 |
| 이미지 첨부 | ImagePlus | 20 |
| 캘린더 | Calendar | 20 |
| 검색 | Search | 18 |
| 알림 | Bell | 22 |
| 설정 | Settings | 22 |
| 응급 전화 | PhoneCall | 20 |
| 지도 (야간병원) | MapPin | 20 |
| 접종 완료 | CheckCircle2 | 16 |
| 경고 | AlertTriangle | 18 |
| 정보 | Info | 16 |
| 시계 (준응급) | Clock | 16 |
| 눈 (경과관찰) | Eye | 16 |
| 공유 | Share2 | 20 |
| 파일 첨부 | FileText | 16 |
| 보험 | Shield | 20 |

### 7-5. 커스텀 아이콘 (SVG)

Lucide에 없는 반려동물 특화 아이콘은 SVG로 커스텀 제작:

- PawPrint Filled (탭바 활성)
- Syringe (주사/접종)
- Stethoscope — Lucide에 있음, 활용
- Dog / Cat 실루엣 (온보딩)
- Pill (처방)

커스텀 SVG는 `react-native-svg`로 래핑, 동일 Props 인터페이스 유지.

---

## 8. 다크모드 운영 가이드

### 8-1. Nativewind v4 다크모드 설정

```js
// tailwind.config.js
module.exports = {
  // darkMode 설정 제거 — Nativewind v4는 media query 기본값 사용
  content: [
    './app/**/*.{js,jsx,ts,tsx}',
    './components/**/*.{js,jsx,ts,tsx}',
  ],
  theme: { extend: { /* 위 컬러 토큰 */ } },
  plugins: [],
}
```

```css
/* global.css */
/* 위 2-7 섹션의 CSS 변수 적용 */
```

### 8-2. 컬러 스위칭 원칙

- 배경: white → slate-950 / slate-900 (카드)
- 텍스트: neutral-800 → slate-200
- 보더: neutral-200 → slate-700
- Shadow 대신 미세 보더 사용 (다크 배경에서 shadow 비가시)
- 이미지는 다크모드에서 opacity-90 적용 (눈 부심 방지)
- Primary-500은 라이트/다크 동일 사용 (충분한 대비비 확보됨)

### 8-3. Nativewind 다크모드 클래스 패턴

```
배경 패턴:   bg-white dark:bg-slate-900
카드 패턴:   bg-white dark:bg-slate-800
텍스트:      text-neutral-800 dark:text-slate-200
보조 텍스트: text-neutral-500 dark:text-slate-400
보더:        border-neutral-200 dark:border-slate-700
구분선:      bg-neutral-100 dark:bg-slate-800
아이콘:      color="#374151" dark:color="#e2e8f0"
```

---

## 9. 컴포넌트 상태 정의 요약

모든 인터랙티브 컴포넌트는 5가지 상태를 정의:

| 상태 | 시각 처리 |
|---|---|
| Default | 기본 스타일 |
| Hover / Focus | 경계선 강조, 배경 색상 변경 |
| Pressed / Active | 배경 어둡게 (opacity 또는 darker shade) |
| Disabled | opacity-50 또는 neutral-200 bg, 터치 이벤트 차단 |
| Loading | ActivityIndicator 또는 Skeleton, 터치 이벤트 차단 |

---

## 10. Nativewind tailwind.config.js 전체 스펙

```js
const { hairlineWidth } = require('nativewind/theme')

/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './app/**/*.{js,jsx,ts,tsx}',
    './components/**/*.{js,jsx,ts,tsx}',
    './features/**/*.{js,jsx,ts,tsx}',
  ],
  presets: [require('nativewind/preset')],
  theme: {
    extend: {
      colors: {
        primary: {
          50: '#f0fdfa', 100: '#ccfbf1', 200: '#99f6e4',
          300: '#5eead4', 400: '#2dd4bf', 500: '#14b8a6',
          600: '#0d9488', 700: '#0f766e', 800: '#115e59', 900: '#134e4a',
        },
        secondary: {
          50: '#fffbeb', 100: '#fef3c7', 200: '#fde68a',
          300: '#fcd34d', 400: '#fbbf24', 500: '#f59e0b',
          600: '#d97706', 700: '#b45309', 800: '#92400e', 900: '#78350f',
        },
        accent: {
          400: '#fb7185',
          500: '#f43f5e',
          600: '#e11d48',
        },
        neutral: {
          0: '#ffffff', 50: '#f9fafb', 100: '#f3f4f6',
          200: '#e5e7eb', 300: '#d1d5db', 400: '#9ca3af',
          500: '#6b7280', 600: '#4b5563', 700: '#374151',
          800: '#1f2937', 900: '#111827',
        },
      },
      fontFamily: {
        'pretendard-regular':  ['Pretendard-Regular'],
        'pretendard-medium':   ['Pretendard-Medium'],
        'pretendard-semibold': ['Pretendard-SemiBold'],
        'pretendard-bold':     ['Pretendard-Bold'],
      },
      fontSize: {
        '11': ['11px', { lineHeight: '16px' }],
        '13': ['13px', { lineHeight: '20px' }],
        '15': ['15px', { lineHeight: '20px' }],
        '17': ['17px', { lineHeight: '24px' }],
        '22': ['22px', { lineHeight: '30px' }],
        '28': ['28px', { lineHeight: '36px' }],
        '32': ['32px', { lineHeight: '40px' }],
      },
      borderRadius: {
        'DEFAULT': '6px',
        'md':      '10px',
        'lg':      '12px',
        'xl':      '16px',
        '2xl':     '20px',
        '3xl':     '24px',
        'full':    '9999px',
      },
      spacing: {
        // 4px 베이스 그리드, Tailwind 기본값 활용
        // 커스텀 추가값:
        '4.5': '18px',
        '5.5': '22px',
        '13':  '52px',
        '15':  '60px',
        '18':  '72px',
        '22':  '88px',
      },
      boxShadow: {
        xs: '0 1px 2px rgba(0,0,0,0.06)',
        sm: '0 2px 4px rgba(0,0,0,0.08)',
        md: '0 4px 8px rgba(0,0,0,0.10)',
        lg: '0 8px 16px rgba(0,0,0,0.12)',
        xl: '0 16px 32px rgba(0,0,0,0.14)',
      },
      borderWidth: {
        hairline: hairlineWidth(),
      },
    },
  },
  plugins: [],
}
```

---

## 11. 접근성 (Accessibility) 기준

| 항목 | 기준 |
|---|---|
| 텍스트 대비비 | Body 이상: WCAG AA (4.5:1), Large Text: 3:1 |
| 최소 터치 영역 | 44 x 44px (iOS HIG 기준) |
| 포커스 인디케이터 | ring-2 ring-primary-500 ring-offset-2 |
| 스크린 리더 | accessibilityLabel 필수 (아이콘 버튼) |
| 동적 텍스트 크기 | allowFontScaling=false (UI 깨짐 방지) — 대신 최대 폰트 단계 제한 |
| 색각 이상 대응 | 트리아지 배지: 색상 + 아이콘 + 텍스트 3중 표현 (색상만 의존 금지) |
| 응급 관련 UI | 응급/준응급/경과관찰 구분을 색상 단독이 아닌 텍스트+아이콘 병용 |

---

## 12. 산출물 체크리스트

| 항목 | 완료 |
|---|---|
| 컬러 시스템 (Primary/Secondary/Accent/Semantic/Neutral) | v |
| 다크모드 컬러 매핑 | v |
| CSS 변수 / tailwind.config.js 토큰 | v |
| 타이포그래피 스케일 (11단계) | v |
| 폰트 패밀리 선택 및 설정 | v |
| 버튼 (Primary/Secondary/Ghost/Danger/Emergency) | v |
| 버튼 사이즈 스펙 (XL/L/M/S/Icon-only) | v |
| 인풋 (Text/TextArea/Search/Select/Checkbox/Radio/Toggle) | v |
| 카드 (펫/의료기록/메시지버블/빠른선택/빈상태) | v |
| 네비게이션 (탭바/헤더/바텀시트) | v |
| 알림/토스트/모달/인라인배너 | v |
| 트리아지 배지 (응급/준응급/경과관찰) | v |
| D-day 배지 / 카테고리 배지 | v |
| OCR 촬영 오버레이 | v |
| 타임라인 컴포넌트 | v |
| 프로그레스 인디케이터 | v |
| 스켈레톤 로딩 | v |
| 스페이싱 & 그리드 | v |
| Border Radius 스케일 | v |
| Shadow 스케일 | v |
| 아이콘 세트 선택 및 매핑 | v |
| 컴포넌트 상태 (5가지) | v |
| 접근성 기준 | v |
| Nativewind 전체 tailwind.config.js | v |

---

*작성: UI 디자이너 / 2026-04-13*
*다음 단계: @디자인팀장 검토 후 프론트엔드팀 핸드오프*
