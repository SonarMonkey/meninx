let
  # Desktop
  rootCerebrum = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG9beZvL+xCrb0AZ2NbSFtKNjcRcopRM1QtgNoAbMWIe root@cerebrum";
  sonarCerebrum = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGFQmRqecMfCcVbI7KNTYKXY/+mKjv7rKSOQSqtbFDvF sonar@cerebrum";
  cerebrum = [rootCerebrum sonarCerebrum];

  # Laptop
  rootEncephalon = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINOctciQ3konSXRN/UWh6U0XfAMJLvxWG3maQjZv+J59 root@encephalon";
  sonarEncephalon = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMTH4iKtY6k9t/WVtHG0S4SuVJIA+nAb3nC5NNS2M28x sonar@encephalon";
  encephalon = [rootEncephalon sonarEncephalon];
in {
  # Secrets files
  "sonar.age".publicKeys = cerebrum ++ encephalon;
  "cerebrum.age".publicKeys = cerebrum ++ encephalon;
  "encephalon.age".publicKeys = cerebrum ++ encephalon;
  "mullvad.age".publicKeys = cerebrum ++ encephalon;
}
