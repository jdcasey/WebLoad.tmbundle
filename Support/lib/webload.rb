#!/usr/bin/env ruby

SUPPORT = ENV['TM_SUPPORT_PATH']

require 'rubygems'
require 'net/http'
require 'uri'
require SUPPORT + '/lib/ui'
# require SUPPORT + '/lib/tm/htmloutput'

class WebLoad
  
  def initialize
  end #initialize
  
  def load_from_url
    page = TextMate::UI.request_string( {:title=>'Open URL...', :prompt=>"Web URL: "}).chomp
    uri = URI.parse( page )
    response = Net::HTTP.get_response( uri )
    
    parts = page.split( '/' )
    fname = "/tmp/#{parts[-1]}"
    File.open( fname, 'w' ) {|f| f.puts response.body}
    
    `open txmt://open?url=file://#{URI.escape(fname)}`
  end #load_from_url
  
end #class
