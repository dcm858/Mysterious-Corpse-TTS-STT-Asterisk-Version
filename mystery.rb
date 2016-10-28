#!/usr/bin/ruby
require 'dm-core'
#require 'rubygems'


DataMapper::setup(:default, {:adapter => 'yaml', :path => '/home/dm1346/db'})

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

# the options "subgenre" "setting" and "protagonist" that are selected in Asterisk and passed thru the command line thru this script are fed into
#the following filter that extracts the matching records from the Mystery database. The result is put into the variable @selected_sentences.

    @selected_sentences = Mystery.all(:subgenre => @subgenre) & Mystery.all(:setting => @setting) & Mystery.all(:protagonist => @protagonist)

for items in @selected_sentences 
  print(items.intro)
  # If want to limit number of sentences to avoid overwhelming Asterisk, use "exit" to print only the first matching record then exit the program.
  #exit
end 
	
