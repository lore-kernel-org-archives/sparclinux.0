From: David Howells <dhowells@redhat.com>
Date: Wed, 17 Oct 2012 14:01:51 +0000
Subject: [PATCH 10/10] UAPI: Make arch/sparc/include/uapi/asm/sigcontext.h non-empty
Message-Id: <20121017140151.28541.32197.stgit@warthog.procyon.org.uk>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

arch/sparc/include/uapi/asm/sigcontext.h was emitted by the UAPI disintegration
script as an empty file because the parent file had no UAPI stuff in it,
despite being marked with "header-y".

Unfortunately, the patch program deletes resultant empty files when applying a
kernel patch.

So just stick a comment in there as a placeholder.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: David S. Miller <davem@davemloft.net>
cc: sparclinux@vger.kernel.org
---

 arch/sparc/include/uapi/asm/sigcontext.h |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/sparc/include/uapi/asm/sigcontext.h b/arch/sparc/include/uapi/asm/sigcontext.h
index e69de29..ae5704f 100644
--- a/arch/sparc/include/uapi/asm/sigcontext.h
+++ b/arch/sparc/include/uapi/asm/sigcontext.h
@@ -0,0 +1,4 @@
+/*
+ * There isn't anything here anymore, but the file must not be empty or patch
+ * will delete it.
+ */

