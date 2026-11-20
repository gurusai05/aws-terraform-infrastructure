"""Dependency-free repository sanity checks; not a substitute for terraform validate or AWS deployment."""
from pathlib import Path
import unittest

ROOT = Path(__file__).resolve().parents[1]

class RepositoryChecks(unittest.TestCase):
    def test_required_files(self):
        for path in ["terraform/main.tf", "terraform/variables.tf", "terraform/outputs.tf", "terraform/user-data.sh", ".github/workflows/terraform.yml", "README.md"]:
            with self.subTest(path=path):
                self.assertTrue((ROOT / path).is_file())

    def test_no_default_ssh_ingress(self):
        main = (ROOT / "terraform/main.tf").read_text()
        self.assertNotIn('from_port   = 22', main)
        self.assertIn('http_tokens = "required"', main)
        self.assertIn('encrypted   = true', main)

    def test_web_server_bootstrap(self):
        script = (ROOT / "terraform/user-data.sh").read_text()
        self.assertIn('dnf install -y nginx', script)
        self.assertIn('systemctl enable --now nginx', script)

if __name__ == "__main__":
    unittest.main()
