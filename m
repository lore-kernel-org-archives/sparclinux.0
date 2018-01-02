From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 02 Jan 2018 20:05:46 +0000
Subject: [PATCH v7 07/10] kernel/jump_label: abstract jump_entry member accessors
Message-Id: <20180102200549.22984-8-ard.biesheuvel@linaro.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20180102200549.22984-1-ard.biesheuvel@linaro.org>
In-Reply-To: <20180102200549.22984-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

In preparation of allowing architectures to use relative references
in jump_label entries [which can dramatically reduce the memory
footprint], introduce abstractions for references to the 'code' and
'key' members of struct jump_entry.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/include/asm/jump_label.h     | 27 ++++++++++++++
 arch/arm64/include/asm/jump_label.h   | 27 ++++++++++++++
 arch/mips/include/asm/jump_label.h    | 27 ++++++++++++++
 arch/powerpc/include/asm/jump_label.h | 27 ++++++++++++++
 arch/s390/include/asm/jump_label.h    | 27 ++++++++++++++
 arch/sparc/include/asm/jump_label.h   | 27 ++++++++++++++
 arch/tile/include/asm/jump_label.h    | 27 ++++++++++++++
 arch/x86/include/asm/jump_label.h     | 27 ++++++++++++++
 kernel/jump_label.c                   | 38 +++++++++-----------
 9 files changed, 232 insertions(+), 22 deletions(-)

diff --git a/arch/arm/include/asm/jump_label.h b/arch/arm/include/asm/jump_label.h
index e12d7d096fc0..7b05b404063a 100644
--- a/arch/arm/include/asm/jump_label.h
+++ b/arch/arm/include/asm/jump_label.h
@@ -45,5 +45,32 @@ struct jump_entry {
 	jump_label_t key;
 };
 
+static inline jump_label_t jump_entry_code(const struct jump_entry *entry)
+{
+	return entry->code;
+}
+
+static inline struct static_key *jump_entry_key(const struct jump_entry *entry)
+{
+	return (struct static_key *)((unsigned long)entry->key & ~1UL);
+}
+
+static inline bool jump_entry_is_branch(const struct jump_entry *entry)
+{
+	return (unsigned long)entry->key & 1UL;
+}
+
+static inline bool jump_entry_is_module_init(const struct jump_entry *entry)
+{
+	return entry->code = 0;
+}
+
+static inline void jump_entry_set_module_init(struct jump_entry *entry)
+{
+	entry->code = 0;
+}
+
+#define jump_label_swap		NULL
+
 #endif  /* __ASSEMBLY__ */
 #endif
diff --git a/arch/arm64/include/asm/jump_label.h b/arch/arm64/include/asm/jump_label.h
index 1b5e0e843c3a..9d6e46355c89 100644
--- a/arch/arm64/include/asm/jump_label.h
+++ b/arch/arm64/include/asm/jump_label.h
@@ -62,5 +62,32 @@ struct jump_entry {
 	jump_label_t key;
 };
 
+static inline jump_label_t jump_entry_code(const struct jump_entry *entry)
+{
+	return entry->code;
+}
+
+static inline struct static_key *jump_entry_key(const struct jump_entry *entry)
+{
+	return (struct static_key *)((unsigned long)entry->key & ~1UL);
+}
+
+static inline bool jump_entry_is_branch(const struct jump_entry *entry)
+{
+	return (unsigned long)entry->key & 1UL;
+}
+
+static inline bool jump_entry_is_module_init(const struct jump_entry *entry)
+{
+	return entry->code = 0;
+}
+
+static inline void jump_entry_set_module_init(struct jump_entry *entry)
+{
+	entry->code = 0;
+}
+
+#define jump_label_swap		NULL
+
 #endif  /* __ASSEMBLY__ */
 #endif	/* __ASM_JUMP_LABEL_H */
diff --git a/arch/mips/include/asm/jump_label.h b/arch/mips/include/asm/jump_label.h
index e77672539e8e..70df9293dc49 100644
--- a/arch/mips/include/asm/jump_label.h
+++ b/arch/mips/include/asm/jump_label.h
@@ -66,5 +66,32 @@ struct jump_entry {
 	jump_label_t key;
 };
 
+static inline jump_label_t jump_entry_code(const struct jump_entry *entry)
+{
+	return entry->code;
+}
+
+static inline struct static_key *jump_entry_key(const struct jump_entry *entry)
+{
+	return (struct static_key *)((unsigned long)entry->key & ~1UL);
+}
+
+static inline bool jump_entry_is_branch(const struct jump_entry *entry)
+{
+	return (unsigned long)entry->key & 1UL;
+}
+
+static inline bool jump_entry_is_module_init(const struct jump_entry *entry)
+{
+	return entry->code = 0;
+}
+
+static inline void jump_entry_set_module_init(struct jump_entry *entry)
+{
+	entry->code = 0;
+}
+
+#define jump_label_swap		NULL
+
 #endif  /* __ASSEMBLY__ */
 #endif /* _ASM_MIPS_JUMP_LABEL_H */
diff --git a/arch/powerpc/include/asm/jump_label.h b/arch/powerpc/include/asm/jump_label.h
index 9a287e0ac8b1..412b2699c9f6 100644
--- a/arch/powerpc/include/asm/jump_label.h
+++ b/arch/powerpc/include/asm/jump_label.h
@@ -59,6 +59,33 @@ struct jump_entry {
 	jump_label_t key;
 };
 
+static inline jump_label_t jump_entry_code(const struct jump_entry *entry)
+{
+	return entry->code;
+}
+
+static inline struct static_key *jump_entry_key(const struct jump_entry *entry)
+{
+	return (struct static_key *)((unsigned long)entry->key & ~1UL);
+}
+
+static inline bool jump_entry_is_branch(const struct jump_entry *entry)
+{
+	return (unsigned long)entry->key & 1UL;
+}
+
+static inline bool jump_entry_is_module_init(const struct jump_entry *entry)
+{
+	return entry->code = 0;
+}
+
+static inline void jump_entry_set_module_init(struct jump_entry *entry)
+{
+	entry->code = 0;
+}
+
+#define jump_label_swap		NULL
+
 #else
 #define ARCH_STATIC_BRANCH(LABEL, KEY)		\
 1098:	nop;					\
diff --git a/arch/s390/include/asm/jump_label.h b/arch/s390/include/asm/jump_label.h
index 40f651292aa7..1ecfd46835d9 100644
--- a/arch/s390/include/asm/jump_label.h
+++ b/arch/s390/include/asm/jump_label.h
@@ -50,5 +50,32 @@ struct jump_entry {
 	jump_label_t key;
 };
 
+static inline jump_label_t jump_entry_code(const struct jump_entry *entry)
+{
+	return entry->code;
+}
+
+static inline struct static_key *jump_entry_key(const struct jump_entry *entry)
+{
+	return (struct static_key *)((unsigned long)entry->key & ~1UL);
+}
+
+static inline bool jump_entry_is_branch(const struct jump_entry *entry)
+{
+	return (unsigned long)entry->key & 1UL;
+}
+
+static inline bool jump_entry_is_module_init(const struct jump_entry *entry)
+{
+	return entry->code = 0;
+}
+
+static inline void jump_entry_set_module_init(struct jump_entry *entry)
+{
+	entry->code = 0;
+}
+
+#define jump_label_swap			NULL
+
 #endif  /* __ASSEMBLY__ */
 #endif
diff --git a/arch/sparc/include/asm/jump_label.h b/arch/sparc/include/asm/jump_label.h
index 94eb529dcb77..18e893687f7c 100644
--- a/arch/sparc/include/asm/jump_label.h
+++ b/arch/sparc/include/asm/jump_label.h
@@ -48,5 +48,32 @@ struct jump_entry {
 	jump_label_t key;
 };
 
+static inline jump_label_t jump_entry_code(const struct jump_entry *entry)
+{
+	return entry->code;
+}
+
+static inline struct static_key *jump_entry_key(const struct jump_entry *entry)
+{
+	return (struct static_key *)((unsigned long)entry->key & ~1UL);
+}
+
+static inline bool jump_entry_is_branch(const struct jump_entry *entry)
+{
+	return (unsigned long)entry->key & 1UL;
+}
+
+static inline bool jump_entry_is_module_init(const struct jump_entry *entry)
+{
+	return entry->code = 0;
+}
+
+static inline void jump_entry_set_module_init(struct jump_entry *entry)
+{
+	entry->code = 0;
+}
+
+#define jump_label_swap		NULL
+
 #endif  /* __ASSEMBLY__ */
 #endif
diff --git a/arch/tile/include/asm/jump_label.h b/arch/tile/include/asm/jump_label.h
index cde7573f397b..86acaa6ff33d 100644
--- a/arch/tile/include/asm/jump_label.h
+++ b/arch/tile/include/asm/jump_label.h
@@ -55,4 +55,31 @@ struct jump_entry {
 	jump_label_t key;
 };
 
+static inline jump_label_t jump_entry_code(const struct jump_entry *entry)
+{
+	return entry->code;
+}
+
+static inline struct static_key *jump_entry_key(const struct jump_entry *entry)
+{
+	return (struct static_key *)((unsigned long)entry->key & ~1UL);
+}
+
+static inline bool jump_entry_is_branch(const struct jump_entry *entry)
+{
+	return (unsigned long)entry->key & 1UL;
+}
+
+static inline bool jump_entry_is_module_init(const struct jump_entry *entry)
+{
+	return entry->code = 0;
+}
+
+static inline void jump_entry_set_module_init(struct jump_entry *entry)
+{
+	entry->code = 0;
+}
+
+#define jump_label_swap		NULL
+
 #endif /* _ASM_TILE_JUMP_LABEL_H */
diff --git a/arch/x86/include/asm/jump_label.h b/arch/x86/include/asm/jump_label.h
index 8c0de4282659..009ff2699d07 100644
--- a/arch/x86/include/asm/jump_label.h
+++ b/arch/x86/include/asm/jump_label.h
@@ -74,6 +74,33 @@ struct jump_entry {
 	jump_label_t key;
 };
 
+static inline jump_label_t jump_entry_code(const struct jump_entry *entry)
+{
+	return entry->code;
+}
+
+static inline struct static_key *jump_entry_key(const struct jump_entry *entry)
+{
+	return (struct static_key *)((unsigned long)entry->key & ~1UL);
+}
+
+static inline bool jump_entry_is_branch(const struct jump_entry *entry)
+{
+	return (unsigned long)entry->key & 1UL;
+}
+
+static inline bool jump_entry_is_module_init(const struct jump_entry *entry)
+{
+	return entry->code = 0;
+}
+
+static inline void jump_entry_set_module_init(struct jump_entry *entry)
+{
+	entry->code = 0;
+}
+
+#define jump_label_swap		NULL
+
 #else	/* __ASSEMBLY__ */
 
 .macro STATIC_JUMP_IF_TRUE target, key, def
diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index 8594d24e4adc..4f44db58d981 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -37,10 +37,12 @@ static int jump_label_cmp(const void *a, const void *b)
 	const struct jump_entry *jea = a;
 	const struct jump_entry *jeb = b;
 
-	if (jea->key < jeb->key)
+	if ((unsigned long)jump_entry_key(jea) <
+	    (unsigned long)jump_entry_key(jeb))
 		return -1;
 
-	if (jea->key > jeb->key)
+	if ((unsigned long)jump_entry_key(jea) >
+	    (unsigned long)jump_entry_key(jeb))
 		return 1;
 
 	return 0;
@@ -53,7 +55,8 @@ jump_label_sort_entries(struct jump_entry *start, struct jump_entry *stop)
 
 	size = (((unsigned long)stop - (unsigned long)start)
 					/ sizeof(struct jump_entry));
-	sort(start, size, sizeof(struct jump_entry), jump_label_cmp, NULL);
+	sort(start, size, sizeof(struct jump_entry), jump_label_cmp,
+	     jump_label_swap);
 }
 
 static void jump_label_update(struct static_key *key);
@@ -254,8 +257,8 @@ EXPORT_SYMBOL_GPL(jump_label_rate_limit);
 
 static int addr_conflict(struct jump_entry *entry, void *start, void *end)
 {
-	if (entry->code <= (unsigned long)end &&
-		entry->code + JUMP_LABEL_NOP_SIZE > (unsigned long)start)
+	if (jump_entry_code(entry) <= (unsigned long)end &&
+	    jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE > (unsigned long)start)
 		return 1;
 
 	return 0;
@@ -314,16 +317,6 @@ static inline void static_key_set_linked(struct static_key *key)
 	key->type |= JUMP_TYPE_LINKED;
 }
 
-static inline struct static_key *jump_entry_key(struct jump_entry *entry)
-{
-	return (struct static_key *)((unsigned long)entry->key & ~1UL);
-}
-
-static bool jump_entry_branch(struct jump_entry *entry)
-{
-	return (unsigned long)entry->key & 1UL;
-}
-
 /***
  * A 'struct static_key' uses a union such that it either points directly
  * to a table of 'struct jump_entry' or to a linked list of modules which in
@@ -348,7 +341,7 @@ static enum jump_label_type jump_label_type(struct jump_entry *entry)
 {
 	struct static_key *key = jump_entry_key(entry);
 	bool enabled = static_key_enabled(key);
-	bool branch = jump_entry_branch(entry);
+	bool branch = jump_entry_is_branch(entry);
 
 	/* See the comment in linux/jump_label.h */
 	return enabled ^ branch;
@@ -364,7 +357,8 @@ static void __jump_label_update(struct static_key *key,
 		 * kernel_text_address() verifies we are not in core kernel
 		 * init code, see jump_label_invalidate_module_init().
 		 */
-		if (entry->code && kernel_text_address(entry->code))
+		if (!jump_entry_is_module_init(entry) &&
+		    kernel_text_address(jump_entry_code(entry)))
 			arch_jump_label_transform(entry, jump_label_type(entry));
 	}
 }
@@ -417,7 +411,7 @@ static enum jump_label_type jump_label_init_type(struct jump_entry *entry)
 {
 	struct static_key *key = jump_entry_key(entry);
 	bool type = static_key_type(key);
-	bool branch = jump_entry_branch(entry);
+	bool branch = jump_entry_is_branch(entry);
 
 	/* See the comment in linux/jump_label.h */
 	return type ^ branch;
@@ -541,7 +535,7 @@ static int jump_label_add_module(struct module *mod)
 			continue;
 
 		key = iterk;
-		if (within_module(iter->key, mod)) {
+		if (within_module((unsigned long)key, mod)) {
 			static_key_set_entries(key, iter);
 			continue;
 		}
@@ -591,7 +585,7 @@ static void jump_label_del_module(struct module *mod)
 
 		key = jump_entry_key(iter);
 
-		if (within_module(iter->key, mod))
+		if (within_module((unsigned long)key, mod))
 			continue;
 
 		/* No memory during module load */
@@ -634,8 +628,8 @@ static void jump_label_invalidate_module_init(struct module *mod)
 	struct jump_entry *iter;
 
 	for (iter = iter_start; iter < iter_stop; iter++) {
-		if (within_module_init(iter->code, mod))
-			iter->code = 0;
+		if (within_module_init(jump_entry_code(iter), mod))
+			jump_entry_set_module_init(iter);
 	}
 }
 
-- 
2.11.0

