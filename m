From: Richard Mortimer <richm@oldelvet.org.uk>
Date: Tue, 31 Aug 2004 22:00:10 +0000
Subject: Re: [PATCH] Re: lvm problems on sparc64 - Trying to vfree()
Message-Id: <1093989609.2124.139.camel@duncow>
List-Id: <sparclinux.vger.kernel.org>
References: <1093911340.2116.55.camel@duncow>
	<20040830174015.10edb69b.davem@davemloft.net>
In-Reply-To: <20040830174015.10edb69b.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, debian-sparc@lists.debian.org, linux-lvm@sistina.com, richm@oldelvet.org.uk, marcelo.tosatti@cyclades.com

Thanks. Fixes the problem nicely.

Whilst I remember I forgot to include the patch below last night. When I
was looking at the ioctl32.c code I noticed a few inconsistencies in the
structures used in the copy to/from user calls. I don't think that the
original versions were incorrect but it seems best to make things
consistent.

How do they look

Richard

--- arch/sparc64/kernel/ioctl32.c.orig	2004-08-29 00:12:09.000000000
+0100
+++ arch/sparc64/kernel/ioctl32.c	2004-08-31 22:06:23.000000000 +0100
@@ -2949,7 +2949,7 @@
 	case LV_REMOVE:
 	case LV_RENAME:
 	case LV_STATUS_BYNAME:
-	        err = copy_from_user(&u.pv_status, arg,
sizeof(u.pv_status.pv_name));
+	        err = copy_from_user(&u.lv_req, arg,
sizeof(u.lv_req.lv_name));
 		if (err)
 			return -EFAULT;
 		if (cmd != LV_REMOVE) {
@@ -2992,7 +2992,7 @@
 
 	case PV_CHANGE:
 	case PV_STATUS:
-		err = copy_from_user(&u.pv_status, arg, sizeof(u.lv_req.lv_name));
+		err = copy_from_user(&u.pv_status, arg, sizeof(u.pv_status.pv_name));
 		if (err)
 			return -EFAULT;
 		err = __get_user(ptr, &((pv_status_req32_t *)arg)->pv);
@@ -3064,7 +3064,7 @@
 	        if (u.lv_bydev.lv) {
 			if (!err)
 				err = copy_lv_t(ptr, u.lv_bydev.lv);
-			put_lv_t(u.lv_byindex.lv);
+			put_lv_t(u.lv_bydev.lv);
 	        }
 	        break;
 



On Tue, 2004-08-31 at 01:40, David S. Miller wrote:
> On Tue, 31 Aug 2004 01:15:40 +0100
> Richard Mortimer <richm@oldelvet.org.uk> wrote:
> 
> > I'm seeing problems with lvm on sparc64. I have a reproducible test case
> > using snapshots where I can reliably reproduce an error similar to
> > 
> > Trying to vfree() nonexistent vm area (0000000140072000)
> 
> For once it's not sparc64's fault, it's a bug in the generic
> LVM ioctl handling :-)
> 
> It saves both pointers, clobbers the userspace copy, then only
> restores one of the two pointers correctly.  Easy to fix, see
> below.
> 
> Marcelo, please apply, thanks.

-- 
richm@oldelvet.org.uk

