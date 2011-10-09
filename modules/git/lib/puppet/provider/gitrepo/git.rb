require 'fileutils'

Puppet::Type.type(:gitrepo).provide(:git) do

    commands :gitcmd => "git"

    def create
        gitcmd "clone", resource[:source], resource[:path]
    end

    def destroy
        FileUtils.rm_rf resource[:path]
    end

    def exists?
        File.directory? resource[:path]
    end
end
