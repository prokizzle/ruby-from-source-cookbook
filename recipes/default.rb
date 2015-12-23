#
# Cookbook Name:: ruby-from-source
# Recipe:: default
#
# Copyright 2015, Nick Prokesch
#
# All rights reserved - Do Not Redistribute
#

unless %x{[[ $(ruby -v) =~ #{node[:app][:ruby][:version]} ]] }
    include_recipe 'ruby_from_source::install'
end
