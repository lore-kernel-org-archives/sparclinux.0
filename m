From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 09 Jul 2009 12:29:23 +0000
Subject: Re: [PATCH 2/5] sparc: use asm-generic/dma-mapping-common.h
Message-Id: <200907091429.24100.arnd@arndb.de>
List-Id: <sparclinux.vger.kernel.org>
References: <1246860820-20629-3-git-send-email-fujita.tomonori@lab.ntt.co.jp> <20090706.181131.92078657.davem@davemloft.net> <20090709185505X.fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <20090709185505X.fujita.tomonori@lab.ntt.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: davem@davemloft.net, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, reif@earthlink.net

On Thursday 09 July 2009, FUJITA Tomonori wrote:
> The logic to move flush_write_buffers() from dma-mapping-common.h to
> arch/x86/kernel/pci-nommu.c makes sense and it doesn't break anything.
> However, I'd like to see the confirmation from a person who added
> flush_write_buffers() long ago. I thought that we might overlook
> something subtle.

I've tried to find out where it comes from, but unfortunately it's
from prehistoric times (Linux-2.4.14.2), the commit is in=20

http://git.kernel.org/?p=3Dlinux/kernel/git/tglx/history.git;a=3Dcommitdiff=
;h=A8a2069f432c5597bdf9c83ab3045b9ef32ab5e3

None of the comments in that commit seem to refer to
the actual change.

	Arnd <><
