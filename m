From: "David S. Miller" <davem@redhat.com>
Date: Sat, 26 Jun 2004 23:17:49 +0000
Subject: Re: DMA_AUTOINIT missing in asm-sparc64/dma.h
Message-Id: <20040626161749.09ab9971.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1088244683.12842.45.camel@cid.outersquare.org>
In-Reply-To: <1088244683.12842.45.camel@cid.outersquare.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, 26 Jun 2004 15:22:58 -0700
Jeremy Huddleston <eradicator@gentoo.org> wrote:

> And an odd thing I've noticed with my es1371 (Ensoniq 5880 AudioPCI (rev
> 02)) card... I can use it through the OSS emulation layer, but I can't
> use alsa-specific applications with it... ie. I can use aumix/sox but
> not alsamixer/aplay.  I'm going to try updating alsa-{lib,utils} from
> 1.0.4 to 1.0.5 right now, but I don't think that's the problem...

Probably errors in the 32-bit compat layer.  I bet if you build the
alsa apps native 64-bit they work.


