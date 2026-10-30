github.io 블로그

https://yangjaedeok.github.io

[Quarto](https://quarto.org)로 만든 정적 블로그입니다. 글 안에서 코드 실행 결과, 3D 그래프, 슬라이더로 바뀌는 시각화를 쓸 수 있습니다.

## 카테고리 구조

```
Physics
├── Quantum Information
├── Quantum Mechanics
└── Thermal and Statistical Physics
Programming
Computer Science
├── Classical Computing
└── Quantum Computing
Projects
Design
```

- **Physics**: 전공 문제 풀이, 계산과 시뮬레이션, 시각화. 하위는 전공별로 나눕니다.
- **Programming**: 개인 학습 및 부트캠프, Python, ML, DL, AI
- **Computer Science**: 컴퓨터 과학. 하위로 고전 컴퓨터와 양자 컴퓨터를 함께 봅니다.
- **Projects**: 개인 프로젝트
- **Design**: 디자인

Quarto의 카테고리는 계층이 없는 평면 태그라서, 하위 주제의 글에는 **상위와 하위 카테고리를 모두** 붙입니다.

```yaml
categories: [Computer Science, Quantum Computing]
```

상단 메뉴와 `topics/` 폴더의 목록 페이지가 이 태그를 기준으로 글을 모아 보여 줍니다. 새 하위 주제를 추가하려면 `topics/<분류>/`에 목록 페이지를 만들고 `_quarto.yml`의 메뉴에 넣습니다.

- 목록 페이지의 `include` 카테고리 문자열은 글에 붙이는 카테고리와 **철자와 대소문자까지 같아야** 합니다.
- 목록 페이지는 `topics/<분류>/`처럼 한 단계 깊은 폴더에 있으므로, 글을 찾는 경로는 `contents: "../../posts/*/index.qmd"`로 씁니다. 경로가 틀리면 목록이 에러 없이 비어 보입니다.
- 메뉴의 `href`에는 `.qmd` 확장자까지 적습니다.

## 폴더 구성

| 경로 | 역할 |
| --- | --- |
| `posts/<슬러그>/index.qmd` | 글 한 편 (글마다 폴더 하나) |
| `posts/<슬러그>/*.py` | 그 글에서만 쓰는 파이썬 코드 |
| `lib/` | 여러 글이 같이 쓰는 파이썬 코드 (필요할 때 만듦) |
| `topics/<분류>/*.qmd` | 카테고리별 글 목록 페이지 (분류별 하위 폴더) |
| `_quarto.yml` | 사이트 설정, 상단 메뉴, 푸터 |
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

### 코드를 `.py` 파일로 둘 때

```
posts/<폴더 이름>/surface.py   이 글 전용 코드
lib/                           여러 글이 같이 쓰는 코드 (필요할 때 만듦)
```

- 불러오기: `from surface import make_surface`
- 코드 내용 보여 주기: 코드 블록 안에 `{{< include surface.py >}}`
- `lib/`는 셀 위에서 `sys.path.insert(0, str(pathlib.Path.cwd().parents[1] / "lib"))`
- **`.py`만 고치면 `freeze`가 결과를 갱신하지 않습니다.** `quarto render posts/<폴더 이름>/index.qmd`로 그 글만 렌더링하고 `_freeze/`도 같이 커밋합니다. Actions에는 Python이 없어서 대신 해 주지 않습니다.

## License

- **Source Code**: This blog's source code is licensed under the [MIT License](LICENSE).
- **Content & Articles**: All written posts, articles, and media are licensed under [CC BY-NC-SA 4.0](https://creativecommons.org).
