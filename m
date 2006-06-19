From: Jurij Smakov <jurij@wooyd.org>
Date: Mon, 19 Jun 2006 04:04:08 +0000
Subject: Re: [SILO PATCH]: Fix CDROM booting on sparc64
Message-Id: <Pine.LNX.4.63.0606182102570.3917@bobcat>
List-Id: <sparclinux.vger.kernel.org>
References: <20060618.190752.125899833.davem@davemloft.net>
In-Reply-To: <20060618.190752.125899833.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, 18 Jun 2006, David Miller wrote:

> It boots into the kernel, but something is wrong with the
> ramdisk image:
>
> RAMDISK: Compressed image found at block 0
> RAMDISK: incomplete write (-28 != 32768) 9437184
> VFS: Mounted root (ext2 filesystem).
> Attempt to access beyond end of device
> ram0: rw=0, want504, limit432
> Attempt to access beyond end of device
> ram0: rw=0, want504, limit432
> Warning: unable to open an initial console.

Yeah, default ramdisk size is too small, just type

install ramdisk_size 000

at the 'boot:' prompt, that should do the trick.

Best regards,

Jurij Smakov                                        jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                   KeyID: C99E03CC
