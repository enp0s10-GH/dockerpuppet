node 'puppetagent1.hetzner.company' { 	# will be executed only for this node, use FQDN
  file { '/root/testdir/test':   	# resource type and filename
	ensure => present,        	# must be present
	mode => '0644',             	# file permission
	content => "Hello World!\n", 	# file content
  }
}

node default {}         # will be executed for all nodes not mentioned explicitly
