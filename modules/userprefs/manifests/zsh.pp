class userprefs::zsh (
  $default = true,
) {
  package { 'zsh':
    ensure => present,
  }

  file { '/root/.zprofile':
    ensure => link,
    target => '/root/.profile',
  }

  file { '/root/.zshrc':
    ensure  => file,
    source  => 'puppet:///modules/userprefs/shell/zshrc',
    require => Package['zsh'],
  }

  file { '/root/.customzshrc':
    ensure  => file,
    require => File['/root/.zshrc'],
  }

  if $default {
    user { 'root':
      ensure  => present,
      shell   => '/bin/zsh',
      require => Package['zsh'],
    }
  }
}
