From: Ralf Baechle <ralf@linux-mips.org>
Date: Thu, 30 Jun 2011 10:52:54 +0000
Subject: Re: SB16 build error.
Message-Id: <20110630105254.GA25732@linux-mips.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20110630091754.GA12119@linux-mips.org>
	<s5h8vsjy68z.wl%tiwai@suse.de>
In-Reply-To: <s5h8vsjy68z.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-arch@vger.kernel.org, linux-mips@linux-mips.org, alsa-devel@alsa-project.org, florian@linux-mips.org, "David S. Miller" <davem@davemloft.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-kernel@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, sparclinux@vger.kernel.org, Paul Mackerras <paulus@samba.org>, Matt Turner <mattst88@gmail.com>, Florian Fainelli <florian@openwrt.org>, Richard Henderson <rth@twiddle.net>

On Thu, Jun 30, 2011 at 12:15:56PM +0200, Takashi Iwai wrote:

> At Thu, 30 Jun 2011 10:17:54 +0100,
> Ralf Baechle wrote:
> > 
> > Found on a MIPS build but certain other architectures will have the same
> > issue:
> > 
> >   CC      sound/isa/sb/sb16_csp.o
> > sound/isa/sb/sb16_csp.c: In function ‘snd_sb_csp_ioctl’:
> > sound/isa/sb/sb16_csp.c:228: error: case label does not reduce to an integer constant
> > make[1]: *** [sound/isa/sb/sb16_csp.o] Error 1
> > make: *** [sound/isa/sb/sb16_csp.o] Error 2
> > 
> > This error message is caused by the _IOC_TYPECHECK() error check triggering
> > due to excessive ioctl size on Alpha, PowerPC, MIPS and SPARC which define
> > _IOC_SIZEBITS as 13.  On all other architectures define it as 14 so struct
> > snd_sb_csp_microcode with it's little over 12kB will just about fit into
> > the 16kB limit.
> 
> What about the patch below?

I have no idea how big the soundblaster microcode being loaded actually is,
that is if the reduced size of 0x1f00 will be sufficient.  Aside of that I
don't see a problem - I don't see how the old ioctl can possibly have been
used before so there isn't a compatibility problem.

Or you could entirely sidestep the problem and use request_firmware() but
I guess that's more effort than you want to invest.

> This is an old ISA driver, so the impact must be very low.

True.  I notice that sort of stuff in automated mass builds - not
necessarily the sort of kernels one would actually use.  Still build errors
are annoying :)

  Ralf
