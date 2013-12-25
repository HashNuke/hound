# Run with mix run release_docs.exs
Mix.Task.run "docs"
File.cd! "../docs", fn -> System.cmd("git checkout gh-pages") end
File.rm_rf "../docs/hound"
File.cp_r "docs/.", "../docs/hound/"
File.rm_rf "docs"
