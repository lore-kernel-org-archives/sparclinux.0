From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Fri, 21 Jul 2017 01:51:01 +0000
Subject: [PATCH v1 4/4] sparc64: add boot line core to context domain parameter
Message-Id: <1500601861-203232-5-git-send-email-pasha.tatashin@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Add an option to cause fewer cores to a context domain. A value of zero is
allowed to for a single context domain.

The boot command line parameter name is "cores_to_context_domain".

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Signed-off-by: Bob Picco <bob.picco@oracle.com>
---
 arch/sparc/mm/init_64.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 8c61fbc..9ada3c8 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -2302,6 +2302,23 @@ static unsigned short cpu_to_context_domain_id(int cpu)
 	return cpu / strands_to_context_domain;
 }
 
+static int __init core_to_cd_early(char *p)
+{
+	unsigned short result;
+
+	if (kstrtou16(p, 10, &result) < 0) {
+		pr_err("Invalid core to context domain value.\n");
+		return 0;
+	}
+
+	cores_to_context_domain = result;
+	pr_info("Using core to context domain count of %u.\n",
+		cores_to_context_domain);
+	return 0;
+}
+
+early_param("cores_to_context_domain", core_to_cd_early);
+
 static void __init context_domains_init(void)
 {
 	phys_addr_t cda_size;
-- 
1.7.1

