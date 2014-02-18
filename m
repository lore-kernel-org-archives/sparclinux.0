From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Tue, 18 Feb 2014 09:57:34 +0000
Subject: Re: SPARC tftpboot.img build failure on 64-bit build host
Message-Id: <20140218095734.GO573@drone.musicnaut.iki.fi>
List-Id: <sparclinux.vger.kernel.org>
References: <20140217224000.GN573@drone.musicnaut.iki.fi>
In-Reply-To: <20140217224000.GN573@drone.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

On Tue, Feb 18, 2014 at 12:40:01AM +0200, Aaro Koskinen wrote:
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

This was actually caused by elftoaout (the source for the tool I have used
wrong size data types for a.out header when compiled on x86_64).

A.
