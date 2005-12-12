From: "Mark Fortescue" <mark@mtfhpc.demon.co.uk>
Date: Mon, 12 Dec 2005 10:13:37 +0000
Subject: Re: Sparc: Kernel 2.6.13 to 2.6.15-rc2 bug when running X11
Message-Id: <DGEKIABPPPEBAOMKAJCEKEAKCBAA.mark@mtfhpc.demon.co.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <20051205.181732.34234732.davem@davemloft.net>
In-Reply-To: <20051205.181732.34234732.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: trizt@iname.com, "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

Hi Aho and David,

I have been having a number of sparc-linux kernel build problems with both
gcc-3.4.x and gcc-4.0.x so I would be interested to know what versions of
gcc you are using.

I am cross compiling as my Sparc1's are not up to building large amounts of
code so I may have additional 'bugs' in gcc to muddy the issue.

My gcc-3.4.4 has an issue with '%llu' in printk statements. After changing
the offending printk '%llu' to '%lu' versions I end up with a system that
appears to boot OK.
Providing you are patient, I can compile/run simple programs but there is
something fishy in the memory handling code that results in intermittent
memory faults. This may be a Bash or libc issue but I have not looked into
this. (gcc-3.4.2 and gcc-3.4.3 have the same problem with the %llu printk
statements.)

My gcc-4.0.2 has a different issue. It appears to work find and the
unmodified kernel boots fine. If I try to compile a program on the Sparc1
using a canadian cross compiled gcc/binutils, the linker fails with a Kernel
BUG (see 22 Nov: sun4c problems in radix_tree_gang_lookup_tag in
sparclinux@vger.kernel.org) in the radix-tree code. The same gcc/binutils
works without any kernel BUGs if I use the gcc-3.4.4 compiled kernel but
with everything ell compiled using gcc-4.0.2/binutils 2.16.1.

The affected kernels that I have tested ate 2.6.13.4, 2.6.14.2, 2.6.14.3 and
2.6.15-rc4.

Note: I am using an NFS root as the UFS filing system code is not write safe
on SUNOS 4.1 BSD UFS 4.2 partitions. My efforts to investigate/fix the UFS
filing system issues on my x86 system locked the system up, requiring a
power-up reset so for the moment, I have to live with the NFS root.

Regards
	Mark Fortescue.


