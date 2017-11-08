#
# Cookbook Name:: chef-mail-handler
# Recipe:: default
#
# Copyright (C) 2013 TABLE XI
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

directory "#{node[:chef_client][:conf_dir]}/handlers/mail" do
  recursive true
  action :nothing
end.run_action(:create)

cookbook_file "#{node[:chef_client][:conf_dir]}/handlers/mail/mail.rb" do
  source 'mail.rb'
  action :nothing
end.run_action(:create)

cookbook_file "#{node[:chef_client][:conf_dir]}/handlers/mail/mail.erb" do
  source 'mail.erb'
  action :nothing
end.run_action(:create)

chef_gem "mail" do
  version "2.6.6"
end

chef_gem "pony" do
  version "1.11"
end

enable_handler = (node[:mail_handler][:enable]) ? :enable : :disable

chef_handler "MailHandler" do
  source "#{node[:chef_client][:conf_dir]}/handlers/mail/mail"
  arguments(
  	:to_address => node[:mail_handler][:to_address],
  	:from_address => node[:mail_handler][:from_address],
  	:send_statuses => node[:mail_handler][:send_statuses],
    :hostname => node[:mail_handler][:hostname],
    :via => node[:mail_handler][:via],
    :via_options => node[:mail_handler][:via_options]
  )
  action :nothing
end.run_action(enable_handler)
