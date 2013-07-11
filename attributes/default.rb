default[:mail_handler] = {
  :to_address => "root",
  :from_address => "chef-client@#{node.fqdn}",
  :send_statuses => ["Successful", "Failed"],
  :hostname => node.fqdn
}