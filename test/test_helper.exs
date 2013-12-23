ExUnit.start [autorun: false, max_cases: 5]
Hound.start

System.at_exit fn(_exit_status) ->
  test_server_config = [
    port: 9090,
    server_name: 'hound_test_server',
    server_root: Path.absname('test/sample_pages'),
    document_root: Path.absname('test/sample_pages'),
    bind_address: 'localhost'
  ]

  {:ok, pid} = :inets.start(:httpd, test_server_config)

  test_result = ExUnit.run

  :ok = :inets.stop(:httpd, pid)
  test_result
end
