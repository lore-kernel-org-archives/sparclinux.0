From: David Miller <davem@davemloft.net>
Date: Tue, 18 Feb 2014 22:32:59 +0000
Subject: Re: SPARC tftpboot.img build failure on 64-bit build host
Message-Id: <20140218.173259.212759865702662898.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20140217224000.GN573@drone.musicnaut.iki.fi>
In-Reply-To: <20140217224000.GN573@drone.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Tue, 18 Feb 2014 00:40:01 +0200

> Last weekend I upgraded my cross-compilation host from 32-bit to
> 64-bit box, and probably because of this I'm now seeing the following
> build failure with "tftpboot.img" target with current 3.14-rc:
> 
>   CALL    scripts/checksyscalls.sh
>   CHK     include/generated/compile.h
>   kernel: arch/sparc/boot/image is ready
>   ELFTOAOUT arch/sparc/boot/tftpboot.img
> PT 0 Entry: Loadable to 0x400000[0x91bb20] from 0x0[0x4baff8] align 0x100000
> PT 1 Entry: Note
> PT 2 Entry: unknown
>   PIGGY   arch/sparc/boot/tftpboot.img
> lseek: Invalid argument
> make[5]: *** [arch/sparc/boot/tftpboot.img] Error 1
> 
> Since the tftpboot.img for current kernels is no longer usable anyway on
> old SPARCs due to size limitations, I was wondering should we just delete
> this code altogether from the kernel tree, or should we try to fix it?
> People actually needing TFTP images can still use SILO/TILO...

I'd like to try and get it working again.

The trick is figuring out a reliable and clean way to allocate those
larger tables at run time during early boot, which is non-trivial.
