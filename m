From: Ben Collins <ben.collins@ubuntu.com>
Date: Tue, 03 Jan 2006 03:22:27 +0000
Subject: Re: SILO 1.4.10
Message-Id: <1136258547.27583.81.camel@grayson>
List-Id: <sparclinux.vger.kernel.org>
References: <1136175018.27583.50.camel@grayson>
In-Reply-To: <1136175018.27583.50.camel@grayson>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 2006-01-02 at 18:53 -0800, Jim Gifford wrote:
> Building 32bit on a multilib system. Here's a complete link to the 
> complete build log
> 
> http://ftp.jg555.com/silo_build.log

ld -N -Ttext 0x280000 -Bstatic -o second crt0.o
decomp.o ../common/console.o ../common/printf.o
malloc.o ../common/jmp.o ../common/prom.o ../common/tree.o ../common/urem.o ../common/udiv.o ../common/stringops1.o ../common/ffs.o ../common/divdi3.o ../common/udivdi3.o bmark.o main.o cmdline.o disk.o file.o misc.o cfg.o strtol.o ranges.o timer.o memory.o fs/libfs.a mul.o ../common/rem.o ../common/sdiv.o umul.o ../common/stringops2.o ls.o muldi3.o -lext2fs mark.o
ld: warning: sparc:v8plus architecture of input file `crt0.o' is incompatible with sparc:v9 output
ld: warning: sparc architecture of input file `decomp.o' is incompatible with sparc:v9 output
ld: warning: sparc architecture of input file `../common/console.o' is incompatible with sparc:v9 output

Your linker is defaulting to elf64_sparc. Edit Rules.make, and make LD=ld -m elf32_sparc
-- 
   Ben Collins <ben.collins@ubuntu.com>
   Developer
   Ubuntu Linux

