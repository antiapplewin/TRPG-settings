---
layout: default
title: 주문
---

# 주문 목록

<div style="margin-bottom: 20px;">
  <div style="margin-bottom: 10px;">
    <strong>주문명 검색:</strong><br>
    <input type="text" id="spell-search" placeholder="주문명을 입력하세요 (예: 흡혈)" 
           style="width: 300px; padding: 5px; margin-top: 5px;" 
           oninput="filterBySchool()">
  </div>
  
  <div>
    <strong>학파 필터:</strong><br>
    <label style="margin-right: 15px;">
      <input type="checkbox" class="school-checkbox" value="전체" onchange="filterBySchool()" checked> 전체
    </label>
    <label style="margin-right: 15px;">
      <input type="checkbox" class="school-checkbox" value="방출계" onchange="filterBySchool()"> 방출계
    </label>
    <label style="margin-right: 15px;">
      <input type="checkbox" class="school-checkbox" value="방호계" onchange="filterBySchool()"> 방호계
    </label>
    <label style="margin-right: 15px;">
      <input type="checkbox" class="school-checkbox" value="변환계" onchange="filterBySchool()"> 변환계
    </label>
    <label style="margin-right: 15px;">
      <input type="checkbox" class="school-checkbox" value="사령계" onchange="filterBySchool()"> 사령계
    </label>
    <label style="margin-right: 15px;">
      <input type="checkbox" class="school-checkbox" value="예지계" onchange="filterBySchool()"> 예지계
    </label>
    <label style="margin-right: 15px;">
      <input type="checkbox" class="school-checkbox" value="조형계" onchange="filterBySchool()"> 조형계
    </label>
    <label style="margin-right: 15px;">
      <input type="checkbox" class="school-checkbox" value="환영계" onchange="filterBySchool()"> 환영계
    </label>
    <label style="margin-right: 15px;">
      <input type="checkbox" class="school-checkbox" value="환혹계" onchange="filterBySchool()"> 환혹계
    </label>
  </div>
</div>

<table>
    <thead>
        <tr>
            <th>주문명</th>
            <th>주문레벨</th>
            <th>학파</th>
            <th>효과</th>
            <th>특수효과</th>
        </tr>
    </thead>
    <tbody>
        {% for spell in site.data.spell_save %}
        <tr data-school="{{ spell.spty }}" data-name="{{ spell.name }}">
            <td><a href="spell_single.html?spell={{ spell.name | url_encode }}">{{ spell.name }}</a></td>
            <td>{{ spell.level }}</td>
            <td>{{ spell.spty }}</td>
            <td>피해: {{ spell.dmg }}<br>방어: {{ spell.def }}<br>체력: {{ spell.hlt }}</td>
            <td>{{ spell.btds }}</td>
        </tr>
        {% endfor %}
    </tbody>
</table>

<script>
function filterBySchool() {
  // 검색어 가져오기
  const searchText = document.getElementById('spell-search').value.trim().toLowerCase();
  
  // 선택된 모든 체크박스 가져오기
  const checkboxes = document.querySelectorAll('.school-checkbox');
  const selectedSchools = [];
  
  checkboxes.forEach(checkbox => {
    if (checkbox.checked) {
      selectedSchools.push(checkbox.value);
    }
  });
  
  // "전체"가 선택되어 있으면 모든 학파 허용
  const showAll = selectedSchools.includes('전체');
  
  const rows = document.querySelectorAll('tbody tr');
  let visibleCount = 0;
  
  rows.forEach(row => {
    const school = row.getAttribute('data-school');
    const name = row.getAttribute('data-name').toLowerCase();
    
    // 학파 조건 확인 (OR)
    const schoolMatch = showAll || selectedSchools.includes(school);
    
    // 이름 조건 확인 (부분 일치)
    const nameMatch = searchText === '' || name.includes(searchText);
    
    // AND 조건: 학파 조건 AND 이름 조건 둘 다 만족해야 표시
    if (schoolMatch && nameMatch) {
      row.style.display = '';
      visibleCount++;
    } else {
      row.style.display = 'none';
    }
  });
  
  // "전체" 체크박스 처리
  const allCheckbox = document.querySelector('.school-checkbox[value="전체"]');
  if (showAll && selectedSchools.length > 1) {
    // 다른 학파가 선택되면 "전체" 체크 해제
    allCheckbox.checked = false;
    filterBySchool(); // 다시 필터링
    return;
  }
  
  // 결과 개수 표시 (선택사항)
  console.log(`표시된 주문: ${visibleCount}개`);
}

// 페이지 로드 시 URL 파라미터에서 학파 읽기
window.addEventListener('DOMContentLoaded', function() {
  const params = new URLSearchParams(window.location.search);
  const schools = params.getAll('school'); // 여러 학파 지원
  
  if (schools.length > 0) {
    // 모든 체크박스 해제
    document.querySelectorAll('.school-checkbox').forEach(cb => cb.checked = false);
    
    // URL의 학파들 체크
    schools.forEach(school => {
      const decodedSchool = decodeURIComponent(school);
      const checkbox = document.querySelector(`.school-checkbox[value="${decodedSchool}"]`);
      if (checkbox) {
        checkbox.checked = true;
      }
    });
    
    filterBySchool();
  }
});
</script>

