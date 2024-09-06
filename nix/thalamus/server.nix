{
  config,
  pkgs,
  ...
}: {
  boot.initrd.network.ssh.enable = true;

  services.openssh = {
    enable = true;
    hostKeys = [{} {}];
  };

  environment.variables = {
    SOFT_SERVE_DATA_PATH = "/data/soft-serve";
    SOFT_SERVE_INITIAL_ADMIN_KEYS = "FIXME";
  };

  services.cloudflared = {
    enable = true;
  };

  services.wastebin = {
    enable = true;
    stateDir = "/data/wastebin";
    secretFile = config.age.secrets.waste.path;
    settings = {
      WASTEBIN_TITLE = "example.com WASTEBIN";
      WASTEBIN_BASE_URL = "https://waste.example.com";
      WASTEBIN_ADDRESS_PORT = "127.0.0.1:8088";
      WASTEBIN_DATABASE_PATH = "/data/wastebin/waste.db";
    };
  };

  services.jellyfin = {
    enable = true;
    openFirewall = false;
    dataDir = "/data/jellyfin";
    configDir = "\${cfg.dataDir}/config";
    logDir = "\${cfg.dataDir}/log";
    cacheDir = "\${cfg.dataDir}/cache";
  };

  services.soft-serve = {
    enable = true;
    settings = {
      name = "example.com SOFTSERVE";
      ssh = {
        listen_addr = ":22";
        public_url = "ssh://git.example.com";
        key_path = "FIXME";
        client_key_path = "FIXME";
        max_timeout = 0;
        idle_timeout = 0;
      };
      git = {
        listen_addr = ":9418";
        max_timeout = 0;
        idle_timeout = 3;
        max_connections = 32;
      };
      http = {
        listen_addr = ":443";
        public_url = "https://git.example.com";
      };
      stats = {
        listen_addr = "localhost:23233";
      };
      db = {
        driver = "sqlite";
        data_source = "/data/soft-serve/soft.db";
      };
    };
  };

  services.seafile = {
    enable = true;
    adminEmail = "admin@example.com";
    initialAdminPassword = "pigeon-green-phone-incorrect";
    ccnetSettings.General.SERVICE_URL = "https://sea.example.com";
    seafileSettings.fileserver.host = "127.0.0.1";
    seafileSettings.fileserver.port = "8082";
  };
}
