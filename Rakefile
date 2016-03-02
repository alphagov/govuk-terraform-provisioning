
desc 'Validate the environment name'
task :validate_environment do
  allowed_envs = %w(test staging integration production)

  unless ENV.include?('DEPLOY_ENV') && allowed_envs.include?(ENV['DEPLOY_ENV'])
    warn "Please set 'DEPLOY_ENV' environment variable to one of #{allowed_envs.join(', ')}"
    exit 1
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

  args = []
  args << 'terraform remote config'
  args << '-backend=s3'
  args << '-backend-config="acl=private"'
  args << "-backend-config='bucket=#{bucket_name}'"
  args << '-backend-config="encrypt=true"'
  args << '-backend-config="key=terraform.tfstate"'
  args << "-backend-config='region=#{region}'"

  system(args.join(' '))
end


desc 'create and display the resource graph'
task :graph do
  # todo  - does this need plan / apply to have been run
  system('terraform graph | dot -Tpng > graph.png')
  system('open graph.png')
end


desc 'Apply the terraform resources'
task apply: [:configure_state] do
  system("terraform apply -var-file=#{deploy_env}.tfvars")
end


desc 'Show the plan'
task plan: [:configure_state] do
  system("terraform plan -var-file=#{deploy_env}.tfvars")
end

def deploy_env
  ENV['DEPLOY_ENV']
end
