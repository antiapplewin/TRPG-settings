#!/usr/bin/env ruby
# generate_spells.rb
# _data/spell_save.yaml에서 주문 데이터를 읽어서 spells/ 디렉토리에 MD 파일을 생성합니다.

require 'yaml'
require 'fileutils'

# YAML 파일 읽기
yaml_file = File.join(__dir__, '_data', 'spell_save.yaml')
spells = YAML.load_file(yaml_file)

# spells 디렉토리 생성
spells_dir = File.join(__dir__, 'spells')
FileUtils.mkdir_p(spells_dir)

# 각 주문에 대해 MD 파일 생성
spells.each do |spell|
  next unless spell && spell['name']
  
  # 파일명 생성 (한글 이름 그대로 사용)
  spell_name = spell['name']
  filename = File.join(spells_dir, "#{spell_name}.md")
  
  # Front matter를 YAML로 생성
  front_matter = {
    'layout' => 'spell',
    'title' => spell['name'],
    'spell' => spell
  }
  
  # MD 파일 내용 생성
  yaml_header = YAML.dump(front_matter).gsub(/^---\n/, '').strip
  content = "---\n#{yaml_header}\n---\n"
  
  # 파일 쓰기
  File.write(filename, content)
  puts "생성됨: #{filename}"
end

puts "\n총 #{spells.length}개의 주문 파일이 생성되었습니다."

