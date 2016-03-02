require 'fileutils'
require 'tmpdir'

PROJECT_DIR = 'projects'

desc 'Validate the environment name'
task :validate_environment do
  allowed_envs = %w(test staging integration production)

  unless ENV.include?('DEPLOY_ENV') && allowed_envs.include?(ENV['DEPLOY_ENV'])
    warn "Please set 'DEPLOY_ENV' environment variable to one of #{allowed_envs.join(', ')}"
    exit 1
  end

  unless ENV.include?('PROJECT_NAME')
    warn 'Please specify a project name. Use legacy for pre project split code.'
    exit 1
  end

  unless project_name.empty?
    unless File.exists? File.join(PROJECT_DIR, project_name)
      warn "Unable to find project #{project_name} in #{PROJECT_DIR}"
      exit 1
    end
  end
end


desc 'Check for a local statefile'
task :local_state_check do
  state_file = 'terraform.tfstate'

  if File.exist? state_file
    warn 'Local state file should not exist. We use remote state files.'
    exit 1
  end
end


desc 'Purge remote state file'
task :purge_remote_state do
  state_file = '.terraform/terraform.tfstate'

  FileUtils.rm state_file if File.exist? state_file

  if File.exist? state_file
    warn 'state file should not exist.'
    exit 1
  end
end


desc 'Configure the remote state location'
task configure_state: [:validate_environment, :local_state_check, :purge_remote_state] do
  region      = 'eu-west-1'
  bucket_name = "govuk-terraform-state-#{deploy_env}"

  # workaround until we can move everything in to project based layout
  key_name = project_name.empty? ? 'terraform.tfstate' : "terraform-#{project_name}.tfstate"

  args = []
  args << 'terraform remote config'
  args << '-backend=s3'
  args << '-backend-config="acl=private"'
  args << "-backend-config='bucket=#{bucket_name}'"
  args << '-backend-config="encrypt=true"'
  args << "-backend-config='key=#{key_name}'"
  args << "-backend-config='region=#{region}'"

  system(args.join(' '))
end


desc 'create and display the resource graph'
task :graph do
  # todo  - does this need plan / apply to have been run
  system('terraform graph | dot -Tpng > graph.png')
  system('open graph.png')
end


desc 'Apply the monolithic, pre-extracted projects, terraform resources'
task apply_legacy: [:configure_state] do
  system("terraform apply -var-file=#{deploy_env}.tfvars")
end


desc 'Apply the terraform resources'
task apply: [:configure_state] do
  tmp_dir = _flatten_project

  puts "terraform apply -var-file=#{deploy_env}.tfvars #{tmp_dir}"

  system("terraform apply -var-file=#{deploy_env}.tfvars #{tmp_dir}")

  FileUtils.rm_r tmp_dir
end


desc 'Show the plan'
task plan: [:configure_state] do
  tmp_dir = _flatten_project

  system("terraform plan -var-file=#{deploy_env}.tfvars #{tmp_dir}")

  FileUtils.rm_r tmp_dir
end



def _flatten_project
  tmp_dir   = Dir.mktmpdir('tf-temp')
  base_path = File.join(PROJECT_DIR, project_name, 'resources')

  # add an inner loop here if we want to copy other file extensions too
  [ base_path, "#{base_path}/#{deploy_env}" ].each do |dir|
    if ! Dir["#{dir}/*.tf"].empty?
      puts "Working on #{Dir[dir + '/*.tf']}" if debug
      system("terraform get #{dir}")
      FileUtils.cp( Dir["#{dir}/*.tf"], tmp_dir)
    end
  end

  tmp_dir
end

def deploy_env
  ENV['DEPLOY_ENV']
end

def project_name
  ENV['PROJECT_NAME'] == 'legacy' ? '' : ENV['PROJECT_NAME']
end

def debug
  ENV['DEBUG']
end
