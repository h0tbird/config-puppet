require 'fileutils'

Puppet::Type.type(:gitrepo).provide(:git) do
    desc "Provides support for the gitrepo provider."
    commands :gitcmd => "git"

    def create
        FileUtils.rm_rf resource[:path]
        gitcmd "clone", resource[:source], resource[:path]
    end

    def destroy
        FileUtils.rm_rf resource[:path]
    end

    def exists?
        File.directory?(resource[:path] + "/.git")
    end
end
