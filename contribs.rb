contribs = `opam search --short coq:contrib:`.split(/\s/).map do |contrib|
  contrib.strip["coq:contrib:".size..-1]
end

case ARGV[0]
when "clone"
  username = ARGV[1]
  for contrib in contribs do
    system("git clone #{username}@scm.gforge.inria.fr:/git/coq-contribs/#{contrib}.git")
  end
when "list"
  puts contribs
else
  puts "\e[1;34mUsage:\e[0m

    ruby contribs.rb command

We must be in an environment where OPAM and the repo-unstable are activated, so
that `opam search coq:contrib:` get the list of contribs.

\e[1;34mCommands:\e[0m
- clone username: clone the contribs with the GForge username
- list: list the contribs"
end
