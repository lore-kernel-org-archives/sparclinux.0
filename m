From: "Tomasz 'Furgas' Sawicki" <tomek@sawka.prv.pl>
Date: Fri, 04 Jun 2004 23:30:42 +0000
Subject: SunFire V240 and SILO
Message-Id: <opr83flgn6g7548t@polaris.student.put.poznan.pl>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi.

I've been trying to install Linux on SunFire V240 for a few days now.
Finally I've managed to boot from boot image via network.
I used Debian boot.img ( http://tinyurl.com/2rjp2 ). I've installed
base system via network too.

Unfortunately I'm not able to boot this installed system from
hard disc using SILO. I'm also almost sure that SILO was also
responsible for booting problems with few other Linux distribution
I've tried. Everytime boot process hangs after:
Remapping the kernel...done.
and before
Booting Linux...

Booting via network works perfectly ok, and booting the same
kernel from SILO always fails.

Using network boot I've managed to compile 2.4.26 (sparc64) kernel
and insert some prom_printf statements in various places between
"Remapping the kernel" and "Booting Linux...". Apparently booting
process hangs in cheetah_flush_dtlb_all() function which has
some assembler instructions. This function is called from
flush_tlb_all in arch/sparc64/mm/init.c

} else if (tlb_type = cheetah || tlb_type = cheetah_plus) {
     prom_printf("just before hang\n");
     cheetah_flush_dtlb_all();
     prom_printf("this will never show up\n");
     cheetah_flush_itlb_all();
}

SunFire v240 has Two 1-GHz UltraSPARC IIIi Cu Processors,
and 2 GB Memory.

Once again - booting via network works fine, only SILO fails.

I'd appreciate any help you can provide.

-- 
Tomasz 'Furgas' Sawicki
