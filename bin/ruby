docker run \
  -it \
  --rm \
  --name ruby \
  -w /app \
  -v $(pwd):/app \
  -v rubygems_rebase_labs:/usr/local/bundle \
  --network rebase-labs \
  ruby \
  bash