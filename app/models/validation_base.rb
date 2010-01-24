class ValidationBase < ActiveRecord::Base
  abstract_class = true
  
  def self.columns() @columns ||= []; end  

  def self.column(name, sql_type = nil, default = nil, null = true)  
   columns << ActiveRecord::ConnectionAdapters::Column.new(name.to_s, default, sql_type.to_s, null)  
  end
 end
