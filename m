From: Christian Joensson <christian@j-son.org>
Date: Mon, 19 Apr 2004 12:17:36 +0000
Subject: RPC: bad TCP reclen 0x05000b03 (non-terminal)
Message-Id: <20040419141736.A4049@fw.j-son.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Aurora SPARC Linux 1.0 (Ansel) SparcStation20 single SuperSparc-(II) sun4m:

kernel--2.4.26-0.1sparc (ftp://ftp.j-son.org/pub/aurora/kernel-2.4.26)

System serving as NFS server... for instance...

I get this in dmesg:

Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
RPC: bad TCP reclen 0x05000b03 (non-terminal)
RPC: bad TCP reclen 0x05000b03 (non-terminal)
RPC: bad TCP reclen 0x05000b03 (non-terminal)
RPC: bad TCP reclen 0x05000b03 (non-terminal)
svc: bad direction 268435456, dropping request
sunmouse: Successfully adjusted to 1200 baud.
svc: bad direction 268435456, dropping request
RPC: bad TCP reclen 0x05000b03 (non-terminal)
svc: bad direction 268501012, dropping request
RPC: bad TCP reclen 0x05000b03 (non-terminal)
RPC: bad TCP reclen 0x05000b03 (non-terminal)
RPC: bad TCP reclen 0x05000b03 (non-terminal)
RPC: bad TCP reclen 0x05000b03 (non-terminal)


Any idea of what is going on?

The kernel is only patched with hme patch udelay(1)....

Cheers,

/ChJ



