From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Sun, 05 Aug 2007 02:41:15 +0000
Subject: procps needs PAGE_SIZE
Message-Id: <Pine.LNX.4.61.0708050326390.25352@mtfhpc.demon.co.uk>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi David,

There have been a number of changes at some point that have made 
PAGE_SIZE a kernel only constant.

For Sparc32, PAGE_SIZE changes betwen 4K and 8K depending on the 
configuration (sun4=8K, sun4c/d/m=4K)

Is there a syscall, /proc file or some other system that that provides 
access to PAGE_SIZE for user space programs (like procps ps)?

Regards
 	Mark Fortescue.

