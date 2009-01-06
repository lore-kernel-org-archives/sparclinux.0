From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 06 Jan 2009 10:23:23 +0000
Subject: Re: [PATCH-2.6.28 final] byteorder: fix new headers for userspace
Message-Id: <4963311B.6020502@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4943DAD6.7070402@gentoo.org>	 <20081216.011334.124918024.davem@davemloft.net> <1229564779.6481.26.camel@brick>
In-Reply-To: <1229564779.6481.26.camel@brick>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, bluebird@gentoo.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>

Harvey Harrison wrote:
> glibc headers define both __LITTLE_ENDIAN and __BIG_ENDIAN
> which was tripping the check in linux/byteorder.h.  Let's
> just stay out of userspace's way and use __KERN_{endian}

Ping.  What is the status of this?

> Converted the arches in mainline that have already moved to the
> new header, as the other arches merge the will need simlar
> fixups.

In latest git powerpc, s390 and x86 are merged and need this fix too.

cheers,
  Gerd
