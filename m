From: Don Zickus <dzickus@redhat.com>
Date: Fri, 04 Apr 2014 20:47:07 +0000
Subject: [PATCH 1/4 v2] nmi: Provide the option to issue an NMI back trace to every cpu but current
Message-Id: <1396644430-70649-2-git-send-email-dzickus@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1396644430-70649-1-git-send-email-dzickus@redhat.com>
In-Reply-To: <1396644430-70649-1-git-send-email-dzickus@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: akpm@linux-foundation.org, x86@kernel.org, davem@davemloft.net, sparclinux@vger.kernel.org, mguzik@redhat.com, Aaron Tomlin <atomlin@redhat.com>, Don Zickus <dzickus@redhat.com>

From: Aaron Tomlin <atomlin@redhat.com>

Some times it is preferred not to use the
trigger_all_cpu_backtrace() routine when one wants
to avoid capturing a back trace for current.
For instance if one was previously captured
recently.

This patch provides a new routine namely
trigger_allbutself_cpu_backtrace() which offers
the flexibility to issue an NMI to every cpu but
current and capture a back trace accordingly.

[Added stub in #else clause - dcz]

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
Signed-off-by: Don Zickus <dzickus@redhat.com>
---
 include/linux/nmi.h |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index 6a45fb5..a17ab63 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -32,15 +32,24 @@ static inline void touch_nmi_watchdog(void)
 #ifdef arch_trigger_all_cpu_backtrace
 static inline bool trigger_all_cpu_backtrace(void)
 {
-	arch_trigger_all_cpu_backtrace();
+	arch_trigger_all_cpu_backtrace(true);
 
 	return true;
 }
+static inline bool trigger_allbutself_cpu_backtrace(void)
+{
+	arch_trigger_all_cpu_backtrace(false);
+	return true;
+}
 #else
 static inline bool trigger_all_cpu_backtrace(void)
 {
 	return false;
 }
+static inline bool trigger_allbutself_cpu_backtrace(void)
+{
+	return false;
+}
 #endif
 
 #ifdef CONFIG_LOCKUP_DETECTOR
-- 
1.7.1

