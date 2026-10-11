variable "rule_groups" {
  description = <<EOT
Map of rule_groups, attributes below
Required:
    - folder_uid
    - interval_seconds
    - name
    - rule (block):
        - annotations (optional)
        - condition (optional)
        - data (required, block):
            - datasource_uid (required)
            - model (required)
            - query_type (optional)
            - ref_id (required)
            - relative_time_range (required, block):
                - from (required)
                - to (required)
        - exec_err_state (optional)
        - for (optional)
        - is_paused (optional)
        - keep_firing_for (optional)
        - labels (optional)
        - missing_series_evals_to_resolve (optional)
        - name (required)
        - no_data_state (optional)
        - notification_settings (optional, block):
            - active_timings (optional)
            - contact_point (optional)
            - group_by (optional)
            - group_interval (optional)
            - group_wait (optional)
            - mute_timings (optional)
            - policy (optional)
            - repeat_interval (optional)
        - record (optional, block):
            - from (required)
            - metric (required)
            - target_datasource_uid (optional)
        - uid (optional)
Optional:
    - disable_provenance
    - org_id
EOT

  type = map(object({
    folder_uid         = string
    interval_seconds   = number
    name               = string
    disable_provenance = optional(bool)
    org_id             = optional(string)
    rule = list(object({
      annotations = optional(map(string))
      condition   = optional(string)
      data = list(object({
        datasource_uid = string
        model          = string
        query_type     = optional(string)
        ref_id         = string
        relative_time_range = object({
          from = number
          to   = number
        })
      }))
      exec_err_state                  = optional(string)
      for                             = optional(string)
      is_paused                       = optional(bool)
      keep_firing_for                 = optional(string)
      labels                          = optional(map(string))
      missing_series_evals_to_resolve = optional(number)
      name                            = string
      no_data_state                   = optional(string)
      notification_settings = optional(object({
        active_timings  = optional(list(string))
        contact_point   = optional(string)
        group_by        = optional(list(string))
        group_interval  = optional(string)
        group_wait      = optional(string)
        mute_timings    = optional(list(string))
        policy          = optional(string)
        repeat_interval = optional(string)
      }))
      record = optional(object({
        from                  = string
        metric                = string
        target_datasource_uid = optional(string)
      }))
      uid = optional(string)
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.rule_groups : (
        length(v.rule) >= 1
      )
    ])
    error_message = "Each rule list must contain at least 1 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.rule_groups : (
        alltrue([for item in v.rule : (length(item.data) >= 1)])
      )
    ])
    error_message = "Each data list must contain at least 1 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.rule_groups : (
        alltrue([for item in v.rule : (alltrue([for item in item.data : (can(jsondecode(item.model)))]))])
      )
    ])
    error_message = "must be valid JSON"
  }
  # Note: 3 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

