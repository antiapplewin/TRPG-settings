---
layout: default
title: 주문 상세
---

<div id="spell-container">
  <p>주문을 불러오는 중...</p>
</div>

<script>
// 모든 주문 데이터를 JavaScript로 가져오기
const spells = [
  {% for spell in site.data.spell_save %}
  {
    name: {{ spell.name | jsonify }},
    level: {{ spell.level | jsonify }},
    desc: {{ spell.desc | jsonify }},
    spty: {{ spell.spty | jsonify }},
    dmg: {{ spell.dmg | jsonify }},
    def: {{ spell.def | jsonify }},
    hlt: {{ spell.hlt | jsonify }},
    btds: {{ spell.btds | jsonify }}
  }{% unless forloop.last %},{% endunless %}
  {% endfor %}
];

// URL에서 주문명 추출
function getSpellNameFromURL() {
  const path = window.location.pathname;
  // /spell_single/흡혈 형식에서 주문명 추출
  const match = path.match(/\/spell_single\/([^\/]+)/);
  if (match) {
    return decodeURIComponent(match[1]);
  }
  // 쿼리 파라미터로도 시도
  const params = new URLSearchParams(window.location.search);
  const querySpell = params.get('spell');
  if (querySpell) {
    return decodeURIComponent(querySpell);
  }
  // 기본값
  return '흡혈';
}

// 주문 찾기 및 표시
function displaySpell() {
  const spellName = getSpellNameFromURL();
  const spell = spells.find(s => s.name === spellName);
  
  const container = document.getElementById('spell-container');
  
  if (!spell) {
    container.innerHTML = `
      <h1>주문을 찾을 수 없습니다</h1>
      <p>주문명: "${spellName}"</p>
      <p>올바른 URL 형식: /spell_single/주문명</p>
    `;
    return;
  }
  
  container.innerHTML = `
    <h1>${spell.name}</h1>
    
    <h2>주문 정보</h2>
    
    <li><strong>레벨</strong>: ${spell.level}</li>
    <li><strong>학파</strong>: ${spell.spty}</li>
    
    <h2>설명</h2>
    <p>${spell.desc}</p>
    
    <h2>전투 정보</h2>
    <li><strong>피해</strong>: ${spell.dmg}</li>
    <li><strong>방어</strong>: ${spell.def}</li>
    <li><strong>체력</strong>: ${spell.hlt}</li>

    <p>${spell.btds}</p>
  `;
  
  // 페이지 제목도 업데이트
  document.title = spell.name + ' - 주문 상세';
}

// 페이지 로드 시 실행
displaySpell();
</script>

