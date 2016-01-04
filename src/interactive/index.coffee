Baobab = require 'baobab'
Table = require './table'

# Interactive data sources manipulate table eg. ``sort``,``unique``,``filter``,``map``, ``groupby``, ``join`` .
# ``Baobab`` trees are interactive and immutable.  They manage the state of the
# tabular data.
# Interactive maintains:
# * Table metadata
# * ColumnDataSources ``column_data_source`` and Row DataSource ``values``
# * ``History`` of the compute applied to the table.
# @example create a new Interactive Data Source
#   table = new Interactive
#     columns: [
#       'x'
#       'y'
#     ]
#     values: [
#       [1, 2]
#       [3, 8]
#     ]
#     metadata:
#       x: {units:'inch',alias:'length of rectangle'}
#       y: {units:'inch',alias:'width of rectangle'}
class Interactive extends Table
  readme: -> @_readme.get()
  ###
  @param [String] name The name of the table.
  @param [Array] values m lists of lists with n elements.  Represents a table or
  dataframe like object
  @param [Array] columns A list of column names for the corresponding values
  @param [Object] metadata An object with keys that are column names.  The keys
  can define arbitrary objects.
  @param [String] readme Some metadata about the table itself.

  ###
  name: ()-> @cursor.get 'name'
  readme: ()-> @cursor.get 'readme'
  constructor: ({name, values, columns, metadata, readme})->
    @tree = new Baobab
      name: name
    @cursor = @tree.select 0
    @_readme = @cursor.select 'readme'
    @_readme.set readme ? ""
    super values, columns, metadata
    @compute()

module.exports = Interactive
