From: Mathieu Chouquet-Stringer <mchouque@online.fr>
Date: Wed, 12 May 2004 00:23:03 +0000
Subject: unistd.h: warning: conflicting types for built-in function '_exit'
Message-Id: <20040512002303.GA25190@localhost>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

	Hi all,

I was trying to compile the latest 2.6 bk with gcc 3.4.0 and came across
this error. I checked the history of include/asm-i386/unistd.h and Andrew Morton
removed 2 lines in revision 1.32.

Here's his comment:
"Just remove the dang thing - nobody uses _exit().
  
Except for the vmware stub, which breaks.  So I kindly exported do_exit() to
kernel modules, just for vmware..."

Because vmware is only a i386 thing, I guess we don't need to do this so I
just replicated his work for sparc64.

Let me know if this is correct.

Cheers

--- include/asm-sparc64/unistd.h.orig	2004-05-11 20:05:11.000000000 -0400
+++ include/asm-sparc64/unistd.h	2004-05-11 20:06:58.000000000 -0400
@@ -437,7 +437,7 @@
  * won't be any messing with the stack from main(), but we define
  * some others too.
  */
-#define __NR__exit __NR_exit
+
 static __inline__ _syscall0(pid_t,setsid)
 static __inline__ _syscall3(int,write,int,fd,__const__ char *,buf,off_t,count)
 static __inline__ _syscall3(int,read,int,fd,char *,buf,off_t,count)
@@ -446,7 +446,7 @@
 static __inline__ _syscall3(int,execve,__const__ char *,file,char **,argv,char **,envp)
 static __inline__ _syscall3(int,open,__const__ char *,file,int,flag,int,mode)
 static __inline__ _syscall1(int,close,int,fd)
-static __inline__ _syscall1(int,_exit,int,exitcode)
+
 static __inline__ _syscall3(pid_t,waitpid,pid_t,pid,int *,wait_stat,int,options)
 
 #include <linux/linkage.h>


-- 
Mathieu Chouquet-Stringer                 E-Mail: mchouque@online.fr
       Never attribute to malice that which can be adequately
                    explained by stupidity.
                     -- Hanlon's Razor --
