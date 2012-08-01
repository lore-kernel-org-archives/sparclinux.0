From: Jiri Kosina <jkosina@suse.cz>
Date: Wed, 01 Aug 2012 20:05:55 +0000
Subject: [PATCH] sparc64: do not clobber personality flags in sys_sparc64_personality()
Message-Id: <alpine.LNX.2.00.1208012204140.14910@pobox.suse.cz>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

There are multiple errors in how sys_sparc64_personality() handles 
personality flags stored in top three bytes.

- directly comparing current->personality against PER_LINUX32 doesn't work
  in cases when any of the personality flags stored in the top three bytes
  are used.
- directly forcefully setting personality to PER_LINUX32 or PER_LINUX
  discards any flags stored in the top three bytes

Fix the first one by properly using personality() macro to compare only
PER_MASK bytes.
Fix the second one by setting only the bits that should be set, instead of
overwriting the whole value.

Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---

Found accidentally. Untested, I don't have the hardware.

 arch/sparc/kernel/sys_sparc_64.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/sparc/kernel/sys_sparc_64.c b/arch/sparc/kernel/sys_sparc_64.c
index 0dc1f57..d48a364 100644
--- a/arch/sparc/kernel/sys_sparc_64.c
+++ b/arch/sparc/kernel/sys_sparc_64.c
@@ -502,12 +502,12 @@ SYSCALL_DEFINE1(sparc64_personality, unsigned long, personality)
 {
 	int ret;
 
-	if (current->personality = PER_LINUX32 &&
-	    personality = PER_LINUX)
-		personality = PER_LINUX32;
+	if (personality(current->personality) = PER_LINUX32 &&
+	    personality(personality) = PER_LINUX)
+		personality &= ~PER_LINUX | PER_LINUX32;
 	ret = sys_personality(personality);
-	if (ret = PER_LINUX32)
-		ret = PER_LINUX;
+	if (personality(ret) = PER_LINUX32)
+		ret &= ~PER_LINUX32 | PER_LINUX;
 
 	return ret;
 }

-- 
Jiri Kosina
SUSE Labs
