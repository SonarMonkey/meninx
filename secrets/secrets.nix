let
  # Keys/groups
  rootEncephalon = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINOctciQ3konSXRN/UWh6U0XfAMJLvxWG3maQjZv+J59 root@encephalon";
  sonarEncephalon = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMTH4iKtY6k9t/WVtHG0S4SuVJIA+nAb3nC5NNS2M28x sonar@encephalon";
  encephalon = [rootEncephalon sonarEncephalon];
in {
  # Secrets files
  "sonar.age".publicKeys = encephalon;
  "encephalon.age".publicKeys = encephalon;
}
