require 'aws-sdk'

client = Aws::SSM::Client.new(region: 'us-east-1')

resp = client.get_parameters({
  names: ["welcome"], # required
  with_decryption: false,
})

welcomestring = resp.parameters[0].value
 
file_names = ['sample_ssm_config.json']

file_names.each do |file_name|
  text = File.read(file_name)
  new_contents = text.gsub(/REPLACE_ME/, welcomestring)

  # To merely print the contents of the file, use:
  puts new_contents

  # To write changes to the file, use:
  File.open(file_name, "w") {|file| file.puts new_contents.to_s }
end
