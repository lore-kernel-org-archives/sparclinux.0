From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Sun, 02 Dec 2012 16:50:04 +0000
Subject: SPARC kernel build (piggyback) fails with binutils 2.23.1
Message-Id: <20121202165004.GA3091@blackmetal.musicnaut.iki.fi>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

Kernel (3.7-rc7) build is failing with binutils 2.23.1, because _end is
no longer absolute for some reason and piggyback can't find it:

	$ tail -3 System.map
	000000000086bcb8 b net_header
	000000000086bcc0 B __bss_stop
	000000000086bcc0 B _end

	[...]

	  kernel: arch/sparc/boot/image is ready
	  HOSTCC  arch/sparc/boot/piggyback
	  ELFTOAOUT arch/sparc/boot/tftpboot.img
	PT 0 Entry: Loadable to 0x400000[0x46bcc0] from 0x0[0x40ed60] align 0x100000
	PT 1 Entry: Note
	PT 2 Entry: unknown
	  PIGGY   arch/sparc/boot/tftpboot.img
	Could not determine start and end from System.map
	make[6]: *** [arch/sparc/boot/tftpboot.img] Error 1

Is this a bug in binutils, or is the check in piggyback too strict?

With older binutils (2.22) the symbol is still "A":

	$ tail -3 System.map
	000000000086bcb8 b net_header
	000000000086bcc0 A __bss_stop
	000000000086bcc0 A _end

A.
