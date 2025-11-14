# _plugins/generate_spells.rb

module Jekyll
  class SpellPageGenerator < Generator
    safe true

    def generate(site)
      spells = site.data["spell_save"]

      spells.each do |spell|
        site.pages << SpellPage.new(site, spell)
      end
    end
  end

  class SpellPage < Page
    def initialize(site, spell)
      @site = site
      @base = site.source
      @dir  = "spells/#{spell['name']}"
      @name = "index.html"

      self.process(@name)
      self.read_yaml(File.join(@base, "_layouts"), "spell.html")

      # YAML 데이터를 페이지 변수로 넘김
      self.data["spell"] = spell
      self.data["title"] = spell["name"]
    end
  end
end
