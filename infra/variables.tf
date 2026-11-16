variable "cloudflare_account_id" {
  type        = string
  description = "Account ID of cloudflare"
}

variable "project_name" {
  type        = string
  description = "Name of the project"
  default     = "chinese-app"
}

variable "github_owner" {
  type        = string
  description = "Owner of the associated github"
  default     = "Marcelo8D"
}

variable "github_repo" {
  type        = string
  description = "Repo of the associated github"
  default     = "chinese-flashcards-iac"
} 