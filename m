From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Thu, 24 Nov 2016 21:23:27 +0000
Subject: Re: [PATCH] silo: Add 64-bit support
Message-Id: <20161124212327.m7klcua3z7tk3lws@raspberrypi-2.musicnaut.iki.fi>
List-Id: <sparclinux.vger.kernel.org>
References: <20161124173330.3087-1-glaubitz@physik.fu-berlin.de>
In-Reply-To: <20161124173330.3087-1-glaubitz@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

On Thu, Nov 24, 2016 at 06:33:30PM +0100, John Paul Adrian Glaubitz wrote:
> -# We want to force 32-bit builds
> -CC=gcc -m32
> +# We want to force 64-bit builds
> +CC=gcc
>  HOSTCC=gcc
> -LD=ld -m elf32_sparc
> +LD=ld -m elf64_sparc

This breaks the native build on my Sun Ultra 5 with 32-bit userspace and GCC
defaulting to ultrasparc:

$ make
[...]
make[1]: Entering directory '/home/aaro/silo/first'
gcc -Os -Wall -I. -I../include -fomit-frame-pointer -fno-strict-aliasing -DSMALL_RELOC=0x280000 -DLARGE_RELOC=0x380000 -fno-stack-protector -c first.S -o first.o
ld -m elf64_sparc -N -Ttext 0x4000 -o first first.o
ld: sparc architecture of input file `first.o' is incompatible with sparc:v9 output
Makefile:39: recipe for target 'first' failed
make[1]: *** [first] Error 1
make[1]: Leaving directory '/home/aaro/silo/first'
Makefile:15: recipe for target 'all' failed
make: *** [all] Error 1

Also you broke the tilo build...

A.
