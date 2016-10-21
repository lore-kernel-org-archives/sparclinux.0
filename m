From: David Miller <davem@davemloft.net>
Date: Fri, 21 Oct 2016 17:26:45 +0000
Subject: Re: Regression with 4.7.2 on sun4u
Message-Id: <20161021.132645.2214056203503527673.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <3fc12066-505b-5f87-cbbe-88593a736162@physik.fu-berlin.de>
In-Reply-To: <3fc12066-505b-5f87-cbbe-88593a736162@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Rob Gardner <rob.gardner@oracle.com>
Date: Fri, 21 Oct 2016 09:49:30 -0600

> That could be either a stray memory write or a boot time patch gone
> wrong.

It could be that we need to use non-predicting branches in the jump
label implementation.  We could be overflowing the branch displacement
range if the kernel being built is really huge.

Something like the following would fix it if true:

diff --git a/arch/sparc/kernel/jump_label.c b/arch/sparc/kernel/jump_label.c
index 59bbeff..841d98e 100644
--- a/arch/sparc/kernel/jump_label.c
+++ b/arch/sparc/kernel/jump_label.c
@@ -19,13 +19,8 @@ void arch_jump_label_transform(struct jump_entry *entry,
 	if (type = JUMP_LABEL_JMP) {
 		s32 off = (s32)entry->target - (s32)entry->code;
 
-#ifdef CONFIG_SPARC64
-		/* ba,pt %xcc, . + (off << 2) */
-		val = 0x10680000 | ((u32) off >> 2);
-#else
 		/* ba . + (off << 2) */
 		val = 0x10800000 | ((u32) off >> 2);
-#endif
 	} else {
 		val = 0x01000000;
 	}
