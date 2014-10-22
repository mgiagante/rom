require 'spec_helper'
require 'ostruct'

describe 'Defining mappers' do
  let(:rom) do
    ROM.setup(sqlite: 'sqlite::memory') do
      schema do
        base_relation(:users) do
          repository :sqlite
          attribute :id, Integer
        end
      end
    end
  end

  before do
    rom.sqlite.connection.run('CREATE TABLE users (id SERIAL)')
    rom.sqlite.connection[:users].insert(id: 231)
    User = Class.new(OpenStruct) { include Equalizer.new(:id) }
  end

  after do
    Object.send(:remove_const, :User)
  end

  describe '.define' do
    it 'returns mapper registry' do
      rom.mappers do
        relation(:users) do
          model User
          map :id
        end
      end

      rom.relations do
        users do
          def by_id(id)
            where(id: id)
          end
        end
      end

      users = rom.mappers.users

      expect(users.to_a).to eql([User.new(id: 231)])
      expect(users.header).to eql(rom.schema[:users].header)

      expect(rom.relations.users(mapper: true).by_id(231).to_a).to eql([User.new(id: 231)])
      expect(rom.relations.users(mapper: true).by_id(231).header).to eql(rom.schema[:users].header)
    end
  end
end
