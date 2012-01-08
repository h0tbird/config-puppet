Puppet::Type.newtype(:mysqldb) do

    @doc = "Manage creation/deletion of a database."

    ensurable do
        defaultvalues
        defaultto :present
    end

    autorequire(:package) do
        "mysql"
    end

    autorequire(:service) do
        "mysqld"
    end

    newparam(:name) do
        desc "The name of the database."
        isnamevar
    end

    newproperty(:charset) do
        desc "The characterset to use for a database."
        defaultto :utf8
        newvalue(/^\S+$/)
    end
end
