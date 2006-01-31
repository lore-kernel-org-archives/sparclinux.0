From: Michael Owen <mowen@costco.com>
Date: Tue, 31 Jan 2006 22:57:45 +0000
Subject: [PATCH] 2.6.15 Minor typo fix in fs/ufs/super.c
Message-Id: <C8172C455C579E448DD354B66AEC23A007E2FA28@pof00099p06.corp.costco.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I posted this on lkml, but never saw an answer, so I thought I'd post it
here, as it's more likely to be noticed here. 

There is a minor typo in fs/ufs/super.c in the error message for an
unspecified UFS type. I just happened to notice it while trying to mount a
fubared UFS partition on one of my Sparcs, so I thought I'd send in a patch
for it. 

I apologize for the formatting here, MS Exchange seems to be a requirement
at Fortune 50 companies. 

--- linux-2.6.15/fs/ufs/super.c 2006-01-02 19:21:10.000000000 -0800
+++ linux-2.6.15-mowen/fs/ufs/super.c   2006-01-27 18:04:17.586215000 -0800
@@ -575,7 +575,7 @@
                if (!silent)
                        printk("You didn't specify the type of your ufs
filesystem\n\n"
                        "mount -t ufs -o ufstype="
-
"sun|sunx86|44bsd|ufs2|5xbsd|old|hp|nextstep|netxstep-cd|openstep ...\n\n"
+
"sun|sunx86|44bsd|ufs2|5xbsd|old|hp|nextstep|nextstep-cd|openstep ...\n\n"
                        ">>>WARNING<<< Wrong ufstype may corrupt your
filesystem, "
                        "default is ufstype=old\n");
                ufs_set_opt (sbi->s_mount_opt, UFSTYPE_OLD);
