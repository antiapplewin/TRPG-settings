---
layout: default
title: Traits 목록
---

# 🧩 Traits 목록

| 이름 | 카테고리 | 태그 | 설명 |
|------|-----------|------|------|
{% for trait in site.data.traits_save %}
| **{{ trait.name }}** | {{ trait.category }} | {{ trait.tags | join: ", " }} | {{ trait.desc }} |
{% endfor %}

---

_총 {{ site.data.traits_save | size }}개의 Trait이 있습니다._
