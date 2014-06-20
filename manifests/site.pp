node default {
  include ntp

  class { 'python':
    version    => 'system',
    dev        => true,
    pip        => true
  }

  zk_watcher::add { 'ntp':
    port    => '123',
    cmd     => 'pgrep ntp',
    path    => '/services/production/uswest1/ntp',
    data    => ['zone=uswest1a', 'user=mbajor'],
    refresh => '60';
  }
}