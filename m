From: Marcel Holtmann <marcel@holtmann.org>
Date: Thu, 25 Mar 2004 23:25:54 +0000
Subject: Re: Compile problem on sparc64
Message-Id: <1080257154.2283.24.camel@pegasus>
List-Id: <sparclinux.vger.kernel.org>
References: <20040324121914.00fb9bf9.davem@redhat.com>
In-Reply-To: <20040324121914.00fb9bf9.davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Dave,

> Marcel, I think you're using gcc-3.5, because gcc-3.3.x does not
> even warn for these things at all, else I'd be seeing this for
> ages.
> 
> Can you double check what "gcc --version" gives?

actually it is the default gcc from Debian Sid and it looks like the
3.3.x version.

gcc (GCC) 3.3.3 (Debian 20040321)
Copyright (C) 2003 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

This is only an Ultra5, so compiling takes some time and for fixing big
endian and 64-bit bugs in the Bluetooth subsystem I made use of ccache.

ccache version 2.3
Copyright Andrew Tridgell 2002
Released under the GNU GPL v2 or later

And this is my only important modification to the kernel source

--- 1.468/Makefile      Sun Mar 21 09:00:57 2004
+++ edited/Makefile     Sun Mar 21 20:12:07 2004
@@ -160,7 +160,7 @@
          else if [ -x /bin/bash ]; then echo /bin/bash; \
          else echo sh; fi ; fi)
 
-HOSTCC         = gcc
+HOSTCC         = sparc32 gcc
 HOSTCXX        = g++
 HOSTCFLAGS     = -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer
 HOSTCXXFLAGS   = -O2

Regards

Marcel


