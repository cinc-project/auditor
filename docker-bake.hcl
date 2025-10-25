variable "CHANNEL" {
  default = "current"
}

variable "VERSION" {}
variable "MAJ" {}
variable "MIN" {}

target "default" {
  context = "."
  dockerfile = "Dockerfile"
  platforms = [
    "linux/amd64",
    "linux/arm64"
  ]

  args = {
    VERSION = VERSION
    CHANNEL = CHANNEL
  }

  tags = CHANNEL == "current" ? [
    "cincproject/auditor:${VERSION}",
    "cincproject/auditor:current"
    ] : [
    "cincproject/auditor:${VERSION}",
    "cincproject/auditor:latest",
    "cincproject/auditor:${MAJ}.${MIN}",
    "cincproject/auditor:${MAJ}"
  ]
}
