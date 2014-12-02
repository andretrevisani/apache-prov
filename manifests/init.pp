class apache-prov {
	file{"/u00":
		ensure => 'directory',
		owner => 'root',
		group => 'root',
		mode => '0644',
	}

	file{"/u00/apache.tar.gz":
		source => "puppet:///modules/apache-prov/puppet/apache.tar.gz",
		owner => 'root',
		group => 'root',
		mode => '0644',
		require => file['/u00'],
	}

	archive::extract{"apache":
		src_target => "/u00",
		ensure => present,
		target => "/u00/",
		extension => "tar.gz",
		require => file['/u00/apache.tar.gz'],
	}

	exec{"start":
		command => "/u00/apache/bin/apachectl start",
		require => archive::extract['apache'],
	}
}

