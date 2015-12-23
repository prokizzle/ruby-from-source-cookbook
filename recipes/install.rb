#
# Cookbook Name:: ruby-from-source
# Recipe:: install
#
# Copyright 2015, Nick Prokesch
#
# All rights reserved - Do Not Redistribute
#

# install ruby dependencies

package 'build-essential'
package 'zlib1g-dev'
package 'libssl-dev'
package 'libreadline6-dev'
package 'libyaml-dev'
package 'libsqlite3-dev'
package 'libffi6'
package 'libffi-dev'
package 'libxslt-dev'
package 'libxml2-dev'
package 'libmysqlclient-dev'
package 'libmysqlclient18'
package 'ruby-dev'

# install ruby

execute 'download ruby' do
  cwd '/tmp'
  command "wget #{node[:app][:ruby][:url]}"
  action :run
  not_if "[[ $(ruby -v) =~ #{node[:app][:ruby][:version]} ]]"
end

execute 'untar ruby' do
  cwd '/tmp'
  command "tar -xvzf ruby-#{node[:app][:ruby][:version]}.tar.gz"
  action :run
  not_if "[[ $(ruby -v) =~ #{node[:app][:ruby][:version]} ]]"
end

execute 'configure ruby' do
  cwd "/tmp/ruby-#{node[:app][:ruby][:version]}/"
  command './configure --prefix=/usr/local --disable-install-doc'
  action :run
  not_if "[[ $(ruby -v) =~ #{node[:app][:ruby][:version]} ]]"
end

execute 'make' do
  cwd "/tmp/ruby-#{node[:app][:ruby][:version]}/"
  command 'make'
  action :run
  not_if "[[ $(ruby -v) =~ #{node[:app][:ruby][:version]} ]]"
end

execute 'make install' do
  cwd "/tmp/ruby-#{node[:app][:ruby][:version]}/"
  command 'make install'
  action :run
  not_if "[[ $(ruby -v) =~ #{node[:app][:ruby][:version]} ]]"
end

gem_package 'bundler'
