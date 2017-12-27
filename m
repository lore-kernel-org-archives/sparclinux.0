From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Wed, 27 Dec 2017 08:50:33 +0000
Subject: [PATCH v6 8/8] x86/kernel: jump_table: use relative references
Message-Id: <20171227085033.22389-9-ard.biesheuvel@linaro.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20171227085033.22389-1-ard.biesheuvel@linaro.org>
In-Reply-To: <20171227085033.22389-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Similar to the arm64 case, 64-bit x86 can benefit from using 32-bit
relative references rather than 64-bit absolute ones when emitting
struct jump_entry instances. Not only does this reduce the memory
footprint of the entries themselves by 50%, it also removes the need
for carrying relocation metadata on relocatable builds (i.e., for KASLR)
which saves a fair chunk of .init space as well (although the savings
are not as dramatic as on arm64)

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/x86/include/asm/jump_label.h | 35 +++++++-----
 arch/x86/kernel/jump_label.c      | 59 ++++++++++++++------
 tools/objtool/special.c           |  4 +-
 3 files changed, 65 insertions(+), 33 deletions(-)

diff --git a/arch/x86/include/asm/jump_label.h b/arch/x86/include/asm/jump_label.h
index 009ff2699d07..91c01af96907 100644
--- a/arch/x86/include/asm/jump_label.h
+++ b/arch/x86/include/asm/jump_label.h
@@ -36,8 +36,8 @@ static __always_inline bool arch_static_branch(struct static_key *key, bool bran
 	asm_volatile_goto("1:"
 		".byte " __stringify(STATIC_KEY_INIT_NOP) "\n\t"
 		".pushsection __jump_table,  \"aw\" \n\t"
-		_ASM_ALIGN "\n\t"
-		_ASM_PTR "1b, %l[l_yes], %c0 + %c1 \n\t"
+		".balign 4\n\t"
+		".long 1b - ., %l[l_yes] - ., %c0 + %c1 - .\n\t"
 		".popsection \n\t"
 		: :  "i" (key), "i" (branch) : : l_yes);
 
@@ -52,8 +52,8 @@ static __always_inline bool arch_static_branch_jump(struct static_key *key, bool
 		".byte 0xe9\n\t .long %l[l_yes] - 2f\n\t"
 		"2:\n\t"
 		".pushsection __jump_table,  \"aw\" \n\t"
-		_ASM_ALIGN "\n\t"
-		_ASM_PTR "1b, %l[l_yes], %c0 + %c1 \n\t"
+		".balign 4\n\t"
+		".long 1b - ., %l[l_yes] - ., %c0 + %c1 - .\n\t"
 		".popsection \n\t"
 		: :  "i" (key), "i" (branch) : : l_yes);
 
@@ -69,19 +69,26 @@ typedef u32 jump_label_t;
 #endif
 
 struct jump_entry {
-	jump_label_t code;
-	jump_label_t target;
-	jump_label_t key;
+	s32 code;
+	s32 target;
+	s32 key;
 };
 
 static inline jump_label_t jump_entry_code(const struct jump_entry *entry)
 {
-	return entry->code;
+	return (jump_label_t)&entry->code + entry->code;
+}
+
+static inline jump_label_t jump_entry_target(const struct jump_entry *entry)
+{
+	return (jump_label_t)&entry->target + entry->target;
 }
 
 static inline struct static_key *jump_entry_key(const struct jump_entry *entry)
 {
-	return (struct static_key *)((unsigned long)entry->key & ~1UL);
+	unsigned long key = (unsigned long)&entry->key + entry->key;
+
+	return (struct static_key *)(key & ~1UL);
 }
 
 static inline bool jump_entry_is_branch(const struct jump_entry *entry)
@@ -99,7 +106,7 @@ static inline void jump_entry_set_module_init(struct jump_entry *entry)
 	entry->code = 0;
 }
 
-#define jump_label_swap		NULL
+void jump_label_swap(void *a, void *b, int size);
 
 #else	/* __ASSEMBLY__ */
 
@@ -114,8 +121,8 @@ static inline void jump_entry_set_module_init(struct jump_entry *entry)
 	.byte		STATIC_KEY_INIT_NOP
 	.endif
 	.pushsection __jump_table, "aw"
-	_ASM_ALIGN
-	_ASM_PTR	.Lstatic_jump_\@, \target, \key
+	.balign		4
+	.long		.Lstatic_jump_\@ - ., \target - ., \key - .
 	.popsection
 .endm
 
@@ -130,8 +137,8 @@ static inline void jump_entry_set_module_init(struct jump_entry *entry)
 .Lstatic_jump_after_\@:
 	.endif
 	.pushsection __jump_table, "aw"
-	_ASM_ALIGN
-	_ASM_PTR	.Lstatic_jump_\@, \target, \key + 1
+	.balign		4
+	.long		.Lstatic_jump_\@ - ., \target - ., \key - . + 1
 	.popsection
 .endm
 
diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
index e56c95be2808..cc5034b42335 100644
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -52,22 +52,24 @@ static void __jump_label_transform(struct jump_entry *entry,
 			 * Jump label is enabled for the first time.
 			 * So we expect a default_nop...
 			 */
-			if (unlikely(memcmp((void *)entry->code, default_nop, 5)
-				     != 0))
-				bug_at((void *)entry->code, __LINE__);
+			if (unlikely(memcmp((void *)jump_entry_code(entry),
+					    default_nop, 5) != 0))
+				bug_at((void *)jump_entry_code(entry),
+				       __LINE__);
 		} else {
 			/*
 			 * ...otherwise expect an ideal_nop. Otherwise
 			 * something went horribly wrong.
 			 */
-			if (unlikely(memcmp((void *)entry->code, ideal_nop, 5)
-				     != 0))
-				bug_at((void *)entry->code, __LINE__);
+			if (unlikely(memcmp((void *)jump_entry_code(entry),
+					    ideal_nop, 5) != 0))
+				bug_at((void *)jump_entry_code(entry),
+				       __LINE__);
 		}
 
 		code.jump = 0xe9;
-		code.offset = entry->target -
-				(entry->code + JUMP_LABEL_NOP_SIZE);
+		code.offset = jump_entry_target(entry) -
+			      (jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE);
 	} else {
 		/*
 		 * We are disabling this jump label. If it is not what
@@ -76,14 +78,18 @@ static void __jump_label_transform(struct jump_entry *entry,
 		 * are converting the default nop to the ideal nop.
 		 */
 		if (init) {
-			if (unlikely(memcmp((void *)entry->code, default_nop, 5) != 0))
-				bug_at((void *)entry->code, __LINE__);
+			if (unlikely(memcmp((void *)jump_entry_code(entry),
+					    default_nop, 5) != 0))
+				bug_at((void *)jump_entry_code(entry),
+				       __LINE__);
 		} else {
 			code.jump = 0xe9;
-			code.offset = entry->target -
-				(entry->code + JUMP_LABEL_NOP_SIZE);
-			if (unlikely(memcmp((void *)entry->code, &code, 5) != 0))
-				bug_at((void *)entry->code, __LINE__);
+			code.offset = jump_entry_target(entry) -
+				(jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE);
+			if (unlikely(memcmp((void *)jump_entry_code(entry),
+				     &code, 5) != 0))
+				bug_at((void *)jump_entry_code(entry),
+				       __LINE__);
 		}
 		memcpy(&code, ideal_nops[NOP_ATOMIC5], JUMP_LABEL_NOP_SIZE);
 	}
@@ -97,10 +103,13 @@ static void __jump_label_transform(struct jump_entry *entry,
 	 *
 	 */
 	if (poker)
-		(*poker)((void *)entry->code, &code, JUMP_LABEL_NOP_SIZE);
+		(*poker)((void *)jump_entry_code(entry), &code,
+			 JUMP_LABEL_NOP_SIZE);
 	else
-		text_poke_bp((void *)entry->code, &code, JUMP_LABEL_NOP_SIZE,
-			     (void *)entry->code + JUMP_LABEL_NOP_SIZE);
+		text_poke_bp((void *)jump_entry_code(entry), &code,
+			     JUMP_LABEL_NOP_SIZE,
+			     (void *)jump_entry_code(entry) +
+			     JUMP_LABEL_NOP_SIZE);
 }
 
 void arch_jump_label_transform(struct jump_entry *entry,
@@ -140,4 +149,20 @@ __init_or_module void arch_jump_label_transform_static(struct jump_entry *entry,
 		__jump_label_transform(entry, type, text_poke_early, 1);
 }
 
+void jump_label_swap(void *a, void *b, int size)
+{
+	long delta = (unsigned long)a - (unsigned long)b;
+	struct jump_entry *jea = a;
+	struct jump_entry *jeb = b;
+	struct jump_entry tmp = *jea;
+
+	jea->code	= jeb->code - delta;
+	jea->target	= jeb->target - delta;
+	jea->key	= jeb->key - delta;
+
+	jeb->code	= tmp.code + delta;
+	jeb->target	= tmp.target + delta;
+	jeb->key	= tmp.key + delta;
+}
+
 #endif
diff --git a/tools/objtool/special.c b/tools/objtool/special.c
index 84f001d52322..98ae55b39037 100644
--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -30,9 +30,9 @@
 #define EX_ORIG_OFFSET		0
 #define EX_NEW_OFFSET		4
 
-#define JUMP_ENTRY_SIZE		24
+#define JUMP_ENTRY_SIZE		12
 #define JUMP_ORIG_OFFSET	0
-#define JUMP_NEW_OFFSET		8
+#define JUMP_NEW_OFFSET		4
 
 #define ALT_ENTRY_SIZE		13
 #define ALT_ORIG_OFFSET		0
-- 
2.11.0

