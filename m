From: David Howells <dhowells@redhat.com>
Date: Wed, 12 Feb 2014 15:45:59 +0000
Subject: [PATCH 2/4] Sparc: sparc_cpu_model isn't in asm/system.h any more
Message-Id: <20140212154559.2405.3104.stgit@warthog.procyon.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <20140212154544.2405.2992.stgit@warthog.procyon.org.uk>
In-Reply-To: <20140212154544.2405.2992.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: akpm@linux-foundation.org
Cc: linux-arch@vger.kernel.org, arnd@arndb.de, linux-kernel@vger.kernel.org, dhowells@redhat.com, sparclinux@vger.kernel.org, "David S. Miller" <davem@davemloft.net>

sparc_cpu_model isn't in asm/system.h any more, so remove a comment about it.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: sparclinux@vger.kernel.org
---

 drivers/sbus/char/jsflash.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/sbus/char/jsflash.c b/drivers/sbus/char/jsflash.c
index 6b4678a..018b64b 100644
--- a/drivers/sbus/char/jsflash.c
+++ b/drivers/sbus/char/jsflash.c
@@ -507,11 +507,9 @@ static int jsflash_init(void)
 	}
 
 	/* Let us be really paranoid for modifications to probing code. */
-	/* extern enum sparc_cpu sparc_cpu_model; */ /* in <asm/system.h> */
-	if (sparc_cpu_model != sun4m) {
+	if (sparc_cpu_model != sun4m)
 		/* We must be on sun4m because we use MMU Bypass ASI. */
 		return -ENXIO;
-	}
 
 	if (jsf0.base = 0) {
 		jsf = &jsf0;

