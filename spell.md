<table>
    <thead>
        <tr>
            <th>주문명</th>
            <th>주문 설명</th>
            <th>요소</th>
            <th>학파</th>
            <th>효과</th>
            <th>특수효과</th>
        </tr>
    </thead>
    <tbody>
        {% for spell in site.data.spell_save %}
        <tr data-tags="{{ spell.tags | join: ',' | downcase }}">
            <td>{{ spell.name }}</td>
            <td>{{ spell.desc }}</td>
            <td>{{ spell.spty }}</td>
            <td>{{ spell.sorc }}</td>
            <td>{{ spell.dmg }}<br>{{ spell.def }}<br>{{ spell.hlt }}</td>
            <td>{{ spell.btds }}</td>
        </tr>
        {% endfor %}
    </tbody>
</table>