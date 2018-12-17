module FakeArModel
  extend ActiveSupport::Concern

  included do

    # Required to match AR interface, so this can be set as a polymorphic
    # relation.
    def self.primary_key
      :id
    end

    # Required to match AR interface, so this can be set as a polymorphic
    # relation.
    def self.base_class
      self
    end

    def initialize
      @attributes = {id: id}
    end
    # Required to match AR interface, so this can be set as a polymorphic
    # relation.
    def [](val)
      if val == :id
        1
      end
    end

    def with_lock
      yield
    end

    def id
      self.send(:[], :id)
    end

    def destroyed?
      false
    end

    def new_record?
      true
    end

    def save!(*args)
    end
    alias save save!

    def _read_attribute(attr_name, &block) # :nodoc
      @attributes[attr_name]
    end
  end
end
