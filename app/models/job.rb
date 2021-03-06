# == Schema Information
# Schema version: 13
#
# Table name: jobs
#
#  id           :integer(11)     not null, primary key
#  location     :string(255)     
#  organization :string(255)     
#  title        :string(255)     
#  description  :text            
#  email        :string(255)     
#  created_at   :datetime        
#  updated_at   :datetime        
#  deleted_at   :datetime        
#

class Job < ActiveRecord::Base
  validates_presence_of :location, :organization, :title
  has_markup :description, :required => true, :cache_html => true
  
  named_scope :recent, lambda {{
        :conditions => ['updated_at > ?', 1.month.ago],
        :order      => 'updated_at desc'
  }}
  named_scope :old, lambda {{
    :conditions => ['updated_at <= ?', 1.month.ago],
    :order      => 'updated_at desc'
  }}
end
