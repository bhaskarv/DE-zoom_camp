terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.8.0"
    }
  }
}

provider "google" {
  project = "exalted-point-450512-r6"
  region  = "asia-south1"
  zone    = "asia-south1-a"
}


resource "google_storage_bucket" "exalted_point_450512_r6_data_lake_bucket" {
  name = "exalted_point_450512_r6_dtc_de_course_bucket"
  location = "asia"

  storage_class = "STANDARD"
  uniform_bucket_level_access = true

  versioning {
    enabled = true
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age = 30  # Days
    }
  }

  force_destroy = true
}


resource "google_bigquery_dataset" "ny_taxi" {
  dataset_id = "NY_TAXI"
  project = "exalted-point-450512-r6"
  location = "us"
  
}

# resource "google_compute_network" "vpc_network" {
#   name = "terraform-network"
# }

# output "hello_world" {
#   value="Hello World!!"
# }