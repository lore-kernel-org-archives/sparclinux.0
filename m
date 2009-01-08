From: David Miller <davem@davemloft.net>
Date: Thu, 08 Jan 2009 01:16:49 +0000
Subject: Re: [PATCH] sparc: refactor code in fault_32.c
Message-Id: <20090107.171649.174783717.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20090106205209.GA24034@uranus.ravnborg.org>
In-Reply-To: <20090106205209.GA24034@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 6 Jan 2009 22:06:24 +0100

> So outstanding issues now are:
> 
> 1) How to fix "warning" in unaligned_64.c (get_user() || get_user())

I'm going to put a hack patch in, similar to your's, so people can get
work done.  We can try to cure this situation more cleanly later.

    sparc64: Work around branch tracer warning.
    
    As reported by Sam Ravnborg, Gcc-3.4.5 does not handle:
    
    	if (get_user() || get_user())
    
    with the new branch tracer enabled.
    
    Just seperate it out into seperate statements for now
    so people can get work done.
    
    Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/arch/sparc/kernel/unaligned_64.c b/arch/sparc/kernel/unaligned_64.c
index 203ddfa..f164d5a 100644
--- a/arch/sparc/kernel/unaligned_64.c
+++ b/arch/sparc/kernel/unaligned_64.c
@@ -601,11 +601,15 @@ void handle_lddfmna(struct pt_regs *regs, unsigned long sfar, unsigned long sfsr
 		pc = (u32)pc;
 	if (get_user(insn, (u32 __user *) pc) != -EFAULT) {
 		int asi = decode_asi(insn, regs);
+		int err;
+
 		if ((asi > ASI_SNFL) ||
 		    (asi < ASI_P))
 			goto daex;
-		if (get_user(first, (u32 __user *)sfar) ||
-		     get_user(second, (u32 __user *)(sfar + 4))) {
+		err = get_user(first, (u32 __user *)sfar);
+		if (!err)
+			err = get_user(second, (u32 __user *)(sfar + 4));
+		if (err) {
 			if (asi & 0x2) /* NF */ {
 				first = 0; second = 0;
 			} else
