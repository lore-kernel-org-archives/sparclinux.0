From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Wed, 22 Dec 2004 05:38:43 +0000
Subject: [sparc32] [2/3] Remove conflicting _exit
Message-Id: <1103693923.3913.71.camel@localhost.localdomain>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-6iWtBJOZzK4NScGJjcQ7"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--=-6iWtBJOZzK4NScGJjcQ7
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

sparc32 had a conflicting _exit, removed the line from asm-
sparc/unistd.h. This is the same change that DaveM made to sparc64 here:
http://linux.bkbits.net:8080/linux-2.6/diffs/include/asm-
sparc64/unistd.h@1.33

Warning was:
In file included from include/linux/unistd.h:9,
                 from init/main.c:45:
include/asm/unistd.h:489: warning: conflicting types for built-in
function '_exit'

Signed-off-by: Tom 'spot' Callaway <tcallawa@redhat.com>

~spot
---
Tom "spot" Callaway <tcallawa(a)redhat*com> LCA, RHCE 
Red Hat Sales Engineer || Aurora Linux Project Leader

"If you are going through hell, keep going."
- Sir Winston Churchill

--=-6iWtBJOZzK4NScGJjcQ7
Content-Disposition: attachment; filename=linux-2.6.9-sparc-unistdexitfix.patch
Content-Type: text/x-patch; name=linux-2.6.9-sparc-unistdexitfix.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.9/include/asm-sparc/unistd.h.BAD	2004-12-21 23:03:42.211033891 -0500
+++ linux-2.6.9/include/asm-sparc/unistd.h	2004-12-21 23:03:45.657509947 -0500
@@ -486,7 +486,6 @@ static __inline__ _syscall1(int,dup,int,
 static __inline__ _syscall3(int,execve,__const__ char *,file,char **,argv,char **,envp)
 static __inline__ _syscall3(int,open,__const__ char *,file,int,flag,int,mode)
 static __inline__ _syscall1(int,close,int,fd)
-static __inline__ _syscall1(int,_exit,int,exitcode)
 static __inline__ _syscall3(pid_t,waitpid,pid_t,pid,int *,wait_stat,int,options)
 
 #include <linux/linkage.h>

--=-6iWtBJOZzK4NScGJjcQ7--

