From: "David S. Miller" <davem@davemloft.net>
Date: Tue, 31 Aug 2004 00:40:15 +0000
Subject: [PATCH] Re: lvm problems on sparc64 - Trying to vfree() nonexistent
Message-Id: <20040830174015.10edb69b.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1093911340.2116.55.camel@duncow>
In-Reply-To: <1093911340.2116.55.camel@duncow>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Mortimer <richm@oldelvet.org.uk>, marcelo.tosatti@cyclades.com
Cc: sparclinux@vger.kernel.org, linux-lvm@sistina.com, debian-sparc@lists.debian.org

On Tue, 31 Aug 2004 01:15:40 +0100
Richard Mortimer <richm@oldelvet.org.uk> wrote:

> I'm seeing problems with lvm on sparc64. I have a reproducible test case
> using snapshots where I can reliably reproduce an error similar to
> 
> Trying to vfree() nonexistent vm area (0000000140072000)

For once it's not sparc64's fault, it's a bug in the generic
LVM ioctl handling :-)

It saves both pointers, clobbers the userspace copy, then only
restores one of the two pointers correctly.  Easy to fix, see
below.

Marcelo, please apply, thanks.

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/08/30 17:24:05-07:00 davem@nuts.davemloft.net 
#   [LVM]: Do not forget to restore both user pointers.
#   
#   This in particular can make compatability layers
#   crash, and it is a bug for regular applications
#   too.
#   
#   Signed-off-by: David S. Miller <davem@davemloft.net>
# 
# drivers/md/lvm.c
#   2004/08/30 17:23:48-07:00 davem@nuts.davemloft.net +12 -0
#   [LVM]: Do not forget to restore both user pointers.
#   
#   This in particular can make compatability layers
#   crash, and it is a bug for regular applications
#   too.
#   
#   Signed-off-by: David S. Miller <davem@davemloft.net>
# 
diff -Nru a/drivers/md/lvm.c b/drivers/md/lvm.c
--- a/drivers/md/lvm.c	2004-08-30 17:24:13 -07:00
+++ b/drivers/md/lvm.c	2004-08-30 17:24:13 -07:00
@@ -2689,6 +2689,10 @@
 			    (&lv_status_byname_req.lv->lv_current_pe,
 			     &saved_ptr1, sizeof(void *)) != 0)
 				return -EFAULT;
+			if (copy_to_user
+			    (&lv_status_byname_req.lv->lv_block_exception,
+			     &saved_ptr2, sizeof(void *)) != 0)
+				return -EFAULT;
 			return 0;
 		}
 	}
@@ -2743,6 +2747,10 @@
 	    (&lv_status_byindex_req.lv->lv_current_pe, &saved_ptr1,
 	     sizeof(void *)) != 0)
 		return -EFAULT;
+	if (copy_to_user
+	    (&lv_status_byindex_req.lv->lv_block_exception, &saved_ptr2,
+	     sizeof(void *)) != 0)
+		return -EFAULT;
 
 	return 0;
 }				/* lvm_do_lv_status_byindex() */
@@ -2799,6 +2807,10 @@
 	/* Restore usermode pointers */
 	if (copy_to_user
 	    (&lv_status_bydev_req.lv->lv_current_pe, &saved_ptr1,
+	     sizeof(void *)) != 0)
+		return -EFAULT;
+	if (copy_to_user
+	    (&lv_status_bydev_req.lv->lv_block_exception, &saved_ptr2,
 	     sizeof(void *)) != 0)
 		return -EFAULT;
 
