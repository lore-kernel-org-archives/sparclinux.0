From: David Miller <davem@davemloft.net>
Date: Mon, 19 Jun 2006 03:59:59 +0000
Subject: Re: [SILO PATCH]: Fix CDROM booting on sparc64
Message-Id: <20060618.205959.35468912.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20060618.190752.125899833.davem@davemloft.net>
In-Reply-To: <20060618.190752.125899833.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Sun, 18 Jun 2006 20:57:12 -0700 (PDT)

> From: Jurij Smakov <jurij@wooyd.org>
> Date: Sun, 18 Jun 2006 20:43:02 -0700 (PDT)
> 
> > http://www.wooyd.org/debian/silo/sparc-mini.iso
> > 
> > This directory also contains an updated Debian silo package.
> 
> This image boots on my SB1000 just fine, and that's the machine where
> I could reproduce the bug.

It boots into the kernel, but something is wrong with the
ramdisk image:

RAMDISK: Compressed image found at block 0
RAMDISK: incomplete write (-28 != 32768) 9437184
VFS: Mounted root (ext2 filesystem).
Attempt to access beyond end of device
ram0: rw=0, want504, limit432
Attempt to access beyond end of device
ram0: rw=0, want504, limit432
Warning: unable to open an initial console.
