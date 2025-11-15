---
layout: default
title: 주문
---

# 주문 목록

<table>
    <thead>
        <tr>
            <th>주문명</th>
            <th>주문레벨</th>
            <th>주문 설명</th>
            <th>학파</th>
            <th>효과</th>
            <th>특수효과</th>
        </tr>
    </thead>
    <tbody>
        {% for spell in site.data.spell_save %}
        <tr>
            <td>[{{ spell.name }}](spell_single.html?spell={{ spell.name }})</td>
            <td>{{ spell.level }}</td>
            <td>{{ spell.desc }}</td>
            <td>{{ spell.spty }}</td>
            <td>피해: {{ spell.dmg }}<br>방어: {{ spell.def }}<br>체력: {{ spell.hlt }}</td>
            <td>{{ spell.btds }}</td>
        </tr>
        {% endfor %}
    </tbody>
</table>

