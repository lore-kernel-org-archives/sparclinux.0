From: Marcel Holtmann <marcel@holtmann.org>
Date: Sat, 27 Mar 2004 10:43:09 +0000
Subject: Another compile problem on sparc64
Message-Id: <1080384189.2285.8.camel@pegasus>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

my compile problem with arch/sparc64/kernel/process.o is gone, but I get
another compile problem with the latest 2.6 Bitkeeper sources:

  CC      arch/sparc64/mm/init.o
arch/sparc64/mm/init.c: In function `check_pgt_cache':
arch/sparc64/mm/init.c:107: warning: use of cast expressions as lvalues is deprecated

My compiler is still the latest GCC from Debian Sid:

gcc (GCC) 3.3.3 (Debian 20040321)
Copyright (C) 2003 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

Regards

Marcel


