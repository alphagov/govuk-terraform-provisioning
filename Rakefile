require 'fileutils'
require 'rspec/core/rake_task'
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
    warn 'Please set the "PROJECT_NAME" environment variable.'
    exit 1
  end

  unless ENV.include?('TF_VAR_account_id')
    warn 'Please set the "TF_VAR_account_id" environment variable.'
    exit 1
  end

  unless project_name.empty?
    unless File.exist? File.join(PROJECT_DIR, project_name)
      warn "Unable to find project #{project_name} in #{PROJECT_DIR}"
      exit 1
    end
  end
end


desc 'Run the given projects awsspec tests'
RSpec::Core::RakeTask.new('spec') do |task|
  spec_dir = File.join(PROJECT_DIR, project_name, 'spec')

  base_specs        = Dir["#{spec_dir}/*_spec.rb"]
  environment_specs = Dir["#{spec_dir}/#{deploy_env}/*_spec.rb"]

  all_specs = base_specs + environment_specs

  task.pattern = all_specs.join(',')
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


desc 'Configure the remote state. Destroys local only state.'
task configure_state: [:local_state_check, :configure_s3_state] do
  # This exists because in the default case we want to delete local state.
  #
  # In a bootstrap situation don't purge the local state otherwise we'll
  # never have anything to push to S3.
  true
end


desc 'Configure the remote state location'
task configure_s3_state: [:validate_environment, :purge_remote_state] do
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

  system(args.join(' ')) or raise 'Error running Terraform to configure state'
end


desc 'create and display the resource graph'
task graph: [:configure_state] do
  tmp_dir = _flatten_project
  system("terraform graph #{tmp_dir} | dot -Tpng > graph.png")
  system('open graph.png')
  FileUtils.rm_r tmp_dir
end


desc 'Apply the terraform resources'
task apply: [:configure_state] do
  tmp_dir = _flatten_project

  puts "terraform apply -var-file=variables/#{deploy_env}.tfvars #{tmp_dir}"

  system("terraform apply -var-file=variables/#{deploy_env}.tfvars #{tmp_dir}")

  FileUtils.rm_r tmp_dir
end


desc 'Destroy the terraform resources'
task destroy: [:configure_state] do
  tmp_dir = _flatten_project

  puts "terraform destroy -var-file=variables/#{deploy_env}.tfvars #{tmp_dir}"

  system("terraform destroy -var-file=variables/#{deploy_env}.tfvars #{tmp_dir}")

  FileUtils.rm_r tmp_dir
end


desc 'Show the plan'
task plan: [:configure_state] do
  tmp_dir = _flatten_project

  system("terraform plan -module-depth=-1 -var-file=variables/#{deploy_env}.tfvars #{tmp_dir}")

  FileUtils.rm_r tmp_dir
end

# FIXME: This errors on initial run, but does the correct thing, but needs to be run twice.
desc 'Bootstrap a project from local configuration to a clean bucket'
task :bootstrap do
  tmp_dir = _flatten_project

  system("terraform plan -module-depth=-1 -var-file=variables/#{deploy_env}.tfvars #{tmp_dir}")
  system("terraform apply -var-file=variables/#{deploy_env}.tfvars #{tmp_dir}")

  Rake::Task['configure_s3_state'].invoke

  FileUtils.rm_r tmp_dir
end

def _flatten_project
  tmp_dir   = Dir.mktmpdir('tf-temp')
  base_path = File.join(PROJECT_DIR, project_name, 'resources')

  # add an inner loop here if we want to copy other file extensions too
  [ 'configs', base_path, "#{base_path}/#{deploy_env}" ].each do |dir|
    next if Dir["#{dir}/*.tf"].empty?

    puts "Working on #{Dir[dir + '/*.tf']}" if debug
    system("terraform get #{dir}")
    FileUtils.cp( Dir["#{dir}/*.tf"], tmp_dir)
  end

  tmp_dir
end

def deploy_env
  ENV['DEPLOY_ENV']
end

def project_name
  ENV['PROJECT_NAME']
end

def debug
  ENV['DEBUG']
end
