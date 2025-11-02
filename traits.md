---
layout: default
title: Traits 목록
---

# 🧩 Traits 목록

{% capture traits_table %}
| 이름 | 설명 | 태그 | 카테고리 |
|------|------|------|-----------|
{% for trait in site.data.traits_save %}
| {{ trait.name }} | {{ trait.desc }} | {{ trait.tags | join: ", " }} | {{ trait.category }} |
{% endfor %}
{% endcapture %}
{{ traits_table | strip | markdownify }}
