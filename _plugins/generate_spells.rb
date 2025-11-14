# _plugins/generate_spells.rb

module Jekyll
  class SpellPageGenerator < Generator
    safe true

    def generate(site)
      spells = site.data["spell_save"]
      
      return unless spells && spells.is_a?(Array)

      spells.each do |spell|
        next unless spell && spell["name"]
        site.pages << SpellPage.new(site, spell)
      end
    end
  end

  class SpellPage < Jekyll::PageWithoutAFile
    def initialize(site, spell)
      @site = site
      @base = site.source
      
      # URL 안전한 경로 생성
      spell_name = spell["name"] || "unknown"
      @dir  = "spells/#{spell_name}"
      @name = "index.html"

      super(site, @base, @dir, @name)
      
      # 레이아웃 설정
      self.data["layout"] = "spell"
      
      # YAML 데이터를 페이지 변수로 넘김
      self.data["spell"] = spell
      self.data["title"] = spell["name"]
    end
  end
end
