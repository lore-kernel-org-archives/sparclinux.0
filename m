From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 25 Aug 2016 08:22:48 +0000
Subject: [PATCH 1/2] sparc: Use kmalloc_array() in three functions
Message-Id: <fbdf6d83-08ac-a6b2-1674-53bc86c69ae8@users.sourceforge.net>
List-Id: <sparclinux.vger.kernel.org>
References: <0ca0235c-ddb9-0534-3bde-b4aaa48da92e@users.sourceforge.net>
In-Reply-To: <0ca0235c-ddb9-0534-3bde-b4aaa48da92e@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Paolo Bonzini <pbonzini@redhat.com>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 25 Aug 2016 09:52:44 +0200

* Multiplications for the size determination of memory allocations
  indicated that array data structures should be processed.
  Thus reuse the corresponding function "kmalloc_array".

  This issue was detected by using the Coccinelle software.

* Replace the specifications of data types by pointer dereferences
  to make the corresponding size determination a bit safer according to
  the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/sparc/kernel/led.c          | 2 +-
 arch/sparc/kernel/nmi.c          | 4 +++-
 arch/sparc/kernel/sys_sparc_64.c | 6 ++++--
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/kernel/led.c b/arch/sparc/kernel/led.c
index 3ae36f3..7444e4a 100644
--- a/arch/sparc/kernel/led.c
+++ b/arch/sparc/kernel/led.c
@@ -69,7 +69,7 @@ static ssize_t led_proc_write(struct file *file, const char __user *buffer,
 	if (count > LED_MAX_LENGTH)
 		count = LED_MAX_LENGTH;
 
-	buf = kmalloc(sizeof(char) * (count + 1), GFP_KERNEL);
+	buf = kmalloc_array(count + 1, sizeof(*buf), GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
diff --git a/arch/sparc/kernel/nmi.c b/arch/sparc/kernel/nmi.c
index a9973bb..b88e97b 100644
--- a/arch/sparc/kernel/nmi.c
+++ b/arch/sparc/kernel/nmi.c
@@ -166,7 +166,9 @@ static int __init check_nmi_watchdog(void)
 	if (!atomic_read(&nmi_active))
 		return 0;
 
-	prev_nmi_count = kmalloc(nr_cpu_ids * sizeof(unsigned int), GFP_KERNEL);
+	prev_nmi_count = kmalloc_array(nr_cpu_ids,
+				       sizeof(*prev_nmi_count),
+				       GFP_KERNEL);
 	if (!prev_nmi_count) {
 		err = -ENOMEM;
 		goto error;
diff --git a/arch/sparc/kernel/sys_sparc_64.c b/arch/sparc/kernel/sys_sparc_64.c
index fe8b8ee..25b7a14 100644
--- a/arch/sparc/kernel/sys_sparc_64.c
+++ b/arch/sparc/kernel/sys_sparc_64.c
@@ -580,8 +580,10 @@ SYSCALL_DEFINE5(utrap_install, utrap_entry_t, type,
 			unsigned long *p = current_thread_info()->utraps;
 
 			current_thread_info()->utraps -				kmalloc((UT_TRAP_INSTRUCTION_31+1)*sizeof(long),
-					GFP_KERNEL);
+				kmalloc_array(UT_TRAP_INSTRUCTION_31 + 1,
+					      sizeof(*current_thread_info()
+						     ->utraps),
+					      GFP_KERNEL);
 			if (!current_thread_info()->utraps) {
 				current_thread_info()->utraps = p;
 				return -ENOMEM;
-- 
2.9.3

