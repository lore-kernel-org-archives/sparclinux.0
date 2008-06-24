From: Mikulas Patocka <mpatocka@redhat.com>
Date: Tue, 24 Jun 2008 05:56:07 +0000
Subject: [2/10 PATCH] inline inline-generic_writepages.patch
Message-Id: <Pine.LNX.4.64.0806240155200.27784@engineering.redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0806240136200.27784@engineering.redhat.com>
 <Pine.LNX.4.64.0806240154140.27784@engineering.redhat.com>
In-Reply-To: <Pine.LNX.4.64.0806240154140.27784@engineering.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Cc: davem@davemloft.net

Make generic_writepages inlinable in current file.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

Index: linux-2.6.26-rc7-devel/mm/page-writeback.c
=================================--- linux-2.6.26-rc7-devel.orig/mm/page-writeback.c	2008-06-24 07:28:14.000000000 +0200
+++ linux-2.6.26-rc7-devel/mm/page-writeback.c	2008-06-24 07:37:15.000000000 +0200
@@ -981,8 +981,8 @@
   * This is a library function, which implements the writepages()
   * address_space_operation.
   */
-int generic_writepages(struct address_space *mapping,
-		       struct writeback_control *wbc)
+__always_inline int generic_writepages(struct address_space *mapping,
+				       struct writeback_control *wbc)
  {
  	/* deal with chardevs and other special file */
  	if (!mapping->a_ops->writepage)

