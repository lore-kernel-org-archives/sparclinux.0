From: Jurij Smakov <jurij@wooyd.org>
Date: Mon, 07 Feb 2005 18:21:16 +0000
Subject: Hang in SIOCGIFCONF ioctl handler
Message-Id: <Pine.LNX.4.61.0502071259370.2050@bobcat>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello,

While investigating the Debian bug #288180 [0] (both SMP and UP sparc64 
machines lock up hard when starting NIS with 2.6.8-10), I've traced the 
hang to the handler of SIOCGIFCONF ioctl, dev_ifconf function in 
fs/compat_ioctl.c. The problem happens in the following code snippet (line 
numbers refer to the pristine 2.6.10 kernel tree):

510                 size_t len =((ifc32.ifc_len / sizeof (struct ifreq32)) + 1) *
511                         sizeof (struct ifreq);
512                 uifc = compat_alloc_user_space(sizeof(struct ifconf) + len);
513                 ifc.ifc_len = len;
514                 ifr = ifc.ifc_req = (void __user *)(uifc + 1);
515                 ifr32 = compat_ptr(ifc32.ifcbuf);
516                 for (i = 0; i < ifc32.ifc_len; i += sizeof (struct ifreq32)) {
517                         if (copy_in_user(ifr, ifr32, sizeof(struct ifreq32)))
518                                 return -EFAULT;
519                         ifr++;
520                         ifr32++; 
521                 }

By inserting some debugging statements, I was able to figure out that 
machine hangs because at some point the call to copy_in_user function does 
not return. As I have no idea why it would block, I wonder if anyone can 
offer any advice. This code was introduced about 9 months ago [1]. If I 
revert this patch, everything seems to be working again (no hang).

On an unrelated note, during my exploration I came across the function 
copy_in_user_fixup in arch/sparc64/lib/user_fixup.c. In this function (and 
in other functions in that file) copying is done using a loop like this:

   while(size--) {
     ...
   }
   return size;

I am pretty sure that this function is supposed to follow the same error 
reporting convention as copy_in_user, i.e. return 0 on success, non-zero 
on error. As they are written now, the loop will stop at size = 0, but it 
will return -1 due to extra decrement, which is not what one would expect.

Best regards,

[0] http://bugs.debian.org/288180
[1] http://linux.bkbits.net:8080/linux-2.6/diffs/fs/compat_ioctl.c@1.25.1.9?nav=index.html|src/|src/fs|hist/fs/compat_ioctl.c

Jurij Smakov                                        jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                   KeyID: C99E03CC
