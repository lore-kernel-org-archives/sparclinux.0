From: David Miller <davem@davemloft.net>
Date: Tue, 20 Jan 2009 06:52:28 +0000
Subject: Re: opps building sparc64 packages
Message-Id: <20090119.225228.194299431.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200901021435.23972.dgilmore@redhat.com>
In-Reply-To: <200901021435.23972.dgilmore@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Mon, 19 Jan 2009 22:35:17 -0800 (PST)

> The code in sun4v_data_access_exception() needs some logic to properly
> handle the case of the kernel doing a userspace access.  Currently it
> does an OOPS unconditionally when triggered from kernel space, which
> is wrong.
> 
> I'll fix this up and post a patch.

Dennis, here is a 2.6.27 based patch that should fix this bug.

sparc64: Fix DAX handling via userspace access from kernel.

If we do a userspace access from kernel mode, and get a
data access exception, we need to check the exception
table just like a normal fault does.

The spitfire DAX handler was doing this, but such logic
was missing from the sun4v DAX code.

Reported-by: Dennis Gilmore <dgilmore@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/arch/sparc64/kernel/traps.c b/arch/sparc64/kernel/traps.c
index c824df1..eb19724 100644
--- a/arch/sparc64/kernel/traps.c
+++ b/arch/sparc64/kernel/traps.c
@@ -1,6 +1,6 @@
 /* arch/sparc64/kernel/traps.c
  *
- * Copyright (C) 1995,1997,2008 David S. Miller (davem@davemloft.net)
+ * Copyright (C) 1995,1997,2008,2009 David S. Miller (davem@davemloft.net)
  * Copyright (C) 1997,1999,2000 Jakub Jelinek (jakub@redhat.com)
  */
 
@@ -262,6 +262,21 @@ void sun4v_data_access_exception(struct pt_regs *regs, unsigned long addr, unsig
 		return;
 
 	if (regs->tstate & TSTATE_PRIV) {
+		/* Test if this comes from uaccess places. */
+		const struct exception_table_entry *entry;
+
+		entry = search_exception_tables(regs->tpc);
+		if (entry) {
+			/* Ouch, somebody is trying VM hole tricks on us... */
+#ifdef DEBUG_EXCEPTIONS
+			printk("Exception: PC<%016lx> faddr<UNKNOWN>\n", regs->tpc);
+			printk("EX_TABLE: insn<%016lx> fixup<%016lx>\n",
+			       regs->tpc, entry->fixup);
+#endif
+			regs->tpc = entry->fixup;
+			regs->tnpc = regs->tpc + 4;
+			return;
+		}
 		printk("sun4v_data_access_exception: ADDR[%016lx] "
 		       "CTX[%04x] TYPE[%04x], going.\n",
 		       addr, ctx, type);
