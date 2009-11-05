From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 05 Nov 2009 07:47:19 +0000
Subject: [PATCH 10/11] of: remove special case definition of of_read_ulong()
Message-Id: <20091105074710.10460.31527.stgit@angua>
List-Id: <sparclinux.vger.kernel.org>
References: <20091105073728.10460.6061.stgit@angua>
In-Reply-To: <20091105073728.10460.6061.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org, benh@kernel.crashing.org, sfr@canb.auug.org.au, davem@davemloft.net, sparclinux@vger.kernel.org, monstr@monstr.eu

Special case of of_read_ulong() was defined for PPC32 to toss away
all but the last 32 bits when a large number value was read, and the
'normal' version for ppc64 just #defined of_read_ulong to of_read_number
which causes compiler warnings on MicroBlaze and other 32 bit
architectures because it returns a u64 instead of a ulong.

This patch fixes the problem by defining a common implementation of
of_read_ulong() that works everywhere.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 include/linux/of.h |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/linux/of.h b/include/linux/of.h
index bec2157..d4c014a 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -113,14 +113,11 @@ static inline u64 of_read_number(const u32 *cell, int size)
 }
 
 /* Like of_read_number, but we want an unsigned long result */
-#ifdef CONFIG_PPC32
 static inline unsigned long of_read_ulong(const u32 *cell, int size)
 {
-	return cell[size-1];
+	/* toss away upper bits if unsigned long is smaller than u64 */
+	return of_read_number(cell, size);
 }
-#else
-#define of_read_ulong(cell, size)	of_read_number(cell, size)
-#endif
 
 #include <asm/prom.h>
 

