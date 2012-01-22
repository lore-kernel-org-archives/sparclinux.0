From: Kirill Tkhai <kirill.tkhai@gmail.com>
Date: Sun, 22 Jan 2012 19:57:42 +0000
Subject: sparc32: enabled CONFIG_SPARC_LEON leads to compile error
Message-Id: <1327262262.24076.17.camel@hp>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello!

I've just tried to compile kernel with enabled CONFIG_SPARC_LEON option
and I got a compile error. This is:

CC      arch/sparc/kernel/leon_pci.o
arch/sparc/kernel/leon_pci.c:156: error: redefinition of 'pci_device_to_OF_node'
include/linux/pci.h:1623: error: previous definition of 'pci_device_to_OF_node' was here
make[1]: *** [arch/sparc/kernel/leon_pci.o] Error 1
make: *** [arch/sparc/kernel] Error 2
make: *** Waiting for unfinished jobs....

It seems it happened because of closeness of two commits:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=commitdiff;hd099d981c9916ec4a485b3ffbb89fa877fc595f

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=commit;h&893c1368aeb96e06e4f9dce61bbde3351d5e9f

It looks like it's enough to remove double function from leon_pci.c.

Kirill

