# defined explicitly because of the inter-dependencies
helpers = [
  "test/support/streams.ex",
  "test/support/file_mock.ex"
]

helpers
|> Enum.map(&Code.require_file/1)

ExUnit.start()
