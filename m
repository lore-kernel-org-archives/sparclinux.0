From: Richard Mortimer <richm@oldelvet.org.uk>
Date: Tue, 31 Aug 2004 00:15:40 +0000
Subject: lvm problems on sparc64 - Trying to vfree() nonexistent vm area
Message-Id: <1093911340.2116.55.camel@duncow>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org, debian-sparc@lists.debian.org
Cc: richm@oldelvet.org.uk, linux-lvm@sistina.com

All,

I'm seeing problems with lvm on sparc64. I have a reproducible test case
using snapshots where I can reliably reproduce an error similar to

Trying to vfree() nonexistent vm area (0000000140072000)

Under some circumstances I can get this to lead to a panic where the
kernel reports that it is unable to handle a paging request for the same
request (the address below is different because it comes from a
different attempt to reproduce it)

Unable to handle kernel paging request at virtual address
000000014007a000

First off the obligatory "what I'm using" statement.

I've seen this with debian/testing on sparc using the stock 2.4.26
kernel.
Using lvm1.0.8

pingu:~# apt-show-versions | grep lvm
lvm10/testing uptodate 1:1.0.8-4
lvm-common/testing uptodate 1.5.16

kernel-image-2.4.26-sparc64/testing uptodate 39


I've done a fair amount of detective work and am now fairly confident
that the problem is somewhere in the sparc64 ioctl32 glue code in
arch/sparc64/kernel/ioctl32.c

Adding printk tracing into the kernel and using strace I can see that
the problem occurs on a call to 

ioctl(4, LV_STATUS_BYNAME, 0xeffff9f8)  = 0

The message only gets reported on second and subsequent calls to this
ioctl. So I'm guessing that something gets freed wrongly during the
first call.

I added some tracing into do_lvm_ioctl() in ioctl32.c. From this I can
see that the problem gets reported after calling the "real" ioctl
routine whilst transferring the result data back into the 32 bit
structures.

Specifically the problem is occurring in put_lv_t(u.lv_req.lv) as called
from the LV_CREATE/EXTEND/REDUCE case in the switch statement.

This means that the problem is related to the vfree of either
l->lv_current_pe or l->lv_block_exception.

I cannot see anything obviously wrong there (and need some sleep!) so
hopefully someone else will have some ideas as to what the problem is.

Thanks

Richard

P.S.

Forgot to mention. The steps to reproduct the problem are (assuming that
you have a vg called test)

lvcreate --size 128M --name fsone /dev/test
lvcreate --size 128M --name fstwo /dev/test
lvcreate --snapshot --size 128M --name bakone /dev/test/fsone
lvremove /dev/test/bakone

You get the problem even before you answer the y/n question in lvremove.

-- 
richm@oldelvet.org.uk

