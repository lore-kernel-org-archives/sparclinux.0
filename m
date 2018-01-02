From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 02 Jan 2018 20:05:48 +0000
Subject: [PATCH v7 09/10] x86: jump_label: switch to jump_entry accessors
Message-Id: <20180102200549.22984-10-ard.biesheuvel@linaro.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20180102200549.22984-1-ard.biesheuvel@linaro.org>
In-Reply-To: <20180102200549.22984-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

In preparation of switching x86 to use place-relative references for
the code, target and key members of struct jump_entry, replace direct
references to the struct member with invocations of the new accessors.
This will allow us to make the switch by modifying the accessors only.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/x86/kernel/jump_label.c | 43 ++++++++++++--------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
index e56c95be2808..d64296092ef5 100644
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
-- 
2.11.0

