From: Harvey Harrison <harvey.harrison@gmail.com>
Date: Tue, 06 Jan 2009 16:41:01 +0000
Subject: Re: [PATCH-2.6.28 final] byteorder: fix new headers for userspace
Message-Id: <1231260061.11902.40.camel@brick>
List-Id: <sparclinux.vger.kernel.org>
References: <4943DAD6.7070402@gentoo.org>
	 <20081216.011334.124918024.davem@davemloft.net>
	 <1229564779.6481.26.camel@brick>  <4963311B.6020502@redhat.com>
In-Reply-To: <4963311B.6020502@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, bluebird@gentoo.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>

On Tue, 2009-01-06 at 11:23 +0100, Gerd Hoffmann wrote:
> Harvey Harrison wrote:
> > glibc headers define both __LITTLE_ENDIAN and __BIG_ENDIAN
> > which was tripping the check in linux/byteorder.h.  Let's
> > just stay out of userspace's way and use __KERN_{endian}
> 
> Ping.  What is the status of this?
> 
> > Converted the arches in mainline that have already moved to the
> > new header, as the other arches merge the will need simlar
> > fixups.
> 
> In latest git powerpc, s390 and x86 are merged and need this fix too.
> 
> cheers,
>   Gerd

I was waiting for the cris, xtensa and parisc arches to merge as they
have conversion patches in their arch trees.  I'll send the patchset out
today with the proviso it shouldn't be applied until those three have
merged.

Cheers,

Harvey

