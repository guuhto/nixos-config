[
  {
    label = "Run Rust";
    command = "cargo run";
    use_new_terminal = false;
    allow_concurrent_runs = false;
  }
  {
    label = "Run Python";
    command = "python3 $ZED_FILE";
    use_new_terminal = false;
  }
  {
    label = "Run Go";
    command = "go run $ZED_FILE";
    use_new_terminal = false;
  }
  {
    label = "Run C";
    command = "gcc $ZED_FILE -o /tmp/out && /tmp/out";
    use_new_terminal = false;
  }
]
