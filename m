From: Anton Blanchard <anton@ozlabs.org>
Date: Sun, 12 Feb 2017 21:14:49 +0000
Subject: [PATCH] perf: Fix CONFIG_KPROBE_EVENTS and CONFIG_UPROBE_EVENTS typos
Message-Id: <20170212211449.25976-1-anton@ozlabs.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net, peterz@infradead.org, mingo@redhat.com, acme@kernel.org, alexander.shishkin@linux.intel.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Anton Blanchard <anton@samba.org>

Fix some incorrect Kconfig options, they should be CONFIG_KPROBE_EVENT
and CONFIG_UPROBE_EVENT.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/sparc/configs/sparc64_defconfig | 2 +-
 tools/perf/util/probe-file.c         | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/sparc/configs/sparc64_defconfig b/arch/sparc/configs/sparc64_defconfig
index b2e650d..f912fd1 100644
--- a/arch/sparc/configs/sparc64_defconfig
+++ b/arch/sparc/configs/sparc64_defconfig
@@ -213,7 +213,7 @@ CONFIG_SCHEDSTATS=y
 # CONFIG_RCU_CPU_STALL_DETECTOR is not set
 CONFIG_SYSCTL_SYSCALL_CHECK=y
 CONFIG_BLK_DEV_IO_TRACE=y
-CONFIG_UPROBE_EVENTS=y
+CONFIG_UPROBE_EVENT=y
 CONFIG_KEYS=y
 CONFIG_CRYPTO_NULL=m
 CONFIG_CRYPTO_TEST=m
diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
index 436b647..6c74391 100644
--- a/tools/perf/util/probe-file.c
+++ b/tools/perf/util/probe-file.c
@@ -38,9 +38,9 @@ static void print_open_warning(int err, bool uprobe)
 		const char *config;
 
 		if (uprobe)
-			config = "CONFIG_UPROBE_EVENTS";
+			config = "CONFIG_UPROBE_EVENT";
 		else
-			config = "CONFIG_KPROBE_EVENTS";
+			config = "CONFIG_KPROBE_EVENT";
 
 		pr_warning("%cprobe_events file does not exist"
 			   " - please rebuild kernel with %s.\n",
@@ -59,8 +59,8 @@ static void print_both_open_warning(int kerr, int uerr)
 	if (kerr = -ENOTSUP && uerr = -ENOTSUP)
 		pr_warning("Tracefs or debugfs is not mounted.\n");
 	else if (kerr = -ENOENT && uerr = -ENOENT)
-		pr_warning("Please rebuild kernel with CONFIG_KPROBE_EVENTS "
-			   "or/and CONFIG_UPROBE_EVENTS.\n");
+		pr_warning("Please rebuild kernel with CONFIG_KPROBE_EVENT "
+			   "or/and CONFIG_UPROBE_EVENT.\n");
 	else {
 		char sbuf[STRERR_BUFSIZE];
 		pr_warning("Failed to open kprobe events: %s.\n",
-- 
2.9.3

