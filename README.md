# 🇨🇳 Chinese Flashcards — Infrastructure as Code (IaC) Deployment

A lightweight Mandarin Chinese flashcard web application deployed and managed entirely through **Infrastructure as Code (IaC)** using **Terraform**, **HCP Terraform**, and **Cloudflare Pages** under a zero-cost, serverless edge architecture.

---

## 🏗️ Architecture & Workflow

```text
┌───────────────────┐      Git Push (VCS)      ┌─────────────────────────┐
│                   │ ───────────────────────► │      HCP Terraform      │
│   GitHub Repo     │   (/infra changes)       │  (Remote State & Plan)  │
│                   │ ◄─────────────────────── └────────────┬────────────┘
│  ├── /app         │      Speculative Plan                 │ Terraform Apply
│  └── /infra       │                                       ▼
└─────────┬─────────┘                          ┌─────────────────────────┐
          │                                    │    Cloudflare Pages     │
          └──────────────────────────────────► │  (Edge CDN + Auto SSL)  │
               Git Integration (/app)          └────────────┬────────────┘
                                                            │
                                                            ▼
                                                https://<project>.pages.dev
```

### How It Works
1. **Separation of Concerns (Monorepo):** Application source code (`/app`) and infrastructure definitions (`/infra`) live in the same repository with strict boundary isolation.
2. **Infrastructure CI/CD (HCP Terraform):** Changes pushed to `/infra` trigger automated speculative plans and state-locked runs in **HCP Terraform** via VCS integration.
3. **Application CI/CD (Cloudflare Pages):** Cloudflare monitors only the `/app` root directory (`root_dir = "app"`), automatically deploying updates to the global edge network with zero infrastructure exposure.

---

## 🔐 Security & Engineering Best Practices

* **Principle of Least Privilege (PoLP):** Cloudflare authentication uses a scoped API Token restricted strictly to `Account: Cloudflare Pages (Edit)` rather than a Global API Key.
* **Zero Hardcoded Secrets:** Sensitive credentials (`CLOUDFLARE_API_TOKEN`) are injected at runtime as encrypted *Sensitive Environment Variables* inside HCP Terraform.
* **Attack Surface Reduction:** By isolating `root_dir = "app"`, Terraform state configurations and `.tf` files are never bundled or served publicly on the CDN.
* **State Locking & Reproducibility:** Remote state is encrypted and locked via HCP Terraform, and provider versions are pinned using `.terraform.lock.hcl`.
* **FinOps / Zero-Cost Design:** Built entirely on edge static hosting and free-tier orchestration (`$0.00/month` operational cost).

---

## 📂 Repository Structure

```text
.
├── app/
│   └── index.html          # Self-contained Mandarin flashcard web app
├── infra/
│   ├── terraform.tf        # Terraform version, HCP cloud backend & Cloudflare provider (~> 5.0)
│   ├── variables.tf        # Parameterized inputs (account ID, project name, GitHub metadata)
│   ├── main.tf             # Cloudflare Pages project & Git integration resource
│   └── outputs.tf          # Exposes the deployed *.pages.dev subdomain
├── .gitignore              # Excludes local .terraform caches, state files, and .tfvars
└── README.md
```

---

## 🗺️ Roadmap

* [x] **Phase 1:** Edge static deployment via Terraform + HCP Terraform + Cloudflare Pages (`$0.00/mo`).
* [ ] **Phase 2:** Add static security scanning (`Checkov` / `tfsec`) via GitHub Actions on Pull Requests.
* [ ] **Phase 3:** Migrate hardcoded flashcards to a managed **Supabase** PostgreSQL backend with Row-Level Security (RLS) and **AWS** serverless integrations (API Gateway + Lambda + OIDC).
* [ ] **Phase 4:** To be defined...