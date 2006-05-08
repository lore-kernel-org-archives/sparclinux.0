From: "David S. Miller" <davem@davemloft.net>
Date: Mon, 08 May 2006 06:12:46 +0000
Subject: Re: sparc: cannot load any modules with 2.6.17-rc3
Message-Id: <20060507.231246.123026426.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20060505113514.GA28863@palantir8>
In-Reply-To: <20060505113514.GA28863@palantir8>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Sat, 6 May 2006 10:12:54 +0100

> I thought you were too busy with Niagara?

Well... do you see anyone else picking up the ball and even trying to
work on sparc 32-bit bugs? :-/

> I've put crc32.ko and crc32.o at http://www.mph.eclipse.co.uk/pub/linux/

Do these actually fail to load?  There are no R_SPARC_PC22 relocations
in the crc32.ko object.  I also checked crc32.o, same story.  Perhaps
another object has the problem, please provide it.

objdump --reloc crc32.ko

crc32.ko:     file format elf32-sparc

RELOCATION RECORDS FOR [.text]:
OFFSET   TYPE              VALUE 
00000044 R_SPARC_HI22      .rodata+0x00000400
00000050 R_SPARC_LO10      .rodata+0x00000400
00000194 R_SPARC_HI22      .rodata
0000019c R_SPARC_LO10      .rodata


RELOCATION RECORDS FOR [__ksymtab]:
OFFSET   TYPE              VALUE 
00000000 R_SPARC_32        bitreverse
00000004 R_SPARC_32        __ksymtab_strings
00000008 R_SPARC_32        crc32_be
0000000c R_SPARC_32        __ksymtab_strings+0x00000010
00000010 R_SPARC_32        crc32_le
00000014 R_SPARC_32        __ksymtab_strings+0x00000020


RELOCATION RECORDS FOR [.eh_frame]:
OFFSET   TYPE              VALUE 
00000018 R_SPARC_UA32      .text
00000028 R_SPARC_UA32      .text+0x0000017c
00000038 R_SPARC_UA32      .text+0x0000029c


