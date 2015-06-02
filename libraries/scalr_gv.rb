require "rexml/document"
require 'chef/mixin/shell_out'
include Chef::Mixin::ShellOut


module Scalr
  def self.global_variables(node=nil)

    # Optionally submit the node, in which case we'll look for an override
    unless node.nil?
      override_gv = node.fetch(:scalr, Hash.new).fetch(:override_gv, nil)
      unless override_gv.nil?
        return override_gv
      end
    end

    # Retrieve Global Variables
    # We use szradm and not environment variables so that we can run
    # in a standalone chef-client run
    p = Chef::Mixin::ShellOut.shell_out 'szradm',  '-q', 'list-global-variables'
    gv_response = p.stdout
    gv_doc = REXML::Document.new gv_response

    # Parse and return Global Variables
    global_variables = Hash.new
    gv_doc.elements.each('response/variables/variable') do |element|
      global_variables[element.attributes["name"]] = element.text
    end

    global_variables
  end
end


# Hook in
unless(Chef::Recipe.ancestors.include?(Scalr))
  Chef::Recipe.send(:include, Scalr)
  Chef::Resource.send(:include, Scalr)
  Chef::Provider.send(:include, Scalr)
end
