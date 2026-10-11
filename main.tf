resource "grafana_rule_group" "rule_groups" {
  for_each = var.rule_groups

  folder_uid         = each.value.folder_uid
  interval_seconds   = each.value.interval_seconds
  name               = each.value.name
  disable_provenance = each.value.disable_provenance
  org_id             = each.value.org_id

  dynamic "rule" {
    for_each = each.value.rule
    content {
      annotations = rule.value.annotations
      condition   = rule.value.condition
      dynamic "data" {
        for_each = rule.value.data
        content {
          datasource_uid = data.value.datasource_uid
          model          = data.value.model
          query_type     = data.value.query_type
          ref_id         = data.value.ref_id
          relative_time_range {
            from = data.value.relative_time_range.from
            to   = data.value.relative_time_range.to
          }
        }
      }
      exec_err_state                  = rule.value.exec_err_state
      for                             = rule.value.for
      is_paused                       = rule.value.is_paused
      keep_firing_for                 = rule.value.keep_firing_for
      labels                          = rule.value.labels
      missing_series_evals_to_resolve = rule.value.missing_series_evals_to_resolve
      name                            = rule.value.name
      no_data_state                   = rule.value.no_data_state
      dynamic "notification_settings" {
        for_each = rule.value.notification_settings != null ? [rule.value.notification_settings] : []
        content {
          active_timings  = notification_settings.value.active_timings
          contact_point   = notification_settings.value.contact_point
          group_by        = notification_settings.value.group_by
          group_interval  = notification_settings.value.group_interval
          group_wait      = notification_settings.value.group_wait
          mute_timings    = notification_settings.value.mute_timings
          policy          = notification_settings.value.policy
          repeat_interval = notification_settings.value.repeat_interval
        }
      }
      dynamic "record" {
        for_each = rule.value.record != null ? [rule.value.record] : []
        content {
          from                  = record.value.from
          metric                = record.value.metric
          target_datasource_uid = record.value.target_datasource_uid
        }
      }
      uid = rule.value.uid
    }
  }
}

