RRRSpec.configure do |conf|
  conf.redis = { host: 'localhost', port: 6379 }
end

RRRSpec.configure(:server) do |conf|
  ActiveRecord::Base.default_timezone = :local
  conf.redis = { host: 'localhost', port: 6379 }

  conf.persistence_db = {
    adapter: 'sqlite3',
    encoding: 'utf8mb4',
    charset: 'utf8mb4',
    collation: 'utf8mb4_general_ci',
    reconnect: false,
    database: 'rrrspec',
    pool: 5,
    host: 'localhost'
  }
  conf.execute_log_text_path = '/vol/rrrspec-log-texts'
  conf.pidfile_directory = '/home/ubuntu'
end

RRRSpec.configure(:worker) do |conf|
  conf.redis = { host: 'localhost', port: 6379 }

  conf.rsync_remote_path = '/mnt/rrrspec-rsync'
  conf.rsync_options = %w(
    --compress
    --times
    --recursive
    --links
    --perms
    --inplace
    --delete
  ).join(' ')

  conf.working_dir = '/mnt/working'
  conf.worker_type = 'default'
  conf.pidfile_directory = '/home/ubuntu'
end
