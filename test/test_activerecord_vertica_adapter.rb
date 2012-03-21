require 'helper'

class TestVerticaAdapter < Test::Unit::TestCase
  def setup
    @conn = Vertica.connect(CONFIG)
    @adapter = ::ActiveRecord::ConnectionAdapters::Vertica.new(@conn)
  end

  def teardown
    @conn.close
  end

  def test_quoting_name
    assert_equal "'test'", @adapter.quote_column_name('test')
    assert_equal "engage.test", @adapter.quote_table_name('test')
  end

  def test_schema_name
    assert_equal "engage", @adapter.schema_name
  end

  def test_column_name_of_user_detais_table
    columns = @adapter.columns('purchase')
    assert_equal ::ActiveRecord::ConnectionAdapters::VerticaColumn, columns.first.class 
  end

  def test_tables
    tables = ["purchase", "transaction", "user", "vote", "testpurchase"]
    assert_equal tables, @adapter.tables
  end
end
