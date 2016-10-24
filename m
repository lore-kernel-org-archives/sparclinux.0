From: David Miller <davem@davemloft.net>
Date: Mon, 24 Oct 2016 18:11:33 +0000
Subject: Re: Regression with 4.7.2 on sun4u
Message-Id: <20161024.141133.539006322717536420.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <3fc12066-505b-5f87-cbbe-88593a736162@physik.fu-berlin.de>
In-Reply-To: <3fc12066-505b-5f87-cbbe-88593a736162@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: James Clarke <jrtc27@jrtc27.com>
Date: Sat, 22 Oct 2016 10:51:28 +0100

> @@ -19,12 +19,20 @@ void arch_jump_label_transform(struct jump_entry *entry,
>  	if (type = JUMP_LABEL_JMP) {
>  		s32 off = (s32)entry->target - (s32)entry->code;
>  
> +		BUG_ON(off & 3);
> +
>  #ifdef CONFIG_SPARC64
> -		/* ba,pt %xcc, . + (off << 2) */
> -		val = 0x10680000 | ((u32) off >> 2);
> +		/* WDISP19 - target is . + (immed << 2) */
> +		BUG_ON(off > 0xfffff);
> +		BUG_ON(off < -0x100000);
> +		/* ba,pt %xcc, . + off */
> +		val = 0x10680000 | (((u32) off >> 2) & 0x7ffff);
>  #else
> -		/* ba . + (off << 2) */
> -		val = 0x10800000 | ((u32) off >> 2);
> +		/* WDISP22 - target is . + (immed << 2) */
> +		BUG_ON(off > 0x7fffff);
> +		BUG_ON(off < -0x800000);
> +		/* ba . + off */
> +		val = 0x10800000 | (((u32) off >> 2) & 0x3fffff);
>  #endif

Since we can determine at run time whether we need to use a non-v9
branch or not, it makes no sense to fail when a v9 branch is out of
range.

We can simply downgrade to a pre-v9 one.

Something like this:

diff --git a/arch/sparc/kernel/jump_label.c b/arch/sparc/kernel/jump_label.c
index 59bbeff..689e557 100644
--- a/arch/sparc/kernel/jump_label.c
+++ b/arch/sparc/kernel/jump_label.c
@@ -13,19 +13,24 @@
 void arch_jump_label_transform(struct jump_entry *entry,
 			       enum jump_label_type type)
 {
-	u32 val;
 	u32 *insn = (u32 *) (unsigned long) entry->code;
+	u32 val;
 
 	if (type = JUMP_LABEL_JMP) {
 		s32 off = (s32)entry->target - (s32)entry->code;
+		bool use_v9_branch = false;
 
 #ifdef CONFIG_SPARC64
-		/* ba,pt %xcc, . + (off << 2) */
-		val = 0x10680000 | ((u32) off >> 2);
-#else
-		/* ba . + (off << 2) */
-		val = 0x10800000 | ((u32) off >> 2);
+		if (off <= 0xfffff && off >= -0x100000)
+			use_v9_branch = true;
 #endif
+		if (use_v9_branch) {
+			/* ba,pt %xcc, . + (off << 2) */
+			val = 0x10680000 | (((u32) off >> 2) & 0x7ffff);
+		} else {
+			/* ba . + (off << 2) */
+			val = 0x10800000 | (((u32) off >> 2) & 0x3fffff);
+		}
 	} else {
 		val = 0x01000000;
 	}
