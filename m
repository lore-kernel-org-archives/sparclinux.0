From: Nitin Gupta <nitin.m.gupta@oracle.com>
Date: Wed, 26 Oct 2016 22:27:56 +0000
Subject: [PATCH] sparc64: Make SLUB the default allocator
Message-Id: <1477520897-47950-1-git-send-email-nitin.m.gupta@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: Nitin Gupta <nitin.m.gupta@oracle.com>, Sowmini Varadhan <sowmini.varadhan@oracle.com>, Aaron Young <aaron.young@oracle.com>, Borislav Petkov <bp@suse.de>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

SLUB has better debugging support.

Signed-off-by: Nitin Gupta <nitin.m.gupta@oracle.com>
---
 arch/sparc/configs/sparc64_defconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/configs/sparc64_defconfig b/arch/sparc/configs/sparc64_defconfig
index 3583d67..0a615b0 100644
--- a/arch/sparc/configs/sparc64_defconfig
+++ b/arch/sparc/configs/sparc64_defconfig
@@ -7,7 +7,9 @@ CONFIG_LOG_BUF_SHIFT
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_PERF_EVENTS=y
 # CONFIG_COMPAT_BRK is not set
-CONFIG_SLAB=y
+CONFIG_SLUB_DEBUG=y
+CONFIG_SLUB=y
+CONFIG_SLUB_CPU_PARTIAL=y
 CONFIG_PROFILING=y
 CONFIG_OPROFILE=m
 CONFIG_KPROBES=y
-- 
2.9.2

