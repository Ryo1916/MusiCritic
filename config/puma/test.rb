threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
threads threads_count, threads_count
environment ENV.fetch("RAILS_ENV") { "test" }
plugin :tmp_restart
app_root = File.expand_path("../../..", __FILE__)
bind "unix://#{app_root}/tmp/sockets/puma.sock"