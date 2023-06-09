require 'yaml'

describe 'compiled component efs-access-point' do
  
  context 'cftest' do
    it 'compiles test' do
      expect(system("cfhighlander cftest #{@validate} --tests tests/default.test.yaml")).to be_truthy
    end      
  end
  
  let(:template) { YAML.load_file("#{File.dirname(__FILE__)}/../out/tests/default/efs-access-point.compiled.yaml") }

  context "Parameters" do
    let(:parameters) { template["Parameters"] }

    it "has EnvironmentName parameter" do
        expect(parameters["EnvironmentName"]).to eq({
          "Default" => "dev",
          "NoEcho" => false,
          "Type" => "String",
        })
    end
  end
  
end