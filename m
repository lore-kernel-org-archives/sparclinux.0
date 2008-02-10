From: David Rientjes <rientjes@google.com>
Date: Sun, 10 Feb 2008 23:30:51 +0000
Subject: [patch] sparc: fix build
Message-Id: <alpine.DEB.1.00.0802101529310.17892@chino.kir.corp.google.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20080207231230.GE7198@cs181133002.pp.htv.fi> <alpine.DEB.1.00.0802071538440.15050@chino.kir.corp.google.com> <20080210153355.GA6737@palantir8> <alpine.DEB.1.00.0802101117510.5043@chino.kir.corp.google.com> <47AF7048.3060200@earthlink.net>
In-Reply-To: <47AF7048.3060200@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Adrian Bunk <bunk@kernel.org>, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, Robert Reif <reif@earthlink.net>

Fix build failures on sparc:

	In file included from include/linux/mm.h:39,
	                from include/linux/memcontrol.h:24,
	                from include/linux/swap.h:8,
	                from include/linux/suspend.h:7,
	                from init/do_mounts.c:6:
	include/asm/pgtable.h:344: warning: parameter names (without
		types) in function declaration
	include/asm/pgtable.h:345: warning: parameter names (without
		types) in function declaration
	include/asm/pgtable.h:346: error: expected '=', ',', ';', 'asm' or
		'__attribute__' before '___f___swp_entry'

and

	arch/sparc/kernel/led.c: In function 'led_blink':
	arch/sparc/kernel/led.c:35: error: invalid use of undefined type
		'struct timer_list'
	arch/sparc/kernel/led.c:35: error: 'jiffies' undeclared (first use
		in this function)
	arch/sparc/kernel/led.c:35: error: (Each undeclared identifier is
		reported only once
	arch/sparc/kernel/led.c:35: error: for each function it appears
		in.)
	arch/sparc/kernel/led.c:36: error: 'avenrun' undeclared (first use
		in this function)
	arch/sparc/kernel/led.c:36: error: 'FSHIFT' undeclared (first use
		in this function)
	arch/sparc/kernel/led.c:36: error: 'HZ' undeclared (first use in
		this function)
	arch/sparc/kernel/led.c:37: error: invalid use of undefined type
		'struct timer_list'
	arch/sparc/kernel/led.c:39: error: invalid use of undefined type
		'struct timer_list'
	arch/sparc/kernel/led.c:40: error: invalid use of undefined type
		'struct timer_list'
	arch/sparc/kernel/led.c:42: error: implicit declaration of
		function 'add_timer'
	arch/sparc/kernel/led.c: In function 'led_write_proc':
	arch/sparc/kernel/led.c:70: error: implicit declaration of
		function 'copy_from_user'
	arch/sparc/kernel/led.c:84: error: implicit declaration of
		function 'del_timer_sync'
	arch/sparc/kernel/led.c: In function 'led_init':
	arch/sparc/kernel/led.c:109: error: implicit declaration of
		function 'init_timer'
	arch/sparc/kernel/led.c:110: error: invalid use of undefined type
		'struct timer_list'

Cc: Adrian Bunk <bunk@kernel.org>
Cc: Robert Reif <reif@earthlink.net>
Signed-off-by: David Rientjes <rientjes@google.com>
---
 arch/sparc/kernel/led.c    |    3 ++-
 include/linux/memcontrol.h |    3 ---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/kernel/led.c b/arch/sparc/kernel/led.c
--- a/arch/sparc/kernel/led.c
+++ b/arch/sparc/kernel/led.c
@@ -1,8 +1,9 @@
-#include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/proc_fs.h>
 #include <linux/string.h>
+#include <linux/sched.h>
+#include <linux/uaccess.h>
 
 #include <asm/auxio.h>
 
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -20,9 +20,6 @@
 #ifndef _LINUX_MEMCONTROL_H
 #define _LINUX_MEMCONTROL_H
 
-#include <linux/rcupdate.h>
-#include <linux/mm.h>
-
 struct mem_cgroup;
 struct page_cgroup;
 struct page;
