From: Andy Walker <ajwalker@broadpark.no>
Date: Tue, 05 Sep 2006 07:05:07 +0000
Subject: Possible bug in sys_getdomainname() on sparc64
Message-Id: <43513.192.168.1.10.1157439907.squirrel@otter.puszczka.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

There was a change between 2.6.18-rc2 and -rc3 to the buffer
length error checking in sys_getdomainname(). On my Gentoo
sparc64 box this breaks hostname when called as hostname -y/
nisdomainname. The call returns EINVAL cause by passing an
oversize buffer to the sycall.

The buffer is checked against __NEW_UTS_LEN, but I cannot
see how it is a crime to pass an oversize buffer to a get_
call. Instead we need to check that len is >= nlen. nlen
cannot be longer than __NEW_UTS_LEN anyway as nlen is the
length of the string stored in the uts structure.

asmlinkage long sys_getdomainname(char __user *name, int len)
{
         int nlen, err;

         if (len < 0 || len > __NEW_UTS_LEN)
                        ^^^^^^^^^^^^^^^^^^^
                 return -EINVAL;

         down_read(&uts_sem);

         nlen = strlen(system_utsname.domainname) + 1;
         if (nlen < len)
                 len = nlen;

         err = -EFAULT;
         if (!copy_to_user(name, system_utsname.domainname, len))
                 err = 0;

         up_read(&uts_sem);
         return err;
}

How about this patch or something similar.

cheers,
Andy

--- linux-2.6.18-rc5/arch/sparc64/kernel/sys_sparc.c.old	2006-09-04
23:25:59.000000000 +0200
+++ linux-2.6.18-rc5/arch/sparc64/kernel/sys_sparc.c	2006-09-04
23:31:25.000000000 +0200
@@ -703,19 +703,21 @@
  {
          int nlen, err;

-	if (len < 0 || len > __NEW_UTS_LEN)
+	if (len < 0)
  		return -EINVAL;

   	down_read(&uts_sem);

  	nlen = strlen(system_utsname.domainname) + 1;
-        if (nlen < len)
-                len = nlen;
+	err = -EINVAL;
+	if (nlen > len)
+		goto out;

  	err = -EFAULT;
-	if (!copy_to_user(name, system_utsname.domainname, len))
+	if (!copy_to_user(name, system_utsname.domainname, nlen))
  		err = 0;

+out:
  	up_read(&uts_sem);
  	return err;
  }





