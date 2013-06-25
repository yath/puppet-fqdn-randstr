require 'digest/sha2'

DEF_LENGTH = 15
DEF_ALPHABET = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!"$%&/()?#*'

module Puppet::Parser::Functions
  newfunction(:fqdn_randstr, :type => :rvalue, :doc => <<-EOS
Returns a random string based on a node's fqdn.

Arguments (optional):
  1) length of string to return (default: #{DEF_LENGTH}, maximum: 64)
  2) alphabet (default: '#{DEF_ALPHABET}')
  3) seed (default: '')
EOS
  ) do |args|
    def isset_or_nil(var)
      (var.nil? or (var.respond_to?(:length) and var.length == 0)) ? nil : var
    end

    len = isset_or_nil(args[0]) || DEF_LENGTH
    alphabet = isset_or_nil(args[1]) || DEF_ALPHABET
    seed = isset_or_nil(args[2]) || ''

    begin
      len = Integer(len) # .to_i y u don't throw exception!?!?
    rescue ArgumentError
      raise Puppet::ParseError, 'fqdn_randstr: length must be an integer'
    end

    if len > 64
      raise Puppet::ParseError, 'fqdn_randstr: length must not be larger than 64'
    end

    if not alphabet.kind_of?(String)
      raise Puppet::ParseError, 'fqdn_randstr: alphabet must be a string'
    end

    hash = Digest::SHA512.digest(lookupvar('fqdn') + seed).each_byte.to_a.map{|c| c.ord}

    (0..len-1).map {|i| alphabet[hash[i] % alphabet.length].chr}.join("")
  end
end
