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

    # Required to match AR interface, so this can be set as a polymorphic
    # relation.
    def [](val)
      if val == :id
        1
      end
    end

    def lock
    end

    def id
      [:id]
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
  end
end
