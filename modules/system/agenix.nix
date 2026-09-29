{ inputs, pkgs, ... }:

{
  environment.systemPackages = [
    inputs.agenix.packages.x86_64-linux.default
    pkgs.age
  ];

  age.secrets.circleci-api-token = {
    file = inputs.self + "/secrets/circleci-api-token.age";
    owner = "joe";
    mode = "0400";
  };
}
