From: Julian Calaby <julian.calaby@gmail.com>
Date: Sun, 04 Jan 2009 01:47:52 +0000
Subject: [PATCH] sparc: Clean arch-specific code in prom_common.c
Message-Id: <49601548.509@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

sparc: Clean arch-specific code in prom_common.c

prom_nextprop() and prom_firstprop() have slightly different calling 
conventions in 32 and 64 bit SPARC.

prom_common.c uses a ifdef guard to ensure that these functions are 
called correctly.

Adjust code to eliminate this ifdef by using a calling convention that 
is compatible with both 32 and 64 bit SPARC.

Signed-off-by: Julian Calaby <julian.calaby@gmail.com>

---

This has been build tested on sparc64 native, however I'm yet to boot it.

It hasn't been checked with sparc32 as I lack a working build environment.

  arch/sparc/kernel/prom_common.c |   14 +++-----------
  1 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/arch/sparc/kernel/prom_common.c 
b/arch/sparc/kernel/prom_common.c
index 4e9af59..ff7b591 100644
--- a/arch/sparc/kernel/prom_common.c
+++ b/arch/sparc/kernel/prom_common.c
@@ -155,20 +155,12 @@ static struct property * __init 
build_one_prop(phandle node, char *prev,
  		p->value = prom_early_alloc(special_len);
  		memcpy(p->value, special_val, special_len);
  	} else {
-#ifdef CONFIG_SPARC32
-		if (prev = NULL) {
-			name = prom_firstprop(node, NULL);
-		} else {
-			name = prom_nextprop(node, prev, NULL);
-		}
-#else
  		if (prev = NULL) {
-			prom_firstprop(node, p->name);
+			name = prom_firstprop(node, p->name);
  		} else {
-			prom_nextprop(node, prev, p->name);
+			name = prom_nextprop(node, prev, p->name);
  		}
-		name = p->name;
-#endif
+
  		if (strlen(name) = 0) {
  			tmp = p;
  			return NULL;
