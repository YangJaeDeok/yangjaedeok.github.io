#!/usr/bin/env bash
# 렌더링 전에 모든 글의 댓글 설정을 검사한다. 하나라도 어긋나면 빌드를 멈춘다.
#   1. front matter에 giscus-id가 있다 (소문자, 숫자, 하이픈만)
#   2. giscus-id가 다른 글과 겹치지 않는다
#   3. 글 안에 댓글 삽입 줄이 있다
set -eu

INCLUDE_LINE='{{< include /_giscus.qmd >}}'
status=0
pairs="$(mktemp)"
trap 'rm -f "$pairs"' EXIT

count=0
for f in posts/*/index.qmd; do
  [ -e "$f" ] || continue
  count=$((count + 1))

  # 첫 번째 --- 와 두 번째 --- 사이(front matter)만 읽는다
  front="$(awk 'NR==1{ if ($0 != "---") exit; next } /^---[[:space:]]*$/{ exit } { print }' "$f")"
  id="$(printf '%s\n' "$front" | sed -n 's/^giscus-id:[[:space:]]*//p' | head -n 1 | tr -d "\"'" | sed 's/[[:space:]]*$//')"

  if [ -z "$id" ]; then
    echo "오류: $f 에 giscus-id가 없습니다." >&2
    status=1
  elif ! printf '%s\n' "$id" | grep -Eq '^[a-z0-9]([a-z0-9-]*[a-z0-9])?$'; then
    echo "오류: $f 의 giscus-id '$id'는 소문자, 숫자, 하이픈만 쓸 수 있습니다." >&2
    status=1
  else
    printf '%s\t%s\n' "$id" "$f" >> "$pairs"
  fi

  if ! grep -qF "$INCLUDE_LINE" "$f"; then
    echo "오류: $f 에 댓글 삽입 줄이 없습니다: $INCLUDE_LINE" >&2
    status=1
  fi
done

dups="$(cut -f1 "$pairs" | sort | uniq -d)"
if [ -n "$dups" ]; then
  for d in $dups; do
    echo "오류: giscus-id '$d'가 여러 글에서 겹칩니다:" >&2
    awk -F'\t' -v id="$d" '$1 == id { print "  - " $2 }' "$pairs" >&2
  done
  status=1
fi

if [ "$status" -ne 0 ]; then
  echo "giscus 설정 검사에 실패했습니다. 위 오류를 고친 뒤 다시 렌더링하세요." >&2
  exit 1
fi
echo "giscus-id 검사 통과: 글 ${count}개"
