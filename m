From: "Robert P. J. Day" <rpjday@crashcourse.ca>
Date: Mon, 06 Jul 2009 09:40:11 +0000
Subject: is there still value to references to EXPORT_SYMTAB_STROPS?
Message-Id: <alpine.LFD.2.00.0907060537380.9183@localhost>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


  during one of my tree cleaning scans, i ran across the following:

$ grep -rw EXPORT_SYMTAB_STROPS *
arch/sparc/include/asm/string_64.h:#ifndef EXPORT_SYMTAB_STROPS
arch/sparc/include/asm/string_64.h:#endif /* !EXPORT_SYMTAB_STROPS */
arch/sparc/include/asm/string_32.h:#ifndef EXPORT_SYMTAB_STROPS
arch/sparc/include/asm/string_32.h:#endif /* !EXPORT_SYMTAB_STROPS */
arch/sparc/lib/ksyms.c:#define EXPORT_SYMTAB_STROPS
$

  given that EXPORT_SYMTAB was removed from the kernel tree quite some
time back, is this related macro still doing anything useful?  just
asking.

rday
--

====================================
Robert P. J. Day                               Waterloo, Ontario, CANADA

        Linux Consulting, Training and Annoying Kernel Pedantry.

Web page:                                          http://crashcourse.ca
Linked In:                             http://www.linkedin.com/in/rpjday
Twitter:                                       http://twitter.com/rpjday
====================================
