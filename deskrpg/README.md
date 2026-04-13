# deskRPG 연동 가이드

## 설치 완료

deskRPG가 `~/.deskrpg/`에 초기화됨 (SQLite 모드).

## 실행 방법

```bash
npx deskrpg start
```

브라우저에서 접속하여 2D 가상 오피스 확인.

## 설정 파일 위치

- 환경변수: `~/.deskrpg/.env.local`
- 데이터베이스: `~/.deskrpg/data/deskrpg.db`
- 로그: `~/.deskrpg/logs/`
- 업로드: `~/.deskrpg/uploads/`

## AI NPC 연동 (OpenClaw)

AI 에이전트를 deskRPG NPC로 연결하려면:

1. `~/.deskrpg/.env.local`에서 OpenClaw 설정:
   ```
   OPENCLAW_TOKEN=your-token
   OPENCLAW_MODEL=anthropic/claude-sonnet-4-20250514
   ```

2. deskRPG 웹 UI에서 Settings → OpenClaw Gateway 연결

3. 오피스에서 "Hire AI Employee" → 에이전트 페르소나 설정

## Team Makes 에이전트 매핑

| 에이전트 | deskRPG NPC 역할 | 위치 |
|---------|-----------------|------|
| 기획자 | Research Analyst | 기획실 |
| 디자이너 | UI/UX Designer | 디자인 스튜디오 |
| 프론트엔드개발자 | Frontend Dev | 개발실 |
| 백엔드개발자 | Backend Dev | 서버실 |

## PostgreSQL 모드로 전환 (선택)

더 안정적인 환경을 원한다면:

```bash
# ~/.deskrpg/.env.local 수정
DATABASE_URL=postgresql://deskrpg:deskrpg_dev_pw@localhost:5437/deskrpg
# DB_TYPE=sqlite 라인 주석 처리
# SQLITE_PATH 라인 주석 처리
```

Docker로 PostgreSQL 실행:
```bash
docker run -d --name deskrpg-db \
  -e POSTGRES_USER=deskrpg \
  -e POSTGRES_PASSWORD=deskrpg_dev_pw \
  -e POSTGRES_DB=deskrpg \
  -p 5437:5432 \
  postgres:16-alpine
```
