class GithubUrl
  def shortcut url
    matchdata = /github.com\/(.+)\/(.+).git/.match url
    return false unless matchdata
    matchdata.captures.join('/')
  end
end
