test_server_config = [
  port: 9090,
  server_name: 'hound_test_server',
  server_root: Path.absname('test/sample_pages'),
  document_root: Path.absname('test/sample_pages'),
  bind_address: 'localhost'
]

{:ok, pid} = :inets.start(:httpd, test_server_config)

Hound.start
ExUnit.start [max_cases: 5]

System.at_exit fn(_exit_status) ->
  :ok = :inets.stop(:httpd, pid)
end
