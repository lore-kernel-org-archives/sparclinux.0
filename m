From: Jakub Jelinek <jakub@redhat.com>
Date: Tue, 07 Dec 2004 08:24:40 +0000
Subject: Re: mmap breakage
Message-Id: <20041207082439.GG10340@devserv.devel.redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0412032354010.1963@bobcat>
In-Reply-To: <Pine.LNX.4.61.0412032354010.1963@bobcat>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Dec 06, 2004 at 10:06:26PM -0800, David S. Miller wrote:
> On Tue, 7 Dec 2004 01:00:47 -0500 (EST)
> Jurij Smakov <jurij@wooyd.org> wrote:
> 
> > On the sparclinux@vger list we have been recently discussing an issue of 
> > ld-linux.so.2 failing with SIGILL when executed directly with the 
> > executable name as an argument [0]. This problem was traced to the mmap 
> > call overwriting portions of ld-linux.so.2 itself. Insight provided by 
> > glibc people [1] helped to determine that on sparc64 the ld-linux.so.2 
> > is mapped at 0x08000000, leaving just 128MB for the executable.
> 
> Actually, Jurij when you run ldd on a 64-bit binary what does
> it say?  I can't reproduce that strange 0x08000000 address.
> 
> For me it seems to put ld-linux.so.2 at just the right spot:
> 
> davem@nuts:~$ file nanotest
> nanotest: ELF 64-bit MSB executable, SPARC V9, version 1 (SYSV), for GNU/Linux 2.4.18, dynamically linked (uses shared libs), not stripped
> davem@nuts:~$ ldd nanotest
>         libc.so.6 => /lib64/libc.so.6 (0xfffff80000120000)
>         /lib64/ld-linux.so.2 => /lib64/ld-linux.so.2 (0xfffff80000000000)
> davem@nuts:~$ 

Try LD_TRACE_PRELINKING=1 LD_WARN= /lib64/ld-linux.so.2 ./nanotest

	Jakub
