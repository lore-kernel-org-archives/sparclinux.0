From: "David S. Miller" <davem@davemloft.net>
Date: Tue, 07 Dec 2004 06:20:17 +0000
Subject: Re: mmap breakage
Message-Id: <20041206222017.3e667a2d.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0412032354010.1963@bobcat>
In-Reply-To: <Pine.LNX.4.61.0412032354010.1963@bobcat>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 6 Dec 2004 22:11:11 -0800
Keith M Wesolowski <wesolows@foobazco.org> wrote:

> On Mon, Dec 06, 2004 at 10:06:26PM -0800, David S. Miller wrote:
> 
> > Actually, Jurij when you run ldd on a 64-bit binary what does
> > it say?  I can't reproduce that strange 0x08000000 address.
> 
> /lib/ld-linux.so.2 and the programs in question are ELF32.  The
> ET_DYN_BASE is the same on sparc64 for ELF32 objects as it is on
> sparc32.  Presumably the latter is to accomodate the silly 4c VM
> hole...

Ok.  On sparc64 32-bit binaries get their ld-linux.so.2 mapped
at:

davem@nuts:~$ ldd ./nanotest 
        libc.so.6 => /lib/ultra3/libc.so.6 (0x7002c000)
        /lib/ld-linux.so.2 => /lib/ld-linux.so.2 (0x70000000)
davem@nuts:~$ 

On sparc32, TASK_UNMAPPED_BASE is defined per-platform.
On sun4c it is set to 0xe0000000, on srmmu systems it is
set to 0x50000000.

So the 0x08000000 address is still a complete mystery to me.
