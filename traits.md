---
layout: default
title: Traits 목록
---

# 🧩 Traits 목록

<table>
    <thead>
        <tr>
            <th>이름</th>
            <th>설명</th>
            <th>태그</th>
        </tr>
    </thead>
    <tbody>
        {% for trait in site.data.traits_save %}
        <tr>
            <td>{{ trait.name }}</td>
            <td><code>{{ trait.comm }}</code><br>{{ trait.desc }}</td>
            <td>{{ trait.tags | join: ", " }}</td>
        </tr>
        {% endfor %}
    </tbody>
</table>