From: Steven Rostedt <rostedt@goodmis.org>
Date: Wed, 06 Jun 2018 14:11:10 +0000
Subject: [PATCH] sparc/time: Add missing __init to init_tick_ops()
Message-Id: <20180606101110.1a309846@vmware.local.home>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, Changbin Du <changbin.du@intel.com>, kbuild test robot <lkp@intel.com>, LKML <linux-kernel@vger.kernel.org>


From: Steven Rostedt (VMware) <rostedt@goodmis.org>

Code that was added to force gcc not to inline any function that isn't
explicitly declared as inline uncovered that init_tick_ops() isn't
marked as "__init". It is only called by __init functions and more
importantly it too calls an __init function which would require it to be
__init as well.

Link: http://lkml.kernel.org/r/201806060444.hdHcKOBy%fengguang.wu@intel.com

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
diff --git a/arch/sparc/kernel/time_64.c b/arch/sparc/kernel/time_64.c
index 2ef8cfa9677e..f0eba72aa1ad 100644
--- a/arch/sparc/kernel/time_64.c
+++ b/arch/sparc/kernel/time_64.c
@@ -814,7 +814,7 @@ static void __init get_tick_patch(void)
 	}
 }
 
-static void init_tick_ops(struct sparc64_tick_ops *ops)
+static void __init init_tick_ops(struct sparc64_tick_ops *ops)
 {
 	unsigned long freq, quotient, tick;
 
