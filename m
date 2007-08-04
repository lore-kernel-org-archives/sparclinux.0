From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Sat, 04 Aug 2007 14:16:33 +0000
Subject: Sparc32 Build Failure
Message-Id: <Pine.LNX.4.61.0708041511300.24119@mtfhpc.demon.co.uk>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi David,

Commit 6ba60d2195cd65d72eaf7ce3903a707c5bf20c7b breaks sparc32 build 
because asm-sparc/fcntl.h does not contain the required #defines.

   CC      init/main.o
In file included from 
/L64/src/linux-2.6/linux-test/include/linux/proc_fs.h:5,
                  from /L64/src/linux-2.6/linux-test/init/main.c:14:
/L64/src/linux-2.6/linux-test/include/linux/fs.h:848: warning: 'struct 
flock' de
clared inside parameter list
/L64/src/linux-2.6/linux-test/include/linux/fs.h:848: warning: its scope 
is only
  this definition or declaration, which is probably not what you want
/L64/src/linux-2.6/linux-test/include/linux/fs.h:850: warning: 'struct 
flock' de
clared inside parameter list
/L64/src/linux-2.6/linux-test/include/linux/fs.h:853: warning: 'struct 
flock64'
declared inside parameter list
/L64/src/linux-2.6/linux-test/include/linux/fs.h:855: warning: 'struct 
flock64'
declared inside parameter list
/L64/src/linux-2.6/linux-test/init/main.c: In function 'init_post':
/L64/src/linux-2.6/linux-test/init/main.c:788: error: 'O_RDWR' undeclared 
(first
  use in this function)
/L64/src/linux-2.6/linux-test/init/main.c:788: error: (Each undeclared 
identifie
r is reported only once
/L64/src/linux-2.6/linux-test/init/main.c:788: error: for each function it 
appea
rs in.)
make[2]: *** [init/main.o] Error 1
make[1]: *** [init] Error 2
make: *** [all] Error 2

I will sort out the mess and send you a patch that corrects the loss of 
asm-generic/fcntl.h

Regards
 	Mark Fortescue.
