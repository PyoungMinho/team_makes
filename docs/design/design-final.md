# 디자인 최종안 -- 반려동물 건강 안심 플랫폼 (PetCare)

> 작성: 디자인팀장 (Opus) / 2026-04-13
> 기반: UX 설계서 (2026-04-13), UI 디자인 스펙 (2026-04-13), 프로젝트 방향서 (2026-04-11)
> 대상: iOS (React Native / Expo + Nativewind v4) -- Phase 0 MVP

---

## 0. 종합 판단 -- 팀장 리뷰

### 0-1. 정합성 평가

UX 설계서와 UI 디자인 스펙의 전반적인 정합성은 **높다**. 두 산출물 모두 동일한 기획 방향서를 기반으로 작업했고, 핵심 구조(3탭, 5개 사용자 플로우, 8개 와이어프레임)가 일치한다. 아래에서 발견된 충돌 사항과 그에 대한 최종 결정을 기술한다.

### 0-2. 충돌 사항 및 결정

| # | 충돌 항목 | UX 설계서 | UI 디자인 스펙 | 팀장 결정 | 근거 |
|---|---|---|---|---|---|
| 1 | 응급 탭 다크모드 | "야간 모드 강제 미사용 검토" | 다크모드 전체 적용 (응급 포함) | **다크모드 유지, 응급 배지만 고대비 강제** | 새벽 응급 시 밝은 화면은 오히려 눈부심 유발. 다크모드에서 트리아지 배지의 대비비를 WCAG AAA(7:1) 수준으로 강화하여 해결 |
| 2 | 트리아지 등급 표기 | 4등급 (즉시/오늘 내/내일 가능/관찰 필요) | 3등급 (응급/준응급/경과관찰) | **3등급 체계 채택** | 긴박한 상황에서 4단계 구분은 인지 부하. 3등급이 직관적. "오늘 내"와 "내일 가능"은 "준응급"으로 통합하고, 텍스트 설명에서 시간 가이드 부여 |
| 3 | 화면 좌우 여백 | 와이어프레임에서 암묵적 16px 사용 | 명시적으로 20px (px-5) | **20px 채택** | UI 스펙의 4px 그리드 체계에 정합. 카드 내부 패딩 16px과 구분이 명확해짐 |
| 4 | FAB 크기 | 56x56px | 별도 명시 없음 | **56x56px 확정** | iOS HIG 최소 44px 충족하면서 시각적 눈에 띔 확보 |
| 5 | 응급도 배지 색상 | 빨강/주황/노랑/초록 4색 | 빨강/주황/초록 3색 | **빨강(red-600)/주황(amber-500)/초록(green-600) 3색** | 3등급 체계에 맞춤 |
| 6 | 온보딩 스텝 수 | 4스텝 (면책 별도) | 미언급 | **4스텝 유지 (면책동의 > 로그인 > 펫등록 > 권한요청)** | 면책동의를 앱스토어 심사 대비 독립 스텝으로 유지하는 것이 안전 |

### 0-3. UX 미해결 사항 결정

| # | 항목 | 결정 | 근거 |
|---|---|---|---|
| 1 | 온보딩 스킵 허용 여부 | **펫 등록 필수 (현행 유지)** | 펫 없이는 앱의 핵심 기능을 사용할 수 없음. 빈 상태 화면 개발 비용 대비 효용이 낮음 |
| 2 | 응급 탭 탭바 아이콘 | **HeartPulse (하트비트)** | "채팅"보다 "응급"의 의미 전달이 직관적. UI 스펙의 Lucide HeartPulse 아이콘 채택 |
| 3 | 챗봇 대화 기록 보존 | **세션 단위 초기화 (Phase 0)** | MVP 단계에서 영구 보존은 백엔드 부담. 단, "대화 저장" 선택 시 의료기록에 요약본 연결 저장 가능 |
| 4 | 멀티펫 최대 등록 수 | **Phase 0은 5마리 제한** | 무제한은 UI 스크롤 복잡도 증가. 5마리면 페르소나 A의 2마리 + 여유 커버 |
| 5 | OCR 실패 시 기본 동작 | **현행 유지 (직접 입력 전환 제안)** | 재촬영 강제 횟수 제한은 사용자 통제감을 해침 |

---

## 1. 확정된 화면 구조 (Information Architecture)

### 1-1. 전체 IA

```
PetCare App
|
+-- 온보딩 플로우 (비인증 상태)
|   +-- Splash (1.5초, 브랜드 로고)
|   +-- DisclaimerConsent (면책 동의)
|   +-- AuthScreen (소셜/이메일 로그인)
|   +-- GuardianName (보호자 이름 입력)
|   +-- PetRegister (첫 펫 등록)
|   +-- PermissionRequest (카메라/알림/위치)
|   +-- Welcome (웰컴 + 기능 소개 카드)
|
+-- [Tab 1] 내 아이 (PawPrint)
|   +-- PetMain (펫 선택 바 + 현재 펫 요약 + 최근 기록)
|   +-- PetDetail (펫 상세 + 의료기록 타임라인)
|   +-- RecordDetail (기록 상세 조회/수정/삭제)
|   +-- RecordAdd_Selector (바텀시트: OCR 촬영 / 직접 입력)
|   +-- RecordAdd_OCR_Camera (카메라 뷰파인더)
|   +-- RecordAdd_OCR_Confirm (OCR 결과 확인/수정)
|   +-- RecordAdd_Manual (수동 입력 폼)
|   +-- PetEdit (펫 정보 편집)
|   +-- PetAdd (추가 펫 등록)
|
+-- [Tab 2] 응급 (HeartPulse)
|   +-- ChatHome (면책 배너 + 펫 선택 + 증상 빠른선택 8개)
|   +-- ChatConversation (대화 + AI 스트리밍 + 트리아지 결과 카드)
|   +-- HospitalMap (근처 야간 병원 지도)
|       +-- HospitalDetail (병원 상세: 전화/주소/영업시간)
|
+-- [Tab 3] 더보기 (LayoutGrid)
    +-- MoreMain (프로필 카드 + 메뉴 리스트)
    +-- ProfileEdit (계정 정보 편집)
    +-- NotificationSettings (알림 설정)
    +-- AppInfo (버전/이용약관/개인정보/면책)
```

### 1-2. 네비게이션 구조

```
RootNavigator (Stack)
+-- AuthNavigator (Stack, 온보딩)
|   +-- Splash
|   +-- DisclaimerConsent
|   +-- AuthScreen
|   +-- GuardianName
|   +-- PetRegister
|   +-- PermissionRequest
|   +-- Welcome
|
+-- MainTabNavigator (Bottom Tab, 인증 후)
    +-- Stack: PetStack (내 아이)
    |   +-- PetMain (Root)
    |   +-- PetDetail
    |   +-- RecordDetail
    |   +-- RecordAdd_OCR_Camera (fullScreenModal)
    |   +-- RecordAdd_OCR_Confirm
    |   +-- RecordAdd_Manual
    |   +-- PetEdit
    |   +-- PetAdd
    +-- Stack: EmergencyStack (응급)
    |   +-- ChatHome (Root)
    |   +-- ChatConversation
    |   +-- HospitalMap
    |   +-- HospitalDetail
    +-- Stack: MoreStack (더보기)
        +-- MoreMain (Root)
        +-- ProfileEdit
        +-- NotificationSettings
        +-- AppInfo
```

### 1-3. 탭 뱃지 규칙

| 탭 | 뱃지 | Phase |
|---|---|---|
| 내 아이 | 접종 예정 D-7 이내 시 숫자 뱃지 | Phase 1 |
| 응급 | 뱃지 없음 (항상 즉시 접근 가능) | - |
| 더보기 | 읽지 않은 공지 시 빨간 점 | Phase 1 |

---

## 2. 핵심 사용자 플로우 (확정)

### Flow 1 -- 온보딩 (첫 가입 -> 펫 등록)

```
Splash (1.5초)
  -> DisclaimerConsent (면책 동의 + 단일 CTA "동의하고 시작")
    -> AuthScreen (Apple ID / 카카오 / 이메일)
      -> GuardianName (닉네임 필수)
        -> PetRegister (이름*+종*+품종+생년월일+성별+사진)
          -> PermissionRequest (카메라/알림/위치, 각각 허용/나중에)
            -> Welcome (기능 소개 3카드 스와이프)
              -> PetMain (내 아이 탭 진입)
```

**핵심 제약**: 펫 등록 완료 전까지 메인 탭 진입 불가. "등록하기" 버튼은 이름+종 완료 시에만 활성화.

### Flow 2 -- 의료기록 추가 (OCR)

```
PetMain/PetDetail -> FAB(+) 탭
  -> RecordAdd_Selector (바텀시트: OCR촬영(권장) / 직접입력)
    -> [OCR 선택] RecordAdd_OCR_Camera (가이드 프레임 + 촬영)
      -> 촬영 결과 미리보기 (재촬영/사용)
        -> RecordAdd_OCR_Confirm (자동추출 필드 + 인라인 수정)
          -> 저장 -> 토스트 "기록이 저장되었어요" + 타임라인 갱신
    -> [직접 입력] RecordAdd_Manual (수동 폼 -> 저장)
```

### Flow 3 -- 의료기록 조회

```
PetMain -> PetDetail (타임라인 뷰)
  -> 필터 (진료유형 탭 / 기간 필터)
  -> RecordDetail (상세 조회/수정/삭제)
```

**오프라인**: 로컬 SQLite 캐시에서 조회 가능. 오프라인 배너 상단 고정.

### Flow 4 -- 트리아지 챗봇

```
[응급 탭 진입] -> ChatHome (면책 배너 상시 노출)
  -> 펫 선택 (멀티펫 시)
  -> 증상 빠른선택 카드 8개 (2열 그리드) 또는 텍스트 직접 입력
    -> ChatConversation (SSE 스트리밍 + 타이핑 인디케이터)
      -> 트리아지 결과 카드 (3등급: 응급/준응급/경과관찰)
        -> [응급 판정] "지금 응급실로" + [근처 야간 병원 찾기]
        -> [준응급/경과관찰] 홈케어 가이드 + [병원 찾기] 선택적
      -> [대화 저장] 의료기록에 요약 연결 (선택)
```

### Flow 5 -- 펫 전환

```
[어떤 화면에서든] 상단 펫 선택 바
  -> 다른 펫 아바타 탭 -> 크로스페이드 200ms -> 데이터 전환
  -> [+] 버튼 탭 -> PetAdd (펫 등록 폼)
```

**제약**: 응급 대화 중 펫 전환 시 확인 모달 필수 ("현재 대화를 종료하고 전환하시겠어요?")

---

## 3. 확정된 디자인 시스템

### 3-1. 컬러 토큰

#### Primary -- Brand Teal

| 토큰 | HEX | 용도 |
|---|---|---|
| primary-50 | #f0fdfa | 선택 상태 배경 |
| primary-100 | #ccfbf1 | 카드 호버 배경 |
| primary-200 | #99f6e4 | 체크박스 배경 |
| primary-300 | #5eead4 | 비활성 아이콘 (다크) |
| primary-400 | #2dd4bf | 보조 버튼 보더, 다크모드 활성 아이콘 |
| primary-500 | #14b8a6 | **메인 Primary** (버튼, 탭 활성) |
| primary-600 | #0d9488 | 버튼 pressed, 링크 텍스트 |
| primary-700 | #0f766e | 강조 텍스트 |
| primary-800 | #115e59 | 다크모드 텍스트 |
| primary-900 | #134e4a | 최고 강조 |

#### Secondary -- Warm Amber

| 토큰 | HEX | 용도 |
|---|---|---|
| secondary-500 | #f59e0b | 펫 프로필 강조, 접종 배지 |
| secondary-400 | #fbbf24 | 다크모드 버튼/배지 |

#### Accent -- Soft Coral

| 토큰 | HEX | 용도 |
|---|---|---|
| accent-400 | #fb7185 | 다크모드 응급 포인트 |
| accent-500 | #f43f5e | 응급 탭 CTA, "지금 응급" 배너 |
| accent-600 | #e11d48 | 응급 pressed |

#### Semantic

| 의미 | Light | Dark | 배경 Light | 배경 Dark |
|---|---|---|---|---|
| Success | #16a34a (green-600) | #4ade80 (green-400) | #f0fdf4 | #14532d/30% |
| Warning | #d97706 (amber-600) | #fbbf24 (amber-400) | #fffbeb | #451a03/30% |
| Error | #dc2626 (red-600) | #f87171 (red-400) | #fef2f2 | #450a0a/30% |
| Info | #2563eb (blue-600) | #60a5fa (blue-400) | #eff6ff | #1e3a5f/30% |

#### Neutral (Gray)

| 토큰 | Light HEX | 용도 | Dark 매핑 |
|---|---|---|---|
| neutral-0 | #ffffff | 카드 배경 | slate-800 (#1e293b) |
| neutral-50 | #f9fafb | 스크린 배경 | slate-950 (#0f172a) |
| neutral-100 | #f3f4f6 | 입력 필드 배경 | slate-800 |
| neutral-200 | #e5e7eb | 비활성 보더 | slate-700 (#334155) |
| neutral-300 | #d1d5db | placeholder | slate-600 |
| neutral-400 | #9ca3af | 보조 아이콘 | slate-500 |
| neutral-500 | #6b7280 | Caption 텍스트 | slate-400 (#94a3b8) |
| neutral-600 | #4b5563 | Body 보조 텍스트 | slate-400 |
| neutral-700 | #374151 | Body 메인 텍스트 | slate-300 |
| neutral-800 | #1f2937 | Heading 텍스트 | slate-200 (#e2e8f0) |
| neutral-900 | #111827 | 최고 강조 | slate-50 (#f8fafc) |

### 3-2. 타이포그래피

**폰트**: Pretendard (Static OTF, 4웨이트: Regular/Medium/SemiBold/Bold)
**Fallback**: iOS -apple-system (San Francisco), Android Roboto

| 레벨 | size | lineHeight | weight | Nativewind |
|---|---|---|---|---|
| Display | 32px | 40px | Bold | `text-32 font-pretendard-bold` |
| H1 | 28px | 36px | Bold | `text-28 font-pretendard-bold` |
| H2 | 22px | 30px | SemiBold | `text-22 font-pretendard-semibold` |
| H3 | 18px | 26px | SemiBold | `text-[18px] leading-[26px] font-pretendard-semibold` |
| H4 | 16px | 24px | Medium | `text-base leading-6 font-pretendard-medium` |
| Body L | 16px | 24px | Regular | `text-base leading-6 font-pretendard-regular` |
| Body M | 14px | 22px | Regular | `text-sm leading-[22px] font-pretendard-regular` |
| Body S | 13px | 20px | Regular | `text-13 font-pretendard-regular` |
| Label | 15px | 20px | SemiBold | `text-15 font-pretendard-semibold` |
| Caption | 12px | 16px | Regular | `text-xs leading-4 font-pretendard-regular` |
| Caption Bold | 12px | 16px | Medium | `text-xs leading-4 font-pretendard-medium` |
| Overline | 11px | 16px | SemiBold | `text-11 font-pretendard-semibold tracking-wider` |

### 3-3. 스페이싱

**기본 단위**: 4px (1 unit). 모든 스페이싱은 4의 배수.

| 토큰 | px | Tailwind | 주요 용도 |
|---|---|---|---|
| space-1 | 4px | `p-1` | 아이콘 내부 |
| space-2 | 8px | `p-2` | 배지/태그 내부 |
| space-3 | 12px | `p-3` | 버튼 세로, 카드 간 간격 |
| space-4 | 16px | `p-4` | 카드 내부, 섹션 간격 기본 |
| space-5 | 20px | `p-5` | **화면 좌우 여백 (Screen Padding)** |
| space-6 | 24px | `p-6` | 섹션 헤더 패딩 |
| space-8 | 32px | `p-8` | 섹션 간 여백 |

**화면 레이아웃**: 좌우 여백 20px, 4컬럼 그리드, Gutter 12px

### 3-4. Border Radius

| 토큰 | px | 용도 |
|---|---|---|
| DEFAULT | 6px | 태그, 배지, 소형 버튼 |
| md | 10px | 입력 필드, 소형 카드 |
| lg | 12px | 기본 카드, 버튼 |
| xl | 16px | 대형 카드, 바텀시트 상단 |
| 2xl | 20px | 펫 프로필 카드, 온보딩 |
| full | 9999px | 아바타, 토글, 알약형 배지 |

### 3-5. 그림자 (Shadow)

| 토큰 | 값 | 용도 |
|---|---|---|
| shadow-xs | 0 1px 2px rgba(0,0,0,0.06) | 카드 미세 구분 |
| shadow-sm | 0 2px 4px rgba(0,0,0,0.08) | 기본 카드 |
| shadow-md | 0 4px 8px rgba(0,0,0,0.10) | 버튼, 탭바 |
| shadow-lg | 0 8px 16px rgba(0,0,0,0.12) | 모달, 바텀시트 |
| shadow-xl | 0 16px 32px rgba(0,0,0,0.14) | 응급 CTA 버튼 |

**다크모드**: 그림자 대신 `border border-slate-700`으로 레이어 구분.

---

## 4. 컴포넌트 목록 (확정)

### 4-1. 버튼 (5종)

| Variant | 용도 | Light 스타일 | 크기 |
|---|---|---|---|
| Primary | 주요 CTA (기록 저장, 펫 등록) | bg-primary-500 text-white rounded-xl | L(48px) 기본 |
| Secondary | 보조 CTA (취소, 공유) | bg-white border-primary-400 text-primary-600 | L(48px) |
| Ghost | 텍스트형 (스킵, 링크) | bg-transparent text-neutral-600 | L(48px) |
| Danger | 삭제, 탈퇴 | bg-red-600 text-white | L(48px) |
| Emergency | 응급 탭 전용 CTA | bg-accent-500 text-white shadow-xl | XL(56px) |

**버튼 사이즈**:
- XL: 56px 높이, 24px 가로 패딩, 17px Bold
- L (기본): 48px 높이, 20px 패딩, 15px SemiBold
- M: 40px 높이, 16px 패딩, 14px SemiBold
- S: 32px 높이, 12px 패딩, 13px Medium
- Icon-only: 44x44px (최소 터치 영역 보장)

### 4-2. 인풋 (4종)

| 종류 | 특징 |
|---|---|
| TextInput | Label + Field(48px) + Helper. bg-neutral-100, focus: border-primary-500 |
| TextArea | 100-200px 높이, multiline |
| SearchInput | 좌측 아이콘 + X 지우기, rounded-full, 44px |
| Select (Picker) | TextInput 외형 + ChevronDown, iOS ActionSheet |

### 4-3. 카드 (5종)

| 종류 | 핵심 스펙 |
|---|---|
| PetCard | 펫 사진(72px 원형) + 이름 + 종/나이. rounded-2xl shadow-md |
| MedicalRecordCard | 타임라인 아이템. rounded-xl border-l-4 (카테고리별 색상) shadow-xs |
| UserBubble | 우측 정렬. bg-primary-500 text-white rounded-2xl rounded-tr-sm max-w-75% |
| BotBubble | 좌측 정렬. bg-neutral-100 rounded-2xl rounded-tl-sm max-w-80% |
| SymptomQuickCard | 응급 탭 8개 그리드. 80px 높이. 아이콘(32px) + 텍스트 |

### 4-4. 배지 (3종 + 보조)

#### 트리아지 배지 (3등급)

| 등급 | 색상 | 아이콘 | 텍스트 | 추가 효과 |
|---|---|---|---|---|
| 응급 | bg-red-600 border-2 border-red-700 | AlertCircle (white) | "응급" Bold | pulse 애니메이션 |
| 준응급 | bg-amber-500 border-2 border-amber-600 | Clock (white) | "준응급" Bold | 없음 |
| 경과관찰 | bg-green-600 | Eye (white) | "경과관찰" SemiBold | 없음 |

**색각 이상 대응**: 색상 + 아이콘 + 텍스트 3중 신호 필수.

#### D-day 배지 (접종 일정)

| 조건 | 스타일 |
|---|---|
| D-7 이내 | bg-red-100 text-red-700 |
| D-30 이내 | bg-amber-100 text-amber-700 |
| D-30 초과 | bg-neutral-100 text-neutral-600 |

#### 의료기록 카테고리 배지

| 카테고리 | 컬러 | border-l 컬러 |
|---|---|---|
| 진료 | bg-primary-100 text-primary-700 | border-l-primary-500 |
| 접종 | bg-secondary-100 text-secondary-700 | border-l-secondary-500 |
| 검진 | bg-blue-100 text-blue-700 | border-l-blue-500 |
| 처방 | bg-purple-100 text-purple-700 | border-l-purple-500 |
| 기타 | bg-neutral-100 text-neutral-600 | border-l-neutral-400 |

### 4-5. 네비게이션 컴포넌트

| 종류 | 핵심 스펙 |
|---|---|
| BottomTabBar | 83px(SafeArea 포함). 3탭 균등. 활성: primary-500(filled). 응급 탭 활성: accent-500 |
| Header | 56px. 좌: 뒤로/로고. 중앙: 제목(H4). 우: 액션 아이콘 최대 2개 |
| BottomSheet | 오버레이 bg-black/50. rounded-t-3xl. 핸들 바. 스냅: 25%/50%/90% |

### 4-6. 피드백 컴포넌트

| 종류 | 핵심 스펙 |
|---|---|
| Toast | 하단(탭바 위 8px). 자동 닫힘 3초(성공)/5초(에러). 4 Variant |
| Modal | 오버레이 bg-black/50. rounded-2xl mx-5. Primary + Ghost 버튼 배치 |
| InlineBanner | 면책 고지 전용. bg-amber-50 border-amber-200. 항상 노출, 접기 불가 |

### 4-7. 특수 컴포넌트

| 종류 | 핵심 스펙 |
|---|---|
| OCROverlay | 반투명 검정 배경 + 중앙 투명 영역(dashed 흰색 보더). 촬영 버튼 72px 원형 |
| Timeline | 수직선(w-px neutral-200) + 노드점(w-3 카테고리별 색상) + 의료기록 카드 |
| ProgressIndicator | 3-4단계 dot. 비활성 w-2 neutral-200. 활성 w-6 primary-500 pill |
| SkeletonLoader | shimmer 좌->우 1.2초 반복. neutral-200 -> neutral-100 |
| DisclaimerBubble | 챗봇 고정. bg-amber-50 border-amber-200 rounded-xl. InfoCircle 아이콘 |

---

## 5. 아이콘 시스템

**Primary Set**: Lucide Icons (MIT, react-native-lucide-icons)

| 규칙 | 값 |
|---|---|
| 기본 strokeWidth | 1.5px |
| 강조 strokeWidth | 2px |
| 탭바 활성 | 2.5px stroke 또는 filled |
| 최소 터치 영역 | 44x44px (아이콘 크기 무관) |
| 사용 크기 | 16/20/24/32/40/64px |

**탭바 아이콘**: PawPrint(내 아이), HeartPulse(응급), LayoutGrid(더보기)

**커스텀 SVG 필요 목록** (Lucide 미보유):
- PawPrint Filled (탭바 활성)
- Syringe (주사/접종)
- Dog/Cat 실루엣 (온보딩)
- Pill (처방)

---

## 6. 인터랙션 & 모션

### 6-1. 트랜지션

| 인터랙션 | 방식 | 시간 |
|---|---|---|
| 탭 전환 | **즉시 전환 (0ms)** | 응급 탭 접근성 최우선 |
| 스택 푸시 | 슬라이드 왼쪽 (iOS 기본) | 300ms |
| 펫 전환 | 크로스페이드 | 200ms |
| OCR 결과 로드 | 스켈레톤 -> 콘텐츠 (필드별 순차) | 필드별 |
| 트리아지 결과 등장 | 슬라이드업 ease-out | 350ms |
| 타임라인 새 항목 | 페이드인 + 슬라이드다운 | 400ms |
| Emergency pulse | opacity 1.0->0.7 반복 | 1.5초 주기 |

### 6-2. 햅틱 피드백

| 트리거 | 유형 |
|---|---|
| OCR 촬영 | Impact (Medium) |
| 저장 완료 | Notification (Success) |
| 에러/경고 | Notification (Error) |
| 응급도 "응급" 결과 | **Impact (Heavy)** |
| 펫 전환 | Impact (Light) |

### 6-3. 제스처

| 화면 | 제스처 | 동작 |
|---|---|---|
| 타임라인 카드 | 스와이프 왼쪽 | 삭제 버튼 노출 |
| 챗봇 대화 | 스와이프 아래 | 키보드 dismiss |
| 이미지 썸네일 | 탭 | 전체화면 뷰어 모달 |
| 전체화면 이미지 | 핀치 줌 / 스와이프 아래 | 확대축소 / 닫기 |
| 펫 선택 바 | 수평 스크롤 | 펫 목록 탐색 |

### 6-4. Reduce Motion 대응

`prefers-reduced-motion` 또는 iOS "동작 줄이기" 활성화 시:
- 모든 트랜지션 -> 즉시 전환 (duration: 0)
- pulse 애니메이션 -> 정적 표시 (대신 border 2px로 강조)
- 스켈레톤 shimmer -> 정적 회색 배경

---

## 7. 접근성 기준 (확정)

| 항목 | 기준 |
|---|---|
| 텍스트 대비비 | Body 이상 WCAG AA (4.5:1), Large Text 3:1 |
| 트리아지 배지 대비비 | 다크모드 포함 WCAG AAA (7:1) 목표 |
| 터치 타겟 | 최소 44x44pt |
| VoiceOver | 모든 인터랙티브 요소 accessibilityLabel 필수 |
| 응급도 배지 | 색상 + 아이콘 + 텍스트 3중 신호 (색상 단독 금지) |
| Dynamic Type | allowFontScaling 제한적 허용 (최소 14px 보장) |
| Reduce Motion | 전체 애니메이션 즉시 전환 대체 |

---

## 8. 프론트엔드 전달 사항

### 8-1. tailwind.config.js 전체 스펙 (확정, 그대로 사용)

UI 디자이너가 작성한 `tailwind.config.js` 전체 스펙(섹션 10)을 **그대로 채택**한다. 변경 사항 없음. 해당 파일을 프로젝트 루트에 배치할 것.

### 8-2. 구현 시 핵심 주의사항

**[P0] 반드시 지켜야 할 사항**

1. **응급 탭 즉시 진입**: 탭 아이콘 탭 시 ChatHome이 즉시 표시되어야 한다. 중간 랜딩 페이지, 로딩 화면, 애니메이션 전이 없음. lazy loading도 금지 -- 앱 초기화 시 응급 탭 컴포넌트를 미리 마운트할 것.
2. **면책 배너 항상 노출**: ChatHome과 ChatConversation 모두에서 면책 배너가 스크롤 시에도 상단 고정(sticky). 앱스토어 리뷰어가 어떤 시점에서든 면책 고지를 볼 수 있어야 함.
3. **트리아지 배지 3중 신호**: 색상만으로 응급도를 구분하지 말 것. 반드시 아이콘 + 텍스트 병기.
4. **오프라인 의료기록 조회**: 의료기록 데이터는 로컬 SQLite에 캐시. 네트워크 없어도 내 아이 탭은 정상 작동해야 함.
5. **Pretendard 폰트 4웨이트 번들링**: Static OTF 파일 4개(Regular/Medium/SemiBold/Bold)를 assets에 포함. Variable Font 사용 금지 (React Native 미지원).

**[P1] 강력 권고**

6. **펫 전환 시 크로스페이드**: 데이터 교체 시 200ms 크로스페이드로 시각적 끊김 완화. `Animated.View` opacity 전환.
7. **OCR 카메라 가이드 프레임**: 중앙 투명 영역 외 반투명 딤 오버레이. 촬영 버튼 탭 시 햅틱 피드백 필수.
8. **챗봇 SSE 스트리밍**: 타이핑 인디케이터(점 3개 pulse) -> 텍스트 스트리밍 -> 완료 시 트리아지 결과 카드 슬라이드업.
9. **다크모드 Shadow 대체**: 다크 배경에서 boxShadow는 비가시. `border border-slate-700`으로 레이어 구분.
10. **Emergency pulse 애니메이션**: `Animated.loop`으로 opacity 1.0->0.7 반복, 1.5초 주기. Reduce Motion 시 정적.

**[P2] 권고**

11. **스켈레톤 로딩**: 데이터 fetch 중 스켈레톤 UI 표시. animate-pulse 사용.
12. **바텀시트 스냅**: 25%/50%/90% 3단계 스냅 포인트.
13. **타임라인 스와이프 삭제**: 좌 스와이프 시 삭제 버튼 노출. 확인 모달 후 삭제.

### 8-3. 컴포넌트 개발 순서 권고

프론트엔드팀이 컴포넌트를 개발할 때 다음 순서를 권고한다. 의존성이 높은 기초 컴포넌트를 먼저 만들어야 페이지 조립이 원활하다.

```
Layer 0 (디자인 토큰):
  tailwind.config.js + global.css + Pretendard 폰트 설정

Layer 1 (Atom):
  Button (5종) -> TextInput -> SearchInput -> Select
  -> Badge (트리아지 3종 + D-day + 카테고리)
  -> Icon wrapper (Lucide + 커스텀 SVG)

Layer 2 (Molecule):
  PetCard -> MedicalRecordCard -> SymptomQuickCard
  -> ChatBubble (User + Bot + Typing)
  -> DisclaimerBanner -> Toast -> Modal -> BottomSheet
  -> Header -> BottomTabBar

Layer 3 (Organism):
  PetSelectorBar -> Timeline -> OCROverlay -> TriageResultCard
  -> OnboardingProgressIndicator -> EmptyState -> ErrorState

Layer 4 (Page):
  PetMain -> PetDetail -> RecordAdd (OCR + Manual)
  -> ChatHome -> ChatConversation
  -> MoreMain -> 나머지 설정 화면
  -> 온보딩 플로우 7화면
```

---

## 9. 디자인 우선순위 (Phase 0 로드맵)

### Phase 0-A (MVP 핵심 -- 반드시 완성)

이 화면들이 없으면 앱의 핵심 가치를 전달할 수 없다.

| 우선순위 | 화면 | 이유 |
|---|---|---|
| 1 | PetMain (내 아이 탭 메인) | 앱 진입 후 첫 화면. 전체 경험의 기준점 |
| 2 | ChatHome (응급 탭 홈) | 앱의 핵심 차별화 기능 진입점 |
| 3 | ChatConversation + TriageResultCard | 트리아지 결과 없이는 응급 기능 무의미 |
| 4 | PetRegister (온보딩 펫 등록) | 펫 없이는 앱 사용 불가 |
| 5 | DisclaimerConsent (면책 동의) | 앱스토어 심사 필수. 없으면 리젝 |
| 6 | RecordAdd_Manual (수동 기록 입력) | 의료기록 추가의 기본 경로 |
| 7 | PetDetail + Timeline | 기록 조회의 기본 화면 |

### Phase 0-B (MVP 보강 -- 높은 우선순위)

핵심 경험을 완성하기 위해 필요하지만, 0-A 이후 작업 가능.

| 우선순위 | 화면 | 이유 |
|---|---|---|
| 8 | RecordAdd_OCR (카메라 + 결과 확인) | OCR은 킬러 피처지만 수동 입력으로 대체 가능 |
| 9 | AuthScreen (소셜 로그인) | 인증 없이 테스트 가능하지만 배포 전 필수 |
| 10 | Welcome + 온보딩 나머지 | 첫인상에 중요하지만 기능적 우선순위는 낮음 |
| 11 | MoreMain + ProfileEdit | 설정 기능 |

### Phase 0-C (MVP 부가 -- 시간 허용 시)

없어도 MVP 출시 가능. Phase 1으로 이월 가능.

| 우선순위 | 화면 | 이유 |
|---|---|---|
| 12 | HospitalMap + HospitalDetail | 응급 시 가치 있지만 외부 지도 앱 딥링크로 대체 가능 |
| 13 | NotificationSettings | Phase 0에서 알림 자체가 미구현일 수 있음 |
| 14 | RecordDetail (수정/삭제) | 조회만으로 MVP 가능, 수정은 후순위 |
| 15 | 빈 상태 / 에러 화면 일러스트 | 텍스트 기반 빈 상태로 대체 가능 |

---

## 10. 다크모드 운영 가이드 (확정)

### 기본 원칙

- Nativewind v4 기본값(media query) 사용. `darkMode` 설정 불필요.
- 모든 컴포넌트에 `dark:` 접두사 병기 필수.
- 이미지는 다크모드에서 `opacity-90` 적용.
- Primary-500은 라이트/다크 동일 사용 (충분한 대비비).

### 패턴 요약

```
배경:        bg-white dark:bg-slate-900
카드:        bg-white dark:bg-slate-800
텍스트:      text-neutral-800 dark:text-slate-200
보조 텍스트: text-neutral-500 dark:text-slate-400
보더:        border-neutral-200 dark:border-slate-700
구분선:      bg-neutral-100 dark:bg-slate-800
```

### CSS 변수 (global.css)

```css
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

## 11. 핵심 화면별 레이아웃 확정

### 11-1. PetMain (내 아이 탭 메인)

```
+----------------------------------+
| [앱로고]                  [알림] |  <- Header 56px
+----------------------------------+
| [초코] [뭉치] [+]               |  <- PetSelectorBar (수평 스크롤)
+----------------------------------+
| +------------------------------+ |
| | [사진72px] 초코               | |  <- PetCard (rounded-2xl shadow-md)
| |            말티즈 . 4세 . 수컷| |
| |            마지막 진료: 3일 전 | |
| +------------------------------+ |
|                                  |
| 의료기록           [전체 보기 >] |  <- 섹션 헤더
| +------------------------------+ |
| | 2026.04.10 | 정기검진        | |  <- MedicalRecordCard (최근 3건)
| | 행복동물병원                  | |
| +------------------------------+ |
| | 2026.03.22 | 예방접종        | |
| | 심장사상충 예방약             | |
| +------------------------------+ |
|                            [FAB] |  <- 우하단 고정 56x56px
+----------------------------------+
| [내 아이]  [응급]   [더보기]     |  <- BottomTabBar 83px
+----------------------------------+
```

### 11-2. ChatHome (응급 탭 홈)

```
+----------------------------------+
| 응급 상담                        |  <- Header (text-accent-500)
+----------------------------------+
| [!] 이 정보는 수의사 진료를      |  <- DisclaimerBanner (sticky)
|    대체하지 않습니다             |
+----------------------------------+
| 어떤 아이 증상인가요?            |  <- 펫 선택 (멀티펫만)
| [초코] [뭉치]                    |
+----------------------------------+
| 어떤 증상인가요?                 |
|                                  |
| [구토/구역] [설사/혈변]          |  <- SymptomQuickCard 2열 그리드
| [외상/출혈] [호흡 이상]          |     각 80px 높이
| [경련/발작] [먹지 않음]          |
| [음수 이상] [기타    ]           |
+----------------------------------+
| [직접 입력해주세요...]    [전송] |  <- TextInput + 전송 버튼
+----------------------------------+
```

### 11-3. ChatConversation (챗봇 대화)

```
+----------------------------------+
| <- 응급 홈    초코 상담          |  <- Header
+----------------------------------+
| [!] 수의사 진료를 대체하지       |  <- DisclaimerBanner (축소형, sticky)
|    않습니다                      |
+----------------------------------+
|                                  |
|         [초코가 구토/구역       ]|  <- UserBubble (우측)
|         [증상을 보이고 있어요   ]|
|                         오후 2:35|
|                                  |
| [안녕하세요! 초코의 구토 증상에 ]|  <- BotBubble (좌측)
| [대해 알려주세요...             ]|
|                                  |
| +------------------------------+ |
| | [준응급]  Clock               | |  <- TriageResultCard
| |                               | |     bg-amber-50 border-2 border-amber-500
| | 체크해주세요                  | |
| | . 구토 횟수 3회 이상?         | |
| | . 혈액 섞여있나요?            | |
| |                               | |
| | 오늘 내 동물병원 방문을        | |
| | 권장해요                      | |
| +------------------------------+ |
|                                  |
| [근처 병원 찾기]   [대화 저장]   |  <- 액션 버튼
+----------------------------------+
| [증상을 입력해주세요...]  [전송] |  <- 하단 고정 입력창
+----------------------------------+
```

---

## 12. 컴포넌트 상태 정의 (전체 적용)

모든 인터랙티브 컴포넌트는 다음 5가지 상태를 구현해야 한다.

| 상태 | 시각 처리 | 접근성 |
|---|---|---|
| Default | 기본 스타일 | - |
| Hover/Focus | 경계선 강조 + 배경 변경 (Focus: ring-2 ring-primary-500) | 포커스 인디케이터 필수 |
| Pressed/Active | 배경 어둡게 (darker shade 또는 opacity) | - |
| Disabled | opacity-50 또는 neutral-200 bg | `accessibilityState={{ disabled: true }}` |
| Loading | ActivityIndicator 또는 Skeleton | `accessibilityState={{ busy: true }}` |

---

## 부록 A: 확정된 tailwind.config.js

UI 디자이너 산출물의 섹션 10 `tailwind.config.js` 전체 스펙을 그대로 채택한다. 프론트엔드팀은 해당 파일을 복사하여 프로젝트 루트에 배치할 것. 추가 수정이 필요한 경우 디자인팀장 승인 후 진행.

## 부록 B: 디자인 QA 체크리스트

프론트엔드 구현 완료 후, 디자인팀이 아래 항목을 기준으로 QA를 진행한다.

- [ ] 모든 화면 좌우 여백 20px 준수
- [ ] 버튼 최소 터치 영역 44x44px 준수
- [ ] 트리아지 배지 3중 신호 (색상+아이콘+텍스트) 확인
- [ ] 면책 배너 스크롤 시 상단 고정 확인
- [ ] 응급 탭 진입 시 애니메이션 없이 즉시 표시 확인
- [ ] 다크모드 전체 화면 대비비 WCAG AA 충족 확인
- [ ] 트리아지 배지 다크모드 대비비 AAA 목표 확인
- [ ] Pretendard 폰트 4웨이트 정상 렌더링 확인
- [ ] 오프라인 모드에서 내 아이 탭 의료기록 조회 가능 확인
- [ ] Reduce Motion 활성화 시 모든 애니메이션 비활성 확인
- [ ] VoiceOver로 전체 플로우 탐색 가능 확인

---

*본 문서는 디자인팀장이 UX/UI 산출물을 종합하여 작성한 최종 확정안이다.*
*프론트엔드팀은 이 문서를 기준으로 구현하며, 스펙 변경은 디자인팀장 승인을 거쳐야 한다.*
*다음 단계: 프론트엔드팀 + 백엔드팀 핸드오프 및 병렬 개발 착수.*
