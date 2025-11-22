---
layout: default
title: 버프/디버프 상세
---

<div id="buff-container">
  <p>버프/디버프를 불러오는 중...</p>
</div>

<script>
// 모든 버프/디버프 데이터를 JavaScript로 가져오기
const buffs = [
  {% for buff in site.data.buffNdebuff_save %}
  {
    name: {{ buff.name | jsonify }},
    type: {{ buff.type | jsonify }},
    description: {{ buff.description | jsonify }},
  }{% unless forloop.last %},{% endunless %}
  {% endfor %}
];

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

// URL에서 버프/디버프명 추출
function getBuffNameFromURL() {
  const path = window.location.pathname;
  // /buff_single/버프명 형식에서 버프명 추출
  const match = path.match(/\/buff_single\/([^\/]+)/);
  if (match) {
    return decodeURIComponent(match[1]);
  }
  // 쿼리 파라미터로도 시도
  const params = new URLSearchParams(window.location.search);
  const queryBuff = params.get('buff');
  if (queryBuff) {
    return decodeURIComponent(queryBuff);
  }
  // 기본값
  return '수면';
}

// [주문명] 또는 [버프(디버프)] 패턴을 링크로 변환하는 함수
function convertLinks(text) {
  if (!text) return '';
  
  // [주문명] 또는 [버프(디버프)] 패턴을 찾아서 링크로 변환
  return text.replace(/\[([^\]]+)\]/g, function(match, nameInBrackets) {
    // spells 배열에서 해당 주문명 찾기
    const foundSpell = spells.find(s => s.name === nameInBrackets);
    
    if (foundSpell) {
      // 주문이 존재하면 링크로 변환
      const encodedName = encodeURIComponent(nameInBrackets);
      return `<a href="spell_single.html?spell=${encodedName}">${nameInBrackets}</a>`;
    }
    
    // buffs 배열에서 해당 버프/디버프 찾기
    const foundBuff = buffs.find(b => b.name === nameInBrackets);
    
    if (foundBuff) {
      // 버프/디버프가 존재하면 링크로 변환
      const encodedName = encodeURIComponent(nameInBrackets);
      return `<a href="buff_single.html?buff=${encodedName}">${nameInBrackets}</a>`;
    }
    
    // 둘 다 없으면 그대로 반환 (링크 없이)
    return match;
  });
}

// 버프/디버프 찾기 및 표시
function displayBuff() {
  const buffName = getBuffNameFromURL();
  const buff = buffs.find(b => b.name === buffName);
  
  const container = document.getElementById('buff-container');
  
  if (!buff) {
    container.innerHTML = `
      <h1>버프/디버프를 찾을 수 없습니다</h1>
      <p>버프/디버프명: "${buffName}"</p>
      <p>올바른 URL 형식: /buff_single/버프명</p>
    `;
    return;
  }
  
  // 설명에서 [주문명] 또는 [버프(디버프)] 패턴을 링크로 변환
  const descWithLinks = convertLinks(buff.description);
  
  container.innerHTML = `
    <h1>${buff.name}</h1>
    
    <h2>버프/디버프 정보</h2>
    
    <li><strong>타입</strong>: ${buff.type}</li>
    
    <h2>설명</h2>
    <p>${descWithLinks}</p>
  `;
  
  // 페이지 제목도 업데이트
  document.title = buff.name + ' - 버프/디버프 상세';
}

// 페이지 로드 시 실행
displayBuff();
</script>

