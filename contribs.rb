require 'open3'

output, status = Open3.capture2e("opam search --short coq:contrib:")
if status.to_i == 0 then
  contribs = output.split(/\s/).map do |contrib|
    contrib.strip["coq:contrib:".size..-1]
  end
else
  contribs = []
end

if contribs.size == 0 then
  puts "You should set up an OPAM environment and add the `repo-unstable`."
  exit(1)
end

case ARGV[0]
when "list"
  puts contribs
when "clone"
  username = ARGV[1]
  if username then
    for contrib in contribs do
      system("git clone #{username}@scm.gforge.inria.fr:/git/coq-contribs/#{contrib}.git")
    end
  else
    puts "GForge username expected."
    exit(1)
  end
when "checkout"
  branch = ARGV[1]
  if branch then
    for contrib in contribs do
      system("cd #{contrib} && git checkout #{branch}")
    end
  else
    puts "Branch name expected."
    exit(1)
  end
else
  print(File.read("README.md"))
  exit(1)
end
