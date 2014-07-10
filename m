From: chase rayfield <cusbrar1@gmail.com>
Date: Thu, 10 Jul 2014 01:50:49 +0000
Subject: Re: SILO on Qemu Sparc v8 unable to boot stripped kernel
Message-Id: <CACwypyOoP6B7zkka7tHoA8eiZLcmWf-z5ZCsDUXJizw=QzT8Qw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CACwypyMhN9fj34VmgiXEFNmH28up5if3wW_xajYOLy0kR2An5Q@mail.gmail.com>
In-Reply-To: <CACwypyMhN9fj34VmgiXEFNmH28up5if3wW_xajYOLy0kR2An5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Sam, Sparc64 is merely what the default catalyst silo.conf happens to
have in it it is in
fact a 32bit silo running in qemu-system-sparc

I built silo with the patch from LFS... I was unable to build SILO
directly from davem's git.
Since I built the iso itself manually (I had to strip the kernel
manually) I also changed the
volume to indicate that it is a sparc32 ISO.

http://cross-lfs.org/view/git/sparc/final-system/silo.html

The following is with gcc 4.5.4 and binutils 2.21.1 I just doubled checked
the following results and that the LFS silo produces the same results
as in the screenshot.

Also if I just untar, patch with silo-1.4.14-fixes-3.patch and make it
fails with
o malloc.o
mallocl.o: In function `calloc':
malloc.c:(.text+0x48): undefined reference to `.umul'
make[1]: *** [b2.out] Error 1
make[1]: *** Waiting for unfinished jobs....
malloc.o: In function `calloc':
malloc.c:(.text+0x48): undefined reference to `.umul'

So I changed CC=gcc -m32 to CC=gcc -m32 -mcpu=v8. And it builds...
and will boot the older kernel I have but not the one I build/stripped myself.


If I attempt to build silo from git
ld -m elf32_sparc -N -Ttext 0x280000 -Bstatic -o silotftp crt0.o
decompnet.o ../common/console.o ../common/printf.o malloc.o
../common/jmp.o ../common/prom.o ../common/tree.o ../common/urem.o
../common/udiv.o ../common/stringops1.o ../common/ffs.o
../common/divdi3.o ../common/udivdi3.o bmark.o mainnet.o cmdline.o
disk.o file.o misc.o cfg.o strtol.o ranges.o timer.o memory.o
fs/libfs.a mul.o ../common/rem.o ../common/sdiv.o umul.o
../common/stringops2.o ls.o muldi3.o mark.o `gcc -m32
-print-libgcc-file-name`
decompnet.o: In function `error':
decomp.c:(.text+0x4f8): undefined reference to `__longjmp_chk'
file.o: In function `unget_gzip_input':
file.c:(.text+0x40): undefined reference to `__longjmp_chk'
file.o: In function `get_gzip_input':
file.c:(.text+0x180): undefined reference to `__longjmp_chk'
cfg.o: In function `cfg_error':
cfg.c:(.text+0x190): undefined reference to `__longjmp_chk'
make[1]: *** [silotftp] Error 1

Chase Rayfield
