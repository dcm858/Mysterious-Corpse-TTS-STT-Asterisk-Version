#!/usr/bin/ruby
require 'dm-core'
require 'ruby'


DataMapper::setup(:default, {:adapter => 'yaml', :path => 'db'})

class Mystery
    include DataMapper::Resource
    
    property :id, Serial
    property :xorder, String
    property :title, String
    property :author, String
    property :subgenre, String, :required => true
    property :protagonist, String, :required => true
    property :setting, String, :required => true
    property :intro, String
end

DataMapper.finalize

#   Genre = {'legal','noir','satirical','political' }
#   Protagonist = {'Female','Male'}
#  Setting  = {'US','non-US' }
   

    @subgenre = ARGV[0]
    @setting = ARGV[1]
    @protagonist = ARGV[2]
#print(@subgenre)
#print(@setting)
#print(@protagonist)
#    @selected_sentences.intro = mysterytext[ARGV[3]]

    @selected_sentences = Mystery.all(:setting => @setting) & Mystery.all(:protagonist => @protagonist) & Mystery.all(:subgenre => @subgenre)

for items in @selected_sentences 
print(items.intro)
end 

puts(@selected_sentences)
	
