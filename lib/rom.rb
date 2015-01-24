require 'concord'
require 'charlatan'
require 'inflecto'

require 'rom/version'
require 'rom/support/registry'
require 'rom/support/options'
require 'rom/support/class_builder'

require 'rom/header'
require 'rom/relation'
require 'rom/mapper'
require 'rom/reader'

require 'rom/processor/transproc'

require 'rom/commands'

require 'rom/repository'

require 'rom/env'

require 'rom/global'
require 'rom/setup'

module ROM
  AdapterLoadError = Class.new(StandardError)

  EnvAlreadyFinalizedError = Class.new(StandardError)
  RelationAlreadyDefinedError = Class.new(StandardError)
  NoRelationError = Class.new(StandardError)
  CommandError = Class.new(StandardError)
  TupleCountMismatchError = Class.new(CommandError)
  MapperMissingError = Class.new(StandardError)

  InvalidOptionValueError = Class.new(StandardError)
  InvalidOptionKeyError = Class.new(StandardError)

  Schema = Class.new(Registry)
  RelationRegistry = Class.new(Registry)
  ReaderRegistry = Class.new(Registry)

  EMPTY_HASH = {}.freeze

  extend Global
end
