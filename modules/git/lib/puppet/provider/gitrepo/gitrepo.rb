require 'fileutils'

Puppet::Type.type(:gitrepo).provide(:gitrepo) do

    desc "Provides support for the gitrepo provider."

    def create
        destroy
        system "git clone '#{resource[:source]}' '#{resource[:path]}'"
        ownership
    end

    def destroy
        FileUtils.rm_rf resource[:path]
    end

    def exists?
        if File.directory?(resource[:path] + "/.git")
            ownership
            return true
        end
    end

    def ownership
        if resource[:owner] or resource[:group]
            owner = resource[:owner] || nil
            group = resource[:group] || nil
            excld = resource[:exclude] || nil
            system "find '#{resource[:path]}' -not -iwholename '#{excld}' | xargs chown '#{owner}':'#{group}'"
        end
    end
end
