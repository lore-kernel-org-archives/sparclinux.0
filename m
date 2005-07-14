From: domen@coderock.org
Date: Thu, 14 Jul 2005 22:20:00 +0000
Subject: [patch 1/1] sparc/kernel/ioport: Audit return code of create_proc_*
Message-Id: <20050714222000.302687000@homer>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Christophe Lucas <clucas@rotomalug.org>


Audit return of create_proc_* functions.

Signed-off-by: Christophe Lucas <clucas@rotomalug.org>
Signed-off-by: Domen Puncer <domen@coderock.org>
---
 ioport.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

Index: quilt/arch/sparc/kernel/ioport.c
=================================--- quilt.orig/arch/sparc/kernel/ioport.c
+++ quilt/arch/sparc/kernel/ioport.c
@@ -725,7 +725,16 @@ _sparc_find_resource(struct resource *ro
 void register_proc_sparc_ioport(void)
 {
 #ifdef CONFIG_PROC_FS
-	create_proc_read_entry("io_map",0,NULL,_sparc_io_get_info,&sparc_iomap);
-	create_proc_read_entry("dvma_map",0,NULL,_sparc_io_get_info,&_sparc_dvma);
+	struct proc_dir_entry *ent;
+	ent = create_proc_read_entry("io_map",0,NULL,
+		_sparc_io_get_info,&sparc_iomap);
+	if (!ent)
+		printk(KERN_WARNING 
+			"ioport.c: Unable to create io_map /proc entry.\n");
+	ent = create_proc_read_entry("dvma_map",0,NULL,
+		_sparc_io_get_info,&_sparc_dvma);
+	if (!ent)
+		printk(KERN_WARNING 
+			"ioport.c: Unable to create dvma_map /proc entry.\n");
 #endif
 }

--
