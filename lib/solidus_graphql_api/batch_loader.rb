# frozen_string_literal: true

module SolidusGraphqlApi
  # Provides an abstraction layer on top of +BatchLoader::GraphQL+ that removes all the
  # boilerplate normally needed to batch-load ActiveRecord associations.
  #
  # @example Batch-loading a user's posts
  #   BatchLoader.for(user, :posts)
  class BatchLoader
    LOADER_CLASSES = {
      has_one: BatchLoader::HasOne,
      has_many: BatchLoader::HasMany,
      has_many_through: BatchLoader::HasManyThrough,
      belongs_to: BatchLoader::BelongsTo,
    }.freeze

    class << self
      # Generates the batch loader for an ActiveRecord instance-association pair.
      #
      # @param object [ActiveRecord::Base] the record whose association you want to batch-load
      # @param association [Symbol] the association to batch-load
      # @param options [Hash] an options hash
      #
      # @option scope [ActiveRecord::Relation] a relation to use for scoping the association
      #
      # @return [BatchLoader::GraphQL]
      #
      # @see #new
      def for(object, association, options = {})
        reflection = object.class.reflect_on_association(association)
        loader_class_for(reflection).new(object, reflection, options).load
      end

      private

      def loader_class_for(reflection)
        association_type = association_type(reflection)
        LOADER_CLASSES[association_type] ||
          raise(ArgumentError, "#{association_type} associations do not support batch loading")
      end

      def association_type(reflection)
        macro = reflection.macro.to_sym

        case macro
        when :has_many
          if reflection.through_reflection
            :has_many_through
          else
            :has_many
          end
        else
          macro
        end
      end
    end

    attr_reader :object, :reflection, :options

    # Generates a new instance of this batch loader for an ActiveRecord instance-association pair.
    #
    # @param object [ActiveRecord::Base] the record whose association you want to batch-load
    # @param reflection [ActiveRecord::Reflection] the association to batch-load
    # @param options [Hash] an options hash
    #
    # @option scope [ActiveRecord::Relation] a relation to use for scoping the association
    # @option klass [Class] the model class to load (only for polymorphic associations)
    def initialize(object, reflection, options = {})
      @object = object
      @reflection = reflection
      @options = options
    end

    # Returns the batch loading logic.
    #
    # @return [BatchLoader::GraphQL]
    def load
      raise NotImplementedError
    end

    private

    def association_klass
      if reflection.polymorphic?
        options[:klass] || raise(
          ArgumentError,
          'You need to provide :klass when batch-loading a polymorphic association!',
        )
      else
        reflection.klass
      end
    end

    def base_relation
      relation = association_klass
      relation = relation.instance_eval(&reflection.scope) if reflection.scope
      relation = relation.merge(options[:scope]) if options[:scope]
      relation
    end

    def default_options
      return @default_options if @default_options

      key_components = [object.class, reflection.name, options.inspect]
      key = Digest::MD5.hexdigest(key_components.join)

      @default_options ||= { key: key }.freeze
    end

    def graphql_loader_for(object_id, options = {}, &block)
      ::BatchLoader::GraphQL.for(object_id).batch(**default_options.merge(options), &block)
    end
  end
end
