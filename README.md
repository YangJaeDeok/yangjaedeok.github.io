github.io 블로그

https://yangjaedeok.github.io

[Quarto](https://quarto.org)로 만든 정적 블로그입니다. 글 안에서 코드 실행 결과, 3D 그래프, 슬라이더로 바뀌는 시각화를 쓸 수 있습니다.

## 카테고리 구조

```
Physics
└── Quantum Information
Programming
Computer Science
├── Classical Computing
└── Quantum Computing
```

- **Physics**: 전공 문제 풀이, 계산과 시뮬레이션, 시각화. 하위는 전공별로 나눕니다.
- **Programming**: 개인 학습 및 부트캠프, Python, ML, DL, AI
- **Computer Science**: 컴퓨터 과학. 하위로 고전 컴퓨터와 양자 컴퓨터를 함께 봅니다.

Quarto의 카테고리는 계층이 없는 평면 태그라서, 하위 주제의 글에는 **상위와 하위 카테고리를 모두** 붙입니다.

```yaml
categories: [Computer Science, Quantum Computing]
```

상단 메뉴와 `topics/` 폴더의 목록 페이지가 이 태그를 기준으로 글을 모아 보여 줍니다. 새 하위 주제를 추가하려면 `topics/`에 목록 페이지를 만들고 `_quarto.yml`의 메뉴에 넣습니다.

## 폴더 구성

| 경로 | 역할 |
| --- | --- |
| `posts/<슬러그>/index.qmd` | 글 한 편 (글마다 폴더 하나) |
| `topics/*.qmd` | 카테고리별 글 목록 페이지 |
| `_quarto.yml` | 사이트 설정, 상단 메뉴 |
| `_freeze/` | 코드 실행 결과 저장본 (코드가 있는 글을 고치면 `quarto render`로 갱신) |

`main`에 push하면 GitHub Actions가 사이트를 빌드해 `gh-pages` 브랜치로 배포합니다.

## 새 글을 쓸 때

`posts/<폴더 이름>/index.qmd`를 만들고, 머리말에 `giscus-id`를 넣고, 글 맨 아래에 댓글 삽입 줄을 둡니다.

```markdown
---
title: "글 제목"
date: "2026-10-28"
categories: [Physics, Quantum Information]
giscus-id: 폴더-이름-그대로
---

본문

{{< include /_giscus.qmd >}}
```

- `giscus-id`는 댓글 스레드를 찾는 **고유값**입니다. 처음에는 폴더 이름과 같게 쓰고(소문자, 숫자, 하이픈), **한 번 정하면 바꾸지 않습니다.** 글 제목이나 폴더 이름을 나중에 바꿔도 이 값이 같으면 댓글이 유지됩니다. 이 값은 GitHub Discussions의 `Comments` 카테고리에서 스레드 제목으로 보입니다.
- 렌더링 전에 `scripts/check-giscus-ids.sh`가 모든 글에 `giscus-id`와 삽입 줄이 있는지, 값이 겹치지 않는지 검사합니다. 어긋나면 빌드가 멈춥니다.
- 홈의 방명록은 이 방식이 아니라 Quarto 내장 설정(`index.qmd`)을 씁니다.

## License

- **Source Code**: This blog's source code is licensed under the [MIT License](LICENSE).
- **Content & Articles**: All written posts, articles, and media are licensed under [CC BY-NC-SA 4.0](https://creativecommons.org).
