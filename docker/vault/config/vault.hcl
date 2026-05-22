ui = "true"
log_level = "INFO"
disable_mlock = "true"

storage "raft" {
  path    = "/vault/file"
  node_id = "raft_master"
}

listener "tcp" {
  address = "0.0.0.0:8200"
  cluster_address = "0.0.0.0:8201"
  tls_disable = "true"
}

telemetry {
  disable_hostname = true
  prometheus_retention_time = "12h"
}