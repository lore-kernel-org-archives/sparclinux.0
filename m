From: Jan Engelhardt <jengelh@medozas.de>
Date: Sun, 13 Dec 2009 23:57:08 +0000
Subject: Re: fstat seems broken on sparc64
Message-Id: <alpine.LSU.2.01.0912140054370.19051@obet.zrqbmnf.qr>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LSU.2.01.0912132357090.19051@obet.zrqbmnf.qr>
In-Reply-To: <alpine.LSU.2.01.0912132357090.19051@obet.zrqbmnf.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


On Monday 2009-12-14 00:08, Jan Engelhardt wrote:

>Hi,
>
>
>I noticed 64-bit tar incorrectly creating symlinks, and isolated this to 
>this testcase:[...]
>
>Linux ares 2.6.32 #16 SMP Sat Dec 5 21:02:04 CET 2009 sparc64 sparc64 
>sparc64 GNU/Linux [sun4v]
>
>This testcase will print, for example:
>
>1260745109.0
>1260745109.876573675
>1260745109.876573675
>
>So on a quick glance, fstat64 looks broken.
>I am trying to look at it further, but I hope you can beat me to it ;-)


It is because arch/sparc/include/stat.h does not define STAT_HAVE_NSEC 
for 64-bit sparc, even though there's nsec in struct stat64.
That leads to fs/stat.c not copying the subsecond parts to userspace (in 
function cp_new_stat).

I do not think I can just move STAT_HAVE_NSEC atop of stat.h, outside 
the #if64-32 block, since 'struct stat' does not have nsec on sparc64. 
Mind boggling!

What would be the best way to fix this?



thanks,
Jan
