use Mix.Config

Code.require_file("test/support/streams.ex")
Code.require_file("test/support/file_mock.ex")

config :discography, file_reader: Discography.Support.FileMock
