From: "David S. Miller" <davem@redhat.com>
Date: Sat, 08 May 2004 00:22:45 +0000
Subject: Re: [PATCH] Use $(LD) -V for NEW_GAS check [4/4]
Message-Id: <20040507172245.207259cc.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040506224026.GD29131@triplehelix.org>
In-Reply-To: <20040506224026.GD29131@triplehelix.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, 7 May 2004 16:33:54 -0700
joshk@triplehelix.org (Joshua Kwan) wrote:

> On Fri, May 07, 2004 at 03:17:32PM -0700, David S. Miller wrote:
> > > This bug crept up because I have a bi-architecture (32/64) binutils, and
> > > unreasonable defaults sent my build to hell.
> > 
> > Applied, how did this ever work?  '-V' is what you need to use regardless
> > of how binutils was configured.
> 
> I have no idea. Isn't the bug in 2.6 as well?

I was about to ask you to make and test 2.6.x versions of
your fixed.
