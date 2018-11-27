require "rails_erd/diagram"

module RailsERD
  class Diagram
    class NomnomlDiagram < Diagram
      setup do
        @output = title ? ["#title: #{title}", ""] : []
      end

      each_relationship do |relationship|
        return if relationship.indirect?

        arrow = case
        when relationship.one_to_one?   then "1->1"
        when relationship.one_to_many?  then "1->n"
        when relationship.many_to_many? then "n->n"
        end

        @output << "[#{relationship.source}] #{arrow} [#{relationship.destination}]"
        @output << ""
      end

      each_entity do |entity|
        @output << "[#{entity.name}|"
        @output << entity.attributes.map{|a| "#{a}: #{a.type}" }.join("\n")
        @output << "]"
        @output << ""
      end

      save do
        @output * "\n"
      end
    end
  end
end
