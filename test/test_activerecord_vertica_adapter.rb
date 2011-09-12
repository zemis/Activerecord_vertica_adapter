require 'helper'

class TestVerticaAdapter < Test::Unit::TestCase
  def setup
    config = {
      :host => '91.216.137.103',
      :port => 5433,
      :reconnect => true,
      :database => 'buzzDW',
      :schema => 'voting_system',
      :user =>  'vertica-admin'
    }

    @conn = Vertica.connect(config)
    @adapter = ::ActiveRecord::ConnectionAdapters::Vertica.new(@conn)
  end

  def teardown
    @conn.close
  end

  def test_quoting_name
    assert_equal "'test'", @adapter.quote_column_name('test')
    assert_equal "voting_system.test", @adapter.quote_table_name('test')
  end

  def test_schema_name
    assert_equal "voting_system", @adapter.schema_name
  end

  def test_column_name_of_user_detais_table
    columns = @adapter.columns('user_details')
    assert_equal ::ActiveRecord::ConnectionAdapters::VerticaColumn, columns.first.class 
  end

  def test_tables
    tables = ["purchase_log",
 "parsed_file_names",
 "transaction_log",
 "temp_load_user_log",
 "outdated_user_details",
 "user_details",
 "user_login_details",
 "user_failed_registration_details",
 "votes_log",
 "temp_load_purchase_log",
 "temp_load_transaction_log",
 "temp_load_votes_log",
 "test"]
    assert_equal tables, @adapter.tables
  end
end
