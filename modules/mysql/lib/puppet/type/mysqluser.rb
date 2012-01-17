Puppet::Type.newtype(:mysqluser) do

    @doc = "Manage a database user. This includes management of user password as well as priveleges."

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
        desc "The name of the user. This uses the 'username@hostname' or username@hosname."

        validate do |value|
            unless value =~ /\w+@[\w%]+/
                raise ArgumentError, "Invalid database user #{value}."
            end

            list = value.split('@')

            if list[0].size > 16
                raise ArgumentError, "MySQL usernames are limited to a maximum of 16 characters."
            end
        end
    end

    newproperty(:password_hash) do
        desc "The password hash of the user. Use mysql_password() for creating such a hash."
        newvalue(/\w+/)
    end
end
