lock "3.10.1"

set :application, "pcky"
set :repo_url, "git@github.com:dongngo0804/PCKY.git"

append :linked_files, "config/database.yml", "config/secrets.yml"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "vendor/bundle", "public/system", "public/uploads"
