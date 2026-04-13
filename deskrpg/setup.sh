#!/bin/bash
# Team Makes - deskRPG 셋업 스크립트
# 사용법: bash setup.sh

echo "=== Team Makes - deskRPG 설정 ==="

# deskRPG가 이미 초기화되었는지 확인
if [ ! -d "$HOME/.deskrpg" ]; then
  echo "[1/3] deskRPG 초기화 중..."
  npx deskrpg init
else
  echo "[1/3] deskRPG 이미 초기화됨 ($HOME/.deskrpg)"
fi

# .env.local 업데이트 (OpenClaw 모델을 Claude로 설정)
echo "[2/3] 환경 변수 확인..."
ENV_FILE="$HOME/.deskrpg/.env.local"

if grep -q "OPENCLAW_MODEL=openai-codex" "$ENV_FILE" 2>/dev/null; then
  echo "  → OpenClaw 모델을 Claude로 변경합니다."
  sed -i '' 's/OPENCLAW_MODEL=openai-codex\/gpt-5.4/OPENCLAW_MODEL=anthropic\/claude-sonnet-4-20250514/' "$ENV_FILE"
  echo "  ✓ OPENCLAW_MODEL=anthropic/claude-sonnet-4-20250514"
fi

echo ""
echo "[3/3] 설정 완료!"
echo ""
echo "다음 단계:"
echo "  1. ~/.deskrpg/.env.local 에서 토큰 설정"
echo "     - JWT_SECRET: 랜덤 64자 문자열"
echo "     - OPENCLAW_TOKEN: OpenClaw 인증 토큰"
echo ""
echo "  2. deskRPG 실행:"
echo "     npx deskrpg start"
echo ""
echo "  3. 브라우저에서 접속 후 AI 직원 고용!"
echo ""
