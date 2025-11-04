---
layout: default
title: Traits 목록
---

# 🧩 Traits 목록

<div>
    <label for="tagFilter">태그로 검색: </label>
    <input id="tagFilter" type="text" placeholder="예: test, magic" />
    <small>(쉼표/공백으로 여러 태그 입력, 모두 포함 AND 검색)</small>
}</div>

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
        <tr data-tags="{{ trait.tags | join: ',' | downcase }}">
            <td>{{ trait.name }}</td>
            <td><code>{{ trait.comm }}</code><br>{{ trait.desc }}</td>
            <td>{{ trait.tags | join: ", " }}</td>
        </tr>
        {% endfor %}
    </tbody>
</table>

<script>
  (function () {
    var input = document.getElementById('tagFilter');
    if (!input) return;
    var tbody = document.querySelector('table tbody');
    if (!tbody) return;
    var rows = Array.prototype.slice.call(tbody.querySelectorAll('tr'));

    function normalizeTokens(value) {
      return value
        .toLowerCase()
        .split(/[\s,]+/)
        .map(function (t) { return t.trim(); })
        .filter(function (t) { return t.length > 0; });
    }

    function applyFilter() {
      var q = input.value || '';
      var tokens = normalizeTokens(q);
      if (tokens.length === 0) {
        rows.forEach(function (tr) { tr.style.display = ''; });
        return;
      }
      rows.forEach(function (tr) {
        var tags = (tr.getAttribute('data-tags') || '').split(',');
        var matchAll = tokens.every(function (tk) {
          return tags.some(function (tg) { return tg.indexOf(tk) !== -1; });
        });
        tr.style.display = matchAll ? '' : 'none';
      });
    }

    input.addEventListener('input', applyFilter);
  })();
</script>