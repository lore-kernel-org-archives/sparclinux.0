From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Mon, 05 Feb 2007 13:56:06 +0000
Subject: [sparc32] Floppy support
Message-Id: <45C73776.2050605@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

	Hello,

	I'm testing 2.6.20 on Sparc32 SMP (SS20, 4*RT626). When I build floppy 
support in the kernel, boot stops after floppy innitialization (FDC 
is...). If I try to build a module for floppy support, the link stage of 
the build process hangs with "floppy hardint error". The last kernel 
that works is the 2.6.19.1. Any fix ?

	Regards,

	JKB
