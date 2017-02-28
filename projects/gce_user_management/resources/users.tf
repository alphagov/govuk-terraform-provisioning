resource "google_service_account" "dns_service_account" {
  account_id = "dns-service-account"
  display_name = "DNS service account"
}

data "google_iam_policy" "govuk_test_iam_policies" {
  binding {
    role = "roles/dns.admin"
    members = [
      "serviceAccount:${google_service_account.dns_service_account.email}",
    ]
  }

  # FIXME This won't work as owners have to be set via the console.
  # I'm not sure whether this can be used to populate editors who can then
  # be manually upgraded or whether we don't actually need that many owners?
  binding {
    role = "roles/owner"
    members = [
      "user:ana.fernandez@digital.cabinet-office.gov.uk",
      "user:dean.wilson@digital.cabinet-office.gov.uk",
      "user:laura.martin@digital.cabinet-office.gov.uk",
    ]
  }

  binding {
    role = "roles/editor"
    members = [
      "user:mikael.allison@digital.cabinet-office.gov.uk",
      "user:sam.cook@digital.cabinet-office.gov.uk",
    ]
  }
}
