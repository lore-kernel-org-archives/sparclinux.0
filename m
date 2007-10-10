From: David Miller <davem@davemloft.net>
Date: Wed, 10 Oct 2007 03:57:02 +0000
Subject: Re: Bug: semctl failures on sparc64
Message-Id: <20071009.205702.75189089.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1191346088.3553.151.camel@localhost.localdomain>
In-Reply-To: <1191346088.3553.151.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Tom \"spot\" Callaway" <tcallawa@redhat.com>
Date: Tue, 02 Oct 2007 13:28:08 -0400

> I've been trying to track down why postgresql has been failing to run
> its tests when built for sparc64, and working with Tom Lane, we've
> generated an independent test case showing that the failure seems to be
> in the kernel.
> 
> The test case is attached:
> 
> bash-3.2# gcc -m32 -o semtest32 semtest.c 
> bash-3.2# ./semtest32 
> created semaphores with id 32769
> bash-3.2# gcc -m64 -o semtest64 semtest.c 
> bash-3.2# ./semtest64
> semctl: Invalid argument
> 
> Thanks in advance,

This should fix it, thanks again Tom.

commit 6536a6b331d3225921c398eb7c6e4ecedb9b05e0
Author: David S. Miller <davem@sunset.davemloft.net>
Date:   Tue Oct 9 20:56:31 2007 -0700

    [SPARC64]: Fix bugs in SYSV IPC handling in 64-bit processes.
    
    Thanks to Tom Callaway for the excellent bug report and
    test case.
    
    sys_ipc() has several problems, most to due with semaphore
    call handling:
    
    1) 'err' return should be a 'long'
    2) "union semun" is passed in a register on 64-bit compared
       to 32-bit which provides it on the stack and therefore
       by reference
    3) Second and third arguments to SEMCTL are swapped compared
       to 32-bit.
    
    Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/arch/sparc64/kernel/sys_sparc.c b/arch/sparc64/kernel/sys_sparc.c
index d108eeb..0d5c502 100644
--- a/arch/sparc64/kernel/sys_sparc.c
+++ b/arch/sparc64/kernel/sys_sparc.c
@@ -436,7 +436,7 @@ out:
 asmlinkage long sys_ipc(unsigned int call, int first, unsigned long second,
 			unsigned long third, void __user *ptr, long fifth)
 {
-	int err;
+	long err;
 
 	/* No need for backward compatibility. We can start fresh... */
 	if (call <= SEMCTL) {
@@ -453,16 +453,9 @@ asmlinkage long sys_ipc(unsigned int call, int first, unsigned long second,
 			err = sys_semget(first, (int)second, (int)third);
 			goto out;
 		case SEMCTL: {
-			union semun fourth;
-			err = -EINVAL;
-			if (!ptr)
-				goto out;
-			err = -EFAULT;
-			if (get_user(fourth.__pad,
-				     (void __user * __user *) ptr))
-				goto out;
-			err = sys_semctl(first, (int)second | IPC_64,
-					 (int)third, fourth);
+			err = sys_semctl(first, third,
+					 (int)second | IPC_64,
+					 (union semun) ptr);
 			goto out;
 		}
 		default:
