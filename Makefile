server:
  @docker compose run \
   --name rebase-labs\
   --rm \
   --service-ports \
   app \
   bash -c "ruby server.rb" \

bundle:
  @docker compose run app bundle