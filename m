From: Jan Engelhardt <jengelh@computergmbh.de>
Date: Fri, 24 Aug 2007 16:24:48 +0000
Subject: errno codes intertwined
Message-Id: <Pine.LNX.4.64.0708241815540.28540@fbirervta.pbzchgretzou.qr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, parisc-linux@parisc-linux.org

Hello lists,


I am currently working on a FUSE-based filesystem much like nfs/sshfs. 
I pass the syscall on to the storage server, where it is executed, and 
get back the result, or errno code. Let's jump into the real world 
example where the storage unit is x86_64 and the mount side is 
sparc/sparc64, and the syscall is getxattr.

If a file does not have the requested attribute, the syscall will 
produce ENODATA. On x86_64, that is mapped to the value 61. Back on the 
sparc side, 61 is mapped to ECONNREFUSED, and that gives odd errors 
when ls tries to query xattrs:

18:20 sun:../ccgfs/src # ls -dl /home/profile
ls: /home/profile: Connection refused
drwx------ 13 cf users 4096 Aug 24 16:05 /home/profile

Just a grep away, this came up:

18:16 ichi:../linux-2.6.23/include > grep -r ENODATA .
./asm-alpha/errno.h:#define     ENODATA         86      /* No data available */
./asm-generic/errno.h:#define   ENODATA         61      /* No data available */
./asm-mips/errno.h:#define      ENODATA         61      /* No data available */
./asm-parisc/errno.h:#define    ENODATA         51      /* No data available */
./asm-sparc/errno.h:#define     ENODATA         111     /* No data available */
./asm-sparc/solerrno.h:#define  SOL_ENODATA        61    /* No data avail at this time       */
./asm-sparc64/errno.h:#define   ENODATA         111     /* No data available */
./asm-sparc64/solerrno.h:#define        SOL_ENODATA        61    /* No data avail at this time       */

Why do these architectures deviate from asm-generic? In fact,

./asm-alpha/errno.h:#define     ECONNREFUSED    61      /* Connection refused */
./asm-generic/errno.h:#define   ECONNREFUSED    111     /* Connection refused */
./asm-sparc/errno.h:#define     ECONNREFUSED    61      /* Connection refused */
./asm-sparc64/errno.h:#define   ECONNREFUSED    61      /* Connection refused */

the values are exactly swapped (mips is another oddball not portrayed 
here). Since these header files propagate into /usr/include, this 
affects userspace programs too.

So I'm just asking: can I rely on the same errno across Linuxes?
And should the errno values be fixed up?



	Jan
-- 
