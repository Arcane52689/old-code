module TracksHelper


  def ugly_lyrics(lyrics)
    ugly_lyrics = lyrics.split("\n")
    ugly_lyrics.each do |line|
      line.insert(0,"&#9835;  ")
    end

    <<-HTML.html_safe
      <pre>
        #{ugly_lyrics.join("\n")}
      </pre>
    HTML
  end

end
