From: David Miller <davem@davemloft.net>
Date: Wed, 14 Jan 2009 01:33:19 +0000
Subject: Re: collision: arch/sparc/include/asm/spinlock_64.h vs.
Message-Id: <20090113.173319.58865475.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <a4423d670901130206r7cc1bdfcw685a3895bb2fc3bf@mail.gmail.com>
In-Reply-To: <a4423d670901130206r7cc1bdfcw685a3895bb2fc3bf@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Alexander Beregalov <a.beregalov@gmail.com>
Date: Tue, 13 Jan 2009 13:06:26 +0300

> __raw_{read,write}*() are defined in both places.

The best part is that we don't need to export any of
these rwlock symbols from sparc_ksyms_64.c

All of those routines are inline functions.

Thanks for the report, both of you, I'll fix it like
so:

diff --git a/arch/sparc/kernel/sparc_ksyms_64.c b/arch/sparc/kernel/sparc_ksyms_64.c
index da8f804..0f26066 100644
--- a/arch/sparc/kernel/sparc_ksyms_64.c
+++ b/arch/sparc/kernel/sparc_ksyms_64.c
@@ -9,7 +9,6 @@
 #include <linux/pci.h>
 #include <linux/init.h>
 
-#include <asm/spinlock.h>
 #include <asm/system.h>
 #include <asm/cpudata.h>
 #include <asm/uaccess.h>
@@ -23,16 +22,6 @@ struct poll {
 	short revents;
 };
 
-/* used by various drivers */
-#ifdef CONFIG_SMP
-/* Out of line rw-locking implementation. */
-EXPORT_SYMBOL(__read_lock);
-EXPORT_SYMBOL(__read_unlock);
-EXPORT_SYMBOL(__write_lock);
-EXPORT_SYMBOL(__write_unlock);
-EXPORT_SYMBOL(__write_trylock);
-#endif /* CONFIG_SMP */
-
 /* from helpers.S */
 EXPORT_SYMBOL(__flushw_user);
 EXPORT_SYMBOL_GPL(real_hard_smp_processor_id);
