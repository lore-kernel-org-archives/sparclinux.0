From: Christoph Hellwig <hch@lst.de>
Date: Tue, 15 May 2007 11:13:25 +0000
Subject: [PATCH] sparc64: kill unused DIE_PAGE_FAULT enum value
Message-Id: <20070515111325.GA5815@lst.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

sparc64 got rid of the pagefault notifiers, so the enum value for them
can go away aswell.


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/include/asm-sparc64/kdebug.h
=================================--- linux-2.6.orig/include/asm-sparc64/kdebug.h	2007-05-15 13:12:02.000000000 +0200
+++ linux-2.6/include/asm-sparc64/kdebug.h	2007-05-15 13:12:06.000000000 +0200
@@ -32,7 +32,6 @@ enum die_val {
 	DIE_TRAP,
 	DIE_TRAP_TL1,
 	DIE_CALL,
-	DIE_PAGE_FAULT,
 };
 
 #endif
