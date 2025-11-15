---
layout: default
title: 주문
---

# 주문 목록

<div style="margin-bottom: 20px;">
  <label for="school-filter"><strong>학파 필터:</strong></label>
  <select id="school-filter" onchange="filterBySchool()">
    <option value="">전체</option>
    {% assign schools = site.data.spell_save | map: "spty" | uniq | sort %}
    {% for school in schools %}
    <option value="{{ school }}">{{ school }}</option>
    {% endfor %}
  </select>
</div>

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
        <tr data-school="{{ spell.spty }}">
            <td><a href="spell_single.html?spell={{ spell.name | url_encode }}">{{ spell.name }}</a></td>
            <td>{{ spell.level }}</td>
            <td>{{ spell.desc }}</td>
            <td>{{ spell.spty }}</td>
            <td>피해: {{ spell.dmg }}<br>방어: {{ spell.def }}<br>체력: {{ spell.hlt }}</td>
            <td>{{ spell.btds }}</td>
        </tr>
        {% endfor %}
    </tbody>
</table>

<script>
function filterBySchool() {
  const selectedSchool = document.getElementById('school-filter').value;
  const rows = document.querySelectorAll('tbody tr');
  let visibleCount = 0;
  
  rows.forEach(row => {
    const school = row.getAttribute('data-school');
    // 선택된 학파와 일치하는지 확인
    if (selectedSchool === '' || school === selectedSchool) {
      row.style.display = '';
      visibleCount++;
    } else {
      row.style.display = 'none';
    }
  });
  
  // 결과 개수 표시 (선택사항)
  console.log(`표시된 주문: ${visibleCount}개`);
}

// 페이지 로드 시 URL 파라미터에서 학파 읽기
window.addEventListener('DOMContentLoaded', function() {
  const params = new URLSearchParams(window.location.search);
  const school = params.get('school');
  if (school) {
    document.getElementById('school-filter').value = decodeURIComponent(school);
    filterBySchool();
  }
});
</script>

