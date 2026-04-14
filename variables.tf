variable "student_name" {
  description = "Your short lowercase name, used as a subdomain prefix"
  type        = string
}

variable "zone_name" {
  description = "The shared hosted zone all students write into"
  type        = string
  default     = "ironlabs.online"
}

variable "record_ttl" {
  description = "TTL in seconds for all records in this lab"
  type        = number
  default     = 60
}