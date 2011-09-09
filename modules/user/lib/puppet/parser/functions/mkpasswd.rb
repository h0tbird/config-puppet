#------------------------------------------------------------------------------
# mkpasswd ('password', '12345678')
#------------------------------------------------------------------------------

module Puppet::Parser::Functions
    newfunction(:mkpasswd, :type => :rvalue) do |args|
        salt = args[1].crypt("puppet")
        %x{/usr/bin/printf #{args[0]} | /usr/bin/openssl passwd -1 -salt #{salt} -stdin}.chomp
    end
end
