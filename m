From: Otto Solares <solca@guug.org>
Date: Thu, 29 Jan 2004 22:58:03 +0000
Subject: Re: SILO 1.4.2 released
Message-Id: <20040129225803.GD14503@guug.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040129182954.GK532@phunnypharm.org>
In-Reply-To: <20040129182954.GK532@phunnypharm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, Jan 29, 2004 at 04:01:03PM -0500, Ben Collins wrote:
> Read the fucking email. I want people to test the _old_ smaller kernels
> _first_. I would rather the larger kernels be broken than for the new
> SILO to not work with the older kernels.

Sorry, i think the point was test larger kernels.  Anyway
my older kernels boots properly with the new second.b. Newer
larger kernel 2.6.2-rc2-bk3 4M boots perfectly too on 3
different machines.

FYI compiling silo-1.4.3 from source:

gcc -m32 -Os -Wall -I. -I../include -fomit-frame-pointer -fno-strict-aliasing -DSMALL_RELOC=0x280000 -DLARGE_RELOC=0x380000 -c fs/ufs.c -o fs/ufs.o
In file included from /usr/include/linux/fs.h:16,
                 from /usr/include/linux/ufs_fs.h:34,
                 from fs/ufs.c:36:
/usr/include/linux/list.h:594:2: warning: #warning "don't include kernel headers in userspace"
In file included from /usr/include/linux/fs.h:20,
                 from /usr/include/linux/ufs_fs.h:34,
                 from fs/ufs.c:36:
/usr/include/linux/radix-tree.h: In function `radix_tree_preload_end':
/usr/include/linux/radix-tree.h:54: error: invalid type argument of `->'
/usr/include/linux/radix-tree.h:54: error: `TIF_NEED_RESCHED' undeclared (first use in this function)
/usr/include/linux/radix-tree.h:54: error: (Each undeclared identifier is reported only once
/usr/include/linux/radix-tree.h:54: error: for each function it appears in.)
make: *** [fs/ufs.o] Error 1

-solca

