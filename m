From: James Clarke <jrtc27@jrtc27.com>
Date: Tue, 25 Oct 2016 00:10:55 +0000
Subject: Re: Regression with 4.7.2 on sun4u
Message-Id: <6930D444-0A65-46F3-BB11-7EFA2AD76CA3@jrtc27.com>
List-Id: <sparclinux.vger.kernel.org>
References: <3fc12066-505b-5f87-cbbe-88593a736162@physik.fu-berlin.de>
In-Reply-To: <3fc12066-505b-5f87-cbbe-88593a736162@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> On 24 Oct 2016, at 19:11, David Miller <davem@davemloft.net> wrote:
> 
> From: James Clarke <jrtc27@jrtc27.com>
> Date: Sat, 22 Oct 2016 10:51:28 +0100
> 
>> @@ -19,12 +19,20 @@ void arch_jump_label_transform(struct jump_entry *entry,
>> 	if (type == JUMP_LABEL_JMP) {
>> 		s32 off = (s32)entry->target - (s32)entry->code;
>> 
>> +		BUG_ON(off & 3);
>> +
>> #ifdef CONFIG_SPARC64
>> -		/* ba,pt %xcc, . + (off << 2) */
>> -		val = 0x10680000 | ((u32) off >> 2);
>> +		/* WDISP19 - target is . + (immed << 2) */
>> +		BUG_ON(off > 0xfffff);
>> +		BUG_ON(off < -0x100000);
>> +		/* ba,pt %xcc, . + off */
>> +		val = 0x10680000 | (((u32) off >> 2) & 0x7ffff);
>> #else
>> -		/* ba . + (off << 2) */
>> -		val = 0x10800000 | ((u32) off >> 2);
>> +		/* WDISP22 - target is . + (immed << 2) */
>> +		BUG_ON(off > 0x7fffff);
>> +		BUG_ON(off < -0x800000);
>> +		/* ba . + off */
>> +		val = 0x10800000 | (((u32) off >> 2) & 0x3fffff);
>> #endif
> 
> Since we can determine at run time whether we need to use a non-v9
> branch or not, it makes no sense to fail when a v9 branch is out of
> range.
> 
> We can simply downgrade to a pre-v9 one.
> 
> Something like this:
> 
> diff --git a/arch/sparc/kernel/jump_label.c b/arch/sparc/kernel/jump_label.c
> index 59bbeff..689e557 100644
> --- a/arch/sparc/kernel/jump_label.c
> +++ b/arch/sparc/kernel/jump_label.c
> @@ -13,19 +13,24 @@
> void arch_jump_label_transform(struct jump_entry *entry,
> 			       enum jump_label_type type)
> {
> -	u32 val;
> 	u32 *insn = (u32 *) (unsigned long) entry->code;
> +	u32 val;
> 
> 	if (type == JUMP_LABEL_JMP) {
> 		s32 off = (s32)entry->target - (s32)entry->code;
> +		bool use_v9_branch = false;
> 
> #ifdef CONFIG_SPARC64
> -		/* ba,pt %xcc, . + (off << 2) */
> -		val = 0x10680000 | ((u32) off >> 2);
> -#else
> -		/* ba . + (off << 2) */
> -		val = 0x10800000 | ((u32) off >> 2);
> +		if (off <= 0xfffff && off >= -0x100000)
> +			use_v9_branch = true;
> #endif
> +		if (use_v9_branch) {
> +			/* ba,pt %xcc, . + (off << 2) */
> +			val = 0x10680000 | (((u32) off >> 2) & 0x7ffff);
> +		} else {
> +			/* ba . + (off << 2) */
> +			val = 0x10800000 | (((u32) off >> 2) & 0x3fffff);
> +		}
> 	} else {
> 		val = 0x01000000;
> 	}

Sure, that makes sense; updated and tested for a few hours:

From d5997fd98fc80d1ceabe11f6fcd63dfce99b8253 Mon Sep 17 00:00:00 2001
From: James Clarke <jrtc27@jrtc27.com>
Date: Mon, 24 Oct 2016 19:49:25 +0100
Subject: [PATCH v2] sparc: Handle negative offsets in
 arch_jump_label_transform

Additionally, if the offset will overflow the immediate for a ba,pt
instruction, fall back on a standard ba to get an extra 3 bits.

Signed-off-by: James Clarke <jrtc27@jrtc27.com>
---
 arch/sparc/kernel/jump_label.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/arch/sparc/kernel/jump_label.c b/arch/sparc/kernel/jump_label.c
index 59bbeff..07933b9 100644
--- a/arch/sparc/kernel/jump_label.c
+++ b/arch/sparc/kernel/jump_label.c
@@ -13,19 +13,30 @@
 void arch_jump_label_transform(struct jump_entry *entry,
 			       enum jump_label_type type)
 {
-	u32 val;
 	u32 *insn = (u32 *) (unsigned long) entry->code;
+	u32 val;
 
 	if (type == JUMP_LABEL_JMP) {
 		s32 off = (s32)entry->target - (s32)entry->code;
+		bool use_v9_branch = false;
+
+		BUG_ON(off & 3);
 
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
+			/* WDISP19 - target is . + immed << 2 */
+			/* ba,pt %xcc, . + off */
+			val = 0x10680000 | (((u32) off >> 2) & 0x7ffff);
+		} else {
+			/* WDISP22 - target is . + immed << 2 */
+			BUG_ON(off > 0x7fffff);
+			BUG_ON(off < -0x800000);
+			/* ba . + off */
+			val = 0x10800000 | (((u32) off >> 2) & 0x3fffff);
+		}
 	} else {
 		val = 0x01000000;
 	}
-- 
2.9.3
