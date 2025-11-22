---
layout: default
title: 주문
---

# 주문 목록

{::nomarkdown}
<div style="margin-bottom: 20px;">
  <div style="margin-bottom: 10px;">
    <strong>주문명 검색:</strong><br>
    <input type="text" id="buffNdebuff-search" placeholder="주문명을 입력하세요 (예: 흡혈)" 
           style="width: 300px; padding: 5px; margin-top: 5px;" 
           oninput="filterBySchool()">
  </div>
{:/nomarkdown}

<table>
    <thead>
        <tr>
            <th>이름</th>
            <th>버프/디버프</th>
            <th>설명</th>
        </tr>
    </thead>
    <tbody>
        {% for buffNdebuff in site.data.buffNdebuff_save %}
        <tr data-school="{{ buffNdebuff.spty }}" data-name="{{ buffNdebuff.name }}">
            <td><a href="buff_single.html?buff={{ buffNdebuff.name | url_encode }}">{{ buffNdebuff.name }}</a></td>
            <td>{{ buffNdebuff.type }}</td>
            <td>{{ buffNdebuff.description }}</td>
        </tr>
        {% endfor %}
    </tbody>
</table>

{::nomarkdown}
<script>
function filterBySchool() {
  // 검색어 가져오기
  const searchText = document.getElementById('buffNdebuff-search').value.trim().toLowerCase();
  
  const rows = document.querySelectorAll('tbody tr');
  let visibleCount = 0;
  
  rows.forEach(row => {
    const school = row.getAttribute('data-school');
    const name = row.getAttribute('data-name').toLowerCase();
    
    // 이름 조건 확인 (부분 일치)
    const nameMatch = searchText === '' || name.includes(searchText);
    
    // AND 조건: 학파 조건 AND 이름 조건 둘 다 만족해야 표시
    if (nameMatch) {
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
  const schools = params.getAll('school'); // 여러 학파 지원
  
  if (schools.length > 0) {
    // 모든 체크박스 해제
    document.querySelectorAll('.school-checkbox').forEach(cb => cb.checked = false);
    
    filterBySchool();
  }
});
</script>
{:/nomarkdown}

