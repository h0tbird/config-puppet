Puppet::Type.newtype(:gitrepo) do

    ensurable

    newparam(:source) do
        isnamevar
    end

    newparam(:path) do
        validate do |value|
            unless value =~ /^\/[a-z0-9]+/
                raise ArgumentError, "%s is not a valid file path" % value
            end
        end
    end
end
