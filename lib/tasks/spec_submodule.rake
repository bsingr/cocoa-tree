desc 'Update Specs folder'
task :spec_submodule do
	Dir.chdir('Specs') do
		system 'git pull'
	end
end
