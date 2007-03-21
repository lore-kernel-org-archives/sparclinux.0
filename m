From: Robert Reif <reif@earthlink.net>
Date: Wed, 21 Mar 2007 11:24:33 +0000
Subject: [PATCH] remove unneeded extern from main.c
Message-Id: <1174476273.22880.10.camel@dell>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Remove unneeded extern from main.c.

diff --git a/init/main.c b/init/main.c
index a92989e..dd1566f 100644
--- a/init/main.c
+++ b/init/main.c
@@ -87,7 +87,6 @@ static int init(void *);
 extern void init_IRQ(void);
 extern void fork_init(unsigned long);
 extern void mca_init(void);
-extern void sbus_init(void);
 extern void signals_init(void);
 extern void pidhash_init(void);
 extern void pidmap_init(void);



