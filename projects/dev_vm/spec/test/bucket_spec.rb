require 'spec_helper'

describe s3_bucket('govuk-dev-boxes-test') do
  it { should exist }
end
