From: "David S. Miller" <davem@redhat.com>
Date: Sat, 26 Jun 2004 21:37:00 +0000
Subject: Re: DMA_AUTOINIT missing in asm-sparc64/dma.h
Message-Id: <20040626143700.47fecbe6.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1088244683.12842.45.camel@cid.outersquare.org>
In-Reply-To: <1088244683.12842.45.camel@cid.outersquare.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, 26 Jun 2004 12:17:37 -0700
Jeremy Huddleston <eradicator@gentoo.org> wrote:

> > Which card are you enabling in the build?
> 
> dmabuf.o (which has the reference to DMA_AUTOINIT) is compiled
> regardless of which oss modules you select.  I caught this with just
> emu10k1, es1370, and es1371 selected under OSS.

There are perfectly compilable ALSA drivers for these cards,
why not use those?

Yes, the OSS layer does a lot of PC-centric stuff, better to
stick with the ALSA drivers as I do watch over them for
portability when changes are made.
