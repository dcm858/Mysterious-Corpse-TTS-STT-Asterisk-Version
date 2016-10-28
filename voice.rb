
[dm1346.m_ivr]
exten => s,1,Answer()
exten => s,n,Set(TIMEOUT(digit)=5)
exten => s,1,AGI(home/dm1346/asterisk_agi/main_agi.rb)
exten => s,n,agi(googletts.agi,"Welcome to the Mysterious Corpse",en)
;;Wait for digit:
exten => s,n(start),agi(googletts.agi,"Please dial a digit.",en,any)
exten => s,n,WaitExten()

;;PLayback the name of the digit and wait for another one:
exten => _X,1,agi(googletts.agi,"You just pressed ${EXTEN}. Try another one please.",en,any)
exten => _X,n,WaitExten()

exten => i,1,agi(googletts.agi,"Invalid extension.",en)
exten => i,n,goto(s,start)

exten => t,1,agi(googletts.agi,"Request timed out.",en)
exten => t,n,goto(s,start)

exten => h,1,Hangup()




#1/ usr/bin/ruby

require 'rubygems'
require 'sinatra'
require 'ruby-agi'
require 'dm-core'
require 'data_mapper'  #database integration

agi = AGI.new

#start agi scripting



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





get '/' do
  erb :create_mystery
end

post '/save_choices' do
    
    @protagonist = params[:protagonist]
    @subgenre = params[:subgenre]
    @setting = params[:setting]
    @title = params[:title]
    @author = params[:author]

    @selected_sentences = Mystery.all(:setting => @setting) & Mystery.all(:protagonist =>@protagonist) & Mystery.all(:subgenre => @subgenre)
    erb :display

end

get '/add' do
    erb :addMystery
end

post '/save_add' do
    Mystery.create(:title => params[:title],
        :author => params[:author],
        :subgenre => params[:subgenre],
        :protagonist => params[:protagonist],
        :setting => params[:setting],
        :intro => params[:intro])
    erb :saved
end 

get '/select_delete' do
    @Mysteryall= Mystery.all
    erb :select_delete
end

post '/delete' do
   id = params[:id]
   todelete =  Mystery.all(:id => id)
   todelete.destroy  
   erb :deleted
end



   
