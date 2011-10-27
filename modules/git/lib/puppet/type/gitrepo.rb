Puppet::Type.newtype(:gitrepo) do

    @doc = "Manage git repositories."
    ensurable

    autorequire(:package) do
        "git"
    end

    newparam(:source) do
        desc "The URL for the repository to clone."
        isnamevar
        validate do |value|
            unless value =~ /^git/
                raise ArgumentError, "%s is not a valid URL." % value
            end
        end
    end

    newparam(:path) do
        desc "The file path location to clone the repository out to."
        validate do |value|
            unless value =~ /^\/[a-z0-9]+/
                raise ArgumentError, "%s is not a valid file path." % value
            end
        end
    end

    newparam(:mode) do
        desc "Mode the files should be (in octal)."
        validate do |value|
            unless value =~ /^[0-7]+$/
                raise ArgumentError, "%s is not a valid mode." % value
            end
        end
    end

    newparam(:owner) do
        desc "The user/uid that owns the repository files."
    end

    newparam(:group) do
        desc "The group/gid that owns the repository files."
    end

    newparam(:exclude) do
        desc "As in: find /etc -not -iwholename 'exclude goes here'"
    end
end
