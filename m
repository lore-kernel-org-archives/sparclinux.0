From: "David S. Miller" <davem@davemloft.net>
Date: Tue, 07 Dec 2004 06:06:26 +0000
Subject: Re: mmap breakage
Message-Id: <20041206220626.3ae45a03.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0412032354010.1963@bobcat>
In-Reply-To: <Pine.LNX.4.61.0412032354010.1963@bobcat>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, 7 Dec 2004 01:00:47 -0500 (EST)
Jurij Smakov <jurij@wooyd.org> wrote:

> On the sparclinux@vger list we have been recently discussing an issue of 
> ld-linux.so.2 failing with SIGILL when executed directly with the 
> executable name as an argument [0]. This problem was traced to the mmap 
> call overwriting portions of ld-linux.so.2 itself. Insight provided by 
> glibc people [1] helped to determine that on sparc64 the ld-linux.so.2 
> is mapped at 0x08000000, leaving just 128MB for the executable.

Actually, Jurij when you run ldd on a 64-bit binary what does
it say?  I can't reproduce that strange 0x08000000 address.

For me it seems to put ld-linux.so.2 at just the right spot:

davem@nuts:~$ file nanotest
nanotest: ELF 64-bit MSB executable, SPARC V9, version 1 (SYSV), for GNU/Linux 2.4.18, dynamically linked (uses shared libs), not stripped
davem@nuts:~$ ldd nanotest
        libc.so.6 => /lib64/libc.so.6 (0xfffff80000120000)
        /lib64/ld-linux.so.2 => /lib64/ld-linux.so.2 (0xfffff80000000000)
davem@nuts:~$ 

And actually executing the binary shows that it is in fact
mapped at 0xfffff80000000000.

davem@nuts:~$ cat /proc/1707/maps
00100000-00102000 r-xp 00000000 08:11 164461                             /home/davem/nanotest
00200000-00202000 rwxp 00000000 08:11 164461                             /home/davem/nanotest
7ffffffe000-80000000000 rw-p 7ffffffe000 00:00 0 
fffff80000000000-fffff8000001c000 r-xp 00000000 08:11 894371             /lib64/ld-2.3.2.so
fffff8000001c000-fffff8000001e000 rw-p fffff8000001c000 00:00 0 
fffff8000011c000-fffff8000011e000 rwxp 0001c000 08:11 894371             /lib64/ld-2.3.2.so
fffff80000120000-fffff80000276000 r-xp 00000000 08:11 895274             /lib64/libc-2.3.2.so
fffff80000276000-fffff80000320000 ---p 00156000 08:11 895274             /lib64/libc-2.3.2.so
fffff80000320000-fffff80000380000 rwxp 00100000 08:11 895274             /lib64/libc-2.3.2.so
fffff80000380000-fffff80000384000 rwxp fffff80000380000 00:00 0 
davem@nuts:~$ 
