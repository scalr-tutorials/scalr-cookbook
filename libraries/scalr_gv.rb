require "rexml/document"
require 'chef/mixin/shell_out'


class Chef
  class Recipe
    def get_global_variables
      override_gv = node.fetch(:scalr, Hash.new).fetch(:override_gv, nil)

      unless override_gv.nil?
        return override_gv
      end

      global_variables = Hash.new

      p = Chef::Mixin::ShellOut::shell_out '/usr/local/bin/szradm',  '-q', 'list-global-variables'
      gv_response = p.stdout

      gv_doc = REXML::Document.new gv_response

      gv_doc.elements.each('response/variables/variable') do |element|
        global_variables[element.attributes["name"]] = element.text
      end

      global_variables
    end
  end
end
