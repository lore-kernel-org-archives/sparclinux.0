From: Jurij Smakov <jurij@wooyd.org>
Date: Tue, 07 Dec 2004 06:31:02 +0000
Subject: Re: mmap breakage
Message-Id: <Pine.LNX.4.61.0412070128110.12181@bobcat>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0412032354010.1963@bobcat>
In-Reply-To: <Pine.LNX.4.61.0412032354010.1963@bobcat>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 6 Dec 2004, David S. Miller wrote:

> Ok.  On sparc64 32-bit binaries get their ld-linux.so.2 mapped
> at:
>
> davem@nuts:~$ ldd ./nanotest
>        libc.so.6 => /lib/ultra3/libc.so.6 (0x7002c000)
>        /lib/ld-linux.so.2 => /lib/ld-linux.so.2 (0x70000000)
> davem@nuts:~$
>
> On sparc32, TASK_UNMAPPED_BASE is defined per-platform.
> On sun4c it is set to 0xe0000000, on srmmu systems it is
> set to 0x50000000.
>
> So the 0x08000000 address is still a complete mystery to me.

When I run ldd as above, I also get:

kundera:~# ldd ./a.out
         libc.so.6 => /lib/libc.so.6 (0x7002c000)
         /lib/ld-linux.so.2 => /lib/ld-linux.so.2 (0x70000000)

However, that's somehow different from running '/lib/ld-linux.so.2 ./a.out'
(ldd actually does it). Once you invoke ld-linux.so.2 as an executable, 
it's placement is controlled by ELF_ET_DYN_BASE, which is 0x08000000 for 
ELF32 binaries by default.

Best regards,

Jurij Smakov                                        jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                   KeyID: C99E03CC

