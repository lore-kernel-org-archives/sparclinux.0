From: maximilian attems <max@stro.at>
Date: Sun, 14 Mar 2010 16:11:59 +0000
Subject: klibc sparc sockets foo
Message-Id: <20100314161159.GA23007@stro.at>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

hello dave,

could you have a look at this sparc klibc trouble:
ipconfig: eth0: socket(AF_INET): Function not implemented

git clone git://git.kernel.org/pub/scm/libs/klibc/klibc.git

and review belows proposed fix?

thanks
maks


commit 4d0c11edfdad0493d97466b00e75b33786bab762
Author: jeremy buisson <jeremy.buisson@st-cyr.terre-net.defense.gouv.fr>
Date:   Wed May 27 08:57:23 2009 +0200

    [klibc] sparc64: fix bad 32 bits socket syscalls
    
    
    The 32 bits version of socket-related syscalls for sparc/sparc64 does
    not seem to conform to the interface provided by the kernel. As a
    result, klibc-utils commands such as ipconfig ends with a "ipconfig:
    eth0: socket(AF_INET): Function not implemented".
    
    See bug #444087 for the log with an older version. See for the following
    session for another evidence of the problem with a newer version:
    jeremy@sunny:~$ /usr/lib/klibc/bin/ipconfig lo
    ipconfig: lo: socket(AF_INET): Function not implemented
    /usr/lib/klibc/bin/ipconfig: no devices to configure
    
    Looking at the source code, it seems there is 2 call mechanisms:
    - if the kernel header files (asm/unistd.h) defines __NR_socket (and so
    on), the makefiles uses the syscall interface ;
    - otherwise, the makefiles uses the socketcall interface, which wraps
    the call into a common syscall (named socketcall).
    See the <src>/usr/klibc/syscalls.pl and <src>/usr/klibc/socketcalls.pl
    for details.
    
    Looking at the kernel source code for the 32 bits syscall table for the
    sparc64 architecture <src-2.6.26>/arch/sparc64/kernel/systbls.S, we see
    at index __NR_socket (97 according to asm-sparc/unistd.h and to
    asm-sparc64/unistd.h) that the entry points to sys_nis_syscall. Looking
    in <src-2.6.26>/arch/sparc64/kernel/syscalls.S, it branches to
    c_sys_nis_syscall, which (<src-2.6.26>/arch/sparc64/kernel/sys_sparc.c)
    returns ENOSYS, the error code for non-implemented syscalls.
    
    According to my quick tests, there are 2 workarounds:
    1) compile klibc to sparc64, as the 64 bits syscall table of the kernel
    provides the direct socket (and related) syscalls
    2) patch klibc such that it uses socketcall when targeting sparc(32).
    
    
    http://bugs.debian.org/444087
    
    Here is a sample patch for the 2nd option:

diff --git a/usr/klibc/SYSCALLS.def b/usr/klibc/SYSCALLS.def
index c12d525..0599dac 100644
--- a/usr/klibc/SYSCALLS.def
+++ b/usr/klibc/SYSCALLS.def
@@ -259,4 +259,9 @@ int sysinfo(struct sysinfo *);
  * system calls.
  */
 <?!i386> long socketcall::__socketcall(int, const unsigned long *);
+#if !defined(__sparc__) && !defined(__arch64__)
+/*
+ * SPARC does not have direct syscalls for socket
+ */
 #include "SOCKETCALLS.def"
+#endif
diff --git a/usr/klibc/socketcalls.pl b/usr/klibc/socketcalls.pl
index e6f75ab..01993e8 100644
--- a/usr/klibc/socketcalls.pl
+++ b/usr/klibc/socketcalls.pl
@@ -63,7 +63,7 @@ while ( defined($line = <FILE>) ) {
 
 	    print OUT "#include \"socketcommon.h\"\n";
 	    print OUT "\n";
-	    print OUT "#ifndef __NR_${name}\n\n";
+	    print OUT "#if (defined(__sparc__) && !defined(__arch64__)) || !defined __NR_${name}\n\n";
 
 	    print OUT "extern long __socketcall(int, const unsigned long *);\n\n";
 
