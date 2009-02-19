module ScopedSearch::Test::Models
    
  class Foo < ActiveRecord::Base
    def self.create_corpus!
      create!(:string_field => "Programmer 123", :text_field => nil,              :ignored_field => "123456",  :date_field => '2000-01-01', :int_field => 1)    
      create!(:string_field => "Jim",            :text_field => "Henson",         :ignored_field => "123456a", :date_field => '2001-04-15', :int_field => 2)   
      create!(:string_field => "Jim",            :text_field => "Bush",           :ignored_field => "123456b", :date_field => '2001-04-17', :int_field => 3)    
      create!(:string_field => "Wes",            :text_field => "Hays",           :ignored_field => "123456c", :date_field => '1980-09-27', :int_field => 4)  
      create!(:string_field => "Bob",            :text_field => "Hays",           :ignored_field => "123456d", :date_field => '2002-11-09', :int_field => 5)  
      create!(:string_field => "Dogs",           :text_field => "Pit Bull",       :ignored_field => "123456e", :date_field => '2002-12-26', :int_field => 6) 
      create!(:string_field => "Dogs",           :text_field => "Eskimo",         :ignored_field => "123456f", :date_field => '2003-03-19', :int_field => 7)
      create!(:string_field => "Cows",           :text_field => "Farms",          :ignored_field => "123456g", :date_field => '2004-05-01', :int_field => 8)
      create!(:string_field => "Hello World",    :text_field => "Hello Moon",     :ignored_field => "123456h", :date_field => '2004-07-11', :int_field => 9)   
      create!(:string_field => "Hello World",    :text_field => "Goodnight Moon", :ignored_field => "123456i", :date_field => '2004-09-12', :int_field => 10)
      create!(:string_field => "Happy Cow",      :text_field => "Sad Cow",        :ignored_field => "123456j", :date_field => '2005-02-05', :int_field => 11)
      create!(:string_field => "Happy Frog",     :text_field => "Sad Frog",       :ignored_field => "123456k", :date_field => '2006-03-09', :int_field => 12)
      create!(:string_field => "Excited Frog",   :text_field => "Sad Frog",       :ignored_field => "123456l", :date_field => '2006-07-15', :int_field => 13)    
      create!(:string_field => "Man made",       :text_field => "Woman made",     :ignored_field => "123456m", :date_field => '2007-06-13', :int_field => 14)
      create!(:string_field => "Cat Toys",       :text_field => "Frog Toys",      :ignored_field => "123456n", :date_field => '2008-03-04', :int_field => 15) 
      create!(:string_field => "Happy Toys",     :text_field => "Sad Toys",       :ignored_field => "123456n", :date_field => '2008-05-12', :int_field => 16) 

      create!(:string_field => "My son was born on 7/15/2006 and weighed 5.5 lbs",     
              :text_field => "Sad Toys",       
              :ignored_field => "123456n", 
              :date_field => '2008-09-22',
              :int_field => nil)
    end
  end

  class User < ActiveRecord::Base
    belongs_to :group
    belongs_to :address
    has_many :notes
    has_and_belongs_to_many :locations
  
    has_many :offices, :dependent => :destroy
    has_many :clients, :through => :offices
    
    def self.create_corpus!
      create!(:first_name => 'Willem',  :last_name => 'Van Bergen', :login => 'wvanbergen', :group_id => 1, :address_id => 1) 
      create!(:first_name => 'Wes',     :last_name => 'Hays',       :login => 'weshays',    :group_id => 1, :address_id => 2) 
      create!(:first_name => 'John',    :last_name => 'Dell',       :login => 'jdell',      :group_id => 2, :address_id => 3) 
      create!(:first_name => 'Ray',     :last_name => 'York',       :login => 'ryork',      :group_id => 3, :address_id => 4) 
      create!(:first_name => 'Anna',    :last_name => 'Landis',     :login => 'alandis',    :group_id => 4, :address_id => 5) 
    
      user = self.find_by_first_name('Willem')
      user.locations << ScopedSearch::Test::Models::Location.find_by_name('Office')
    
      user = self.find_by_first_name('Wes')
      user.locations << ScopedSearch::Test::Models::Location.find_by_name('Store')
    
      user = self.find_by_first_name('John')
      user.locations << ScopedSearch::Test::Models::Location.find_by_name('Office')
    
      user = self.find_by_first_name('Ray')
      user.locations << ScopedSearch::Test::Models::Location.find_by_name('Home')
    
      user = self.find_by_first_name('Anna')
      user.locations << ScopedSearch::Test::Models::Location.find_by_name('Beach')                
    end
  end

  class Client < ActiveRecord::Base
    has_many :offices, :dependent => :destroy
    has_many :users, :through => :offices
    def self.create_corpus!
      create!(:first_name => 'Bob',    :last_name => 'Smith') 
      create!(:first_name => 'Sam',    :last_name => 'Lovett')
      create!(:first_name => 'Sally',  :last_name => 'May')
      create!(:first_name => 'Mary',   :last_name => 'Smith')
      create!(:first_name => 'Darren', :last_name => 'Johnson')
    end
  end

  class Office < ActiveRecord::Base
    belongs_to :client
    belongs_to :user
    def self.create_corpus!
      create!(:name => 'California Office', :user_id => 1, :client_id => 1)
      create!(:name => 'California Office', :user_id => 2, :client_id => 2)
      create!(:name => 'California Office', :user_id => 3, :client_id => 3)
      create!(:name => 'Reno Office',       :user_id => 4, :client_id => 4)
      create!(:name => 'Reno Office',       :user_id => 5, :client_id => 5)        
    end
  end

  class Group < ActiveRecord::Base
    has_many :users
    def self.create_corpus!
      create!(:name => 'System Administrator') 
      create!(:name => 'Software Managers')    
      create!(:name => 'Office Managers')      
      create!(:name => 'Accounting')           
    end
  end

  class Location < ActiveRecord::Base
    has_and_belongs_to_many :users
    def self.create_corpus!
      create!(:name => 'Home')   
      create!(:name => 'Office') 
      create!(:name => 'Store')  
      create!(:name => 'Beach')  
    end
  end

  class Note < ActiveRecord::Base
    belongs_to :user
    def self.create_corpus!
      wes  = ScopedSearch::Test::Models::User.find_by_first_name('Wes')
      john = ScopedSearch::Test::Models::User.find_by_first_name('John')
    
      create!(:user_id => wes.id,         
              :title   => 'Purchases', 
              :content => "1) Linksys Router. 2) Network Cable")   
            
      create!(:user_id => wes.id,         
              :title  => 'Tasks',
              :content => 'Clean my car, walk the dog and mow the yard buy milk') 
            
      create!(:user_id => wes.id,         
              :title   => 'Grocery List',
              :content => 'milk, gum, apples')  
            
      create!(:user_id => wes.id,         
              :title   => 'Stocks to watch',
              :content => 'MA, AAPL, V and SSO.  Straddle MA at 200 with JAN 09 options')            
    
      create!(:user_id => john.id,        
              :title   => 'Spec Tests',
              :content => 'Spec Tests... Spec Tests... Spec Tests!!')   
            
      create!(:user_id => john.id,        
              :title   => 'Things To Do',
              :content => '1) Did I mention Spec Tests!!!, 2) Buy Linksys Router WRT160N')
    end
  end

  class Address < ActiveRecord::Base
    has_one :user
    def self.create_corpus!
      create!(:street => '800 Haskell St',     :city => 'Reno',       :state => 'NV', :postal_code => '89509') 
      create!(:street => '2499 Dorchester Rd', :city => 'Charleston', :state => 'SC', :postal_code => '29414')
      create!(:street => '474 Mallard Way',    :city => 'Fernley',    :state => 'NV', :postal_code => '89408')
      create!(:street => '1600 Montero Ct',    :city => 'Sparks',     :state => 'NV', :postal_code => '89434')
      create!(:street => '200 4th St',         :city => 'Sparks',     :state => 'NV', :postal_code => '89434')
    end
  end
end
