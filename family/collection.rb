 module Family
   class Collection
      attr_accessor :collection

      def initialize(collection = {})
        @collection = collection
      end

      def add(family_member)
        collection[family_member.name] = family_member
        family_member
      end

      def find(name)
        collection[name]
      end

      def merge!(another_collection)
        Collection.new collection.merge(another_collection.collection)
      end

      def except(family_member)
        Collection.new collection.reject{ |k, v| k == family_member.name }
      end

      def map(&block)
        new_collection = Collection.new

        collection.each do |key, c|
          new_member = block.call(c)
          new_collection.add(new_member) if new_member
        end

        new_collection
      end

      def to_arr
        collection.values
      end
   end
 end
