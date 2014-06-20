node default {
  # Configure ntp, the main service
  include ntp

  # Include the python class for Pip and as
  # a req for zk_watcher
  class { 'python':
    version    => 'system',
    dev        => true,
    pip        => true
  }

  # Install zk_watcher on ntp
  zk_watcher::add { 'ntp':
    port    => '123',
    cmd     => 'pgrep ntp',
    path    => "/services/production/ntp",
    data    => ['zone=uswest1a', 'user=mbajor'],
    refresh => '60';
  }

  # Retrieve the list of servers
  $servers = zkget('/services/production/ntp', 0, 10)

  # Display the list of servers
  notify { "There are $servers in the cluster": }

  # Drop a file in /tmp with the nodes
  file { '/tmp/clusternodes':
    ensure  => present,
    content => template('zk_watcher/cluster.erb')
  }

}