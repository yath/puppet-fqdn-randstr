# fqdn_randstr
Returns a random string based on a node's fqdn.

Arguments (optional):

1. length of string to return (default: 15, maximum: 64)
2. alphabet (default: 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!"$%&/()?#*')
3. seed (default: '')
4. iterations (default: 23425)

## Usage
    mkdir -p /etc/puppet/modules
    cd !$
    git clone https://github.com/yath/puppet-fqdn-randstr.git fqdn-randstr
    service puppetmaster restart
