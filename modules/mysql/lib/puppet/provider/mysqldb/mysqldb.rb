Puppet::Type.type(:mysqldb).provide(:mysqldb) do

    desc "Create mysql database."

    def create
        `mysql -NBe "CREATE DATABASE #{resource[:name]} CHARACTER SET #{resource[:charset]}"`
    end

    def destroy
        `mysqladmin -f drop #{resource[:name]}`
    end

    def exists?
        `mysql -NBe "show databases"`.match(/^#{resource[:name]}$/)
    end

    def charset
        `mysql -NBe "show create database #{resource[:name]}"`.match(/.*?(\S+)\s\*\//)[1]
    end

    def charset=(value)
        `mysql -NBe "alter database #{resource[:name]} CHARACTER SET #{value}"`
    end
end
