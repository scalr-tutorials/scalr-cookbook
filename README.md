# scalr cookbook

A library to access Scalr Global Variables using the local Scalr agent,
`szradm`.


# Requirements

Add the Scalr cookbook to your dependencies. In `metadata.rb`:

    depends 'scalr', '~> 0.2.0'


Make sure the Scalr cookbook is available on your node. If you're using a
`Berksfile` to manage your recipe, you can add:

    cookbook 'scalr', git: 'https://github.com/scalr-tutorials/scalr-cookbook.git'


# Usage

In your recipes, providers and resources, use:

    Scalr.global_variables

This will return a `Hash` of your Global Variables.

If `szradm` is not available in your development environment, you can override
Global Variables using attributes.

To do this, update your call to `Scalr.global_variables` to include the `node`:

    Scalr.global_variables node

And then define the attributes (see below).


# Attributes

Set `default[:scalr][:override_gv]` to a Hash, and you'll be served those
variables instead of Scalr's Global Variables.

If this attribute is defined, the library will not hit `szradm`.

