From: Andy Whitcroft <apw@shadowen.org>
Date: Mon, 07 Jun 2004 15:32:10 +0000
Subject: [RFC] redundant checks in getdomainname
Message-Id: <200406071532.i57FWADo023297@voidhawk.shadowen.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Whilst looking at uses of __NEW_UTS_LEN in the kernel I spotted that
sparc and sparc64 architectures have their own implementation of the
getdomainname system call.  Looking at these it appears there is
a redundant check against __NEW_UTS_LEN in each.

We first bound the users buffer length by the current length of
the domainname uts member.  This element by definition cannot be
longer than __NEW_UTS_LEN, so the following check can never trigger.

asmlinkage int sys_getdomainname(char __user *name, int len)
{
[...]
        nlen = strlen(system_utsname.domainname) + 1;

        if (nlen < len)
                len = nlen;
        if (len > __NEW_UTS_LEN)
                goto done;
[...]
}

Attached is a patch to remove this check from both sparc and sparc64
architectures.  As I do not have the said hardware I have been unable
to test it.

Also can anyone tell me why these architectures have this call,
the generic code implies that uname can be used to fetch this
information and does not therefore supply an implmentation.

-apw


== 8< =The sparc/sparc64 architectures seem to have implmentations of the
sys_getdomainname system call.  The both seem to contain a redundant check
for len > __NEW_UTS_LEN which firstly should be reasonable as it is
allowable to pass an oversized buffer to this call and secondly can never
trigger as it will have been rounded down to the current length of this
field which must be less than this limit.

---
 sparc/kernel/sys_sparc.c   |    2 --
 sparc64/kernel/sys_sparc.c |    2 --
 2 files changed, 4 deletions(-)

diff -X /home/apw/lib/vdiff.excl -rupN reference/arch/sparc/kernel/sys_sparc.c current/arch/sparc/kernel/sys_sparc.c
--- reference/arch/sparc/kernel/sys_sparc.c	2004-03-11 20:47:15.000000000 +0000
+++ current/arch/sparc/kernel/sys_sparc.c	2004-06-07 17:13:28.000000000 +0100
@@ -471,8 +471,6 @@ asmlinkage int sys_getdomainname(char __
 
 	if (nlen < len)
 		len = nlen;
-	if (len > __NEW_UTS_LEN)
-		goto done;
 	if (copy_to_user(name, system_utsname.domainname, len))
 		goto done;
 	err = 0;
diff -X /home/apw/lib/vdiff.excl -rupN reference/arch/sparc64/kernel/sys_sparc.c current/arch/sparc64/kernel/sys_sparc.c
--- reference/arch/sparc64/kernel/sys_sparc.c	2004-05-10 14:55:08.000000000 +0100
+++ current/arch/sparc64/kernel/sys_sparc.c	2004-06-07 17:13:41.000000000 +0100
@@ -463,8 +463,6 @@ asmlinkage int sys_getdomainname(char __
 
         if (nlen < len)
                 len = nlen;
-	if (len > __NEW_UTS_LEN)
-		goto done;
 	if (copy_to_user(name, system_utsname.domainname, len))
 		goto done;
 	err = 0;
