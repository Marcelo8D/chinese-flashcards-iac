resource "cloudflare_pages_project" "chinese_flashcards" {
  account_id        = var.cloudflare_account_id
  name              = var.project_name
  production_branch = "main"
  build_config = {
    build_caching = true
    //destination_dir = "build"
    root_dir = "app"
  }
  source = {
    config = {
      production_branch          = "main"
      preview_deployment_setting = "none"
      owner                      = var.github_owner
      repo_name                  = var.github_repo
    }
    type = "github"
  }
}