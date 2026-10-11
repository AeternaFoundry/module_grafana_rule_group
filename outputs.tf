output "rule_groups_id" {
  description = "Map of id values across all rule_groups, keyed the same as var.rule_groups except keys with no id are omitted"
  value       = { for k, v in grafana_rule_group.rule_groups : k => v.id if v.id != null && length(v.id) > 0 }
}
output "rule_groups_disable_provenance" {
  description = "Map of disable_provenance values across all rule_groups, keyed the same as var.rule_groups except keys with no disable_provenance are omitted"
  value       = { for k, v in grafana_rule_group.rule_groups : k => v.disable_provenance if v.disable_provenance != null }
}
output "rule_groups_folder_uid" {
  description = "Map of folder_uid values across all rule_groups, keyed the same as var.rule_groups except keys with no folder_uid are omitted"
  value       = { for k, v in grafana_rule_group.rule_groups : k => v.folder_uid if v.folder_uid != null && length(v.folder_uid) > 0 }
}
output "rule_groups_interval_seconds" {
  description = "Map of interval_seconds values across all rule_groups, keyed the same as var.rule_groups except keys with no interval_seconds are omitted"
  value       = { for k, v in grafana_rule_group.rule_groups : k => v.interval_seconds if v.interval_seconds != null }
}
output "rule_groups_name" {
  description = "Map of name values across all rule_groups, keyed the same as var.rule_groups except keys with no name are omitted"
  value       = { for k, v in grafana_rule_group.rule_groups : k => v.name if v.name != null && length(v.name) > 0 }
}
output "rule_groups_org_id" {
  description = "Map of org_id values across all rule_groups, keyed the same as var.rule_groups except keys with no org_id are omitted"
  value       = { for k, v in grafana_rule_group.rule_groups : k => v.org_id if v.org_id != null && length(v.org_id) > 0 }
}
output "rule_groups_rule" {
  description = "Map of rule values across all rule_groups, keyed the same as var.rule_groups except keys with no rule are omitted"
  value       = { for k, v in grafana_rule_group.rule_groups : k => v.rule if v.rule != null && length(v.rule) > 0 }
}

