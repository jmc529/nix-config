let
  #   cat /etc/ssh/ssh_host_ed25519_key.pub
  aorus = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMs8hgyhN2MGjlEIWm4oLgk5RpG2S7pBP6THRq7AhKts root@aorus";
  flex5 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKQvqXHwTxAF0f+V3L7oLU+yVUHKsuEgTPuH+IV43/EL root@flex5";
in
{
  "circleci-api-token.age".publicKeys = [
    aorus
    flex5
  ];
}
