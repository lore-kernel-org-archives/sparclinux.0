From: Ralf Baechle <ralf@linux-mips.org>
Date: Thu, 30 Jun 2011 12:43:33 +0000
Subject: Re: SB16 build error.
Message-Id: <20110630124333.GA9727@linux-mips.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20110630091754.GA12119@linux-mips.org>
	<s5h8vsjy68z.wl%tiwai@suse.de>
	<20110630105254.GA25732@linux-mips.org>
	<s5h39iry3xp.wl%tiwai@suse.de> <s5hy60jwocc.wl%tiwai@suse.de>
	<20110630123212.GA6690@linux-mips.org>
	<s5hoc1fwl37.wl%tiwai@suse.de>
In-Reply-To: <s5hoc1fwl37.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-arch@vger.kernel.org, linux-mips@linux-mips.org, alsa-devel@alsa-project.org, florian@linux-mips.org, "David S. Miller" <davem@davemloft.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-kernel@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, sparclinux@vger.kernel.org, Paul Mackerras <paulus@samba.org>, Matt Turner <mattst88@gmail.com>, Florian Fainelli <florian@openwrt.org>, Richard Henderson <rth@twiddle.net>

On Thu, Jun 30, 2011 at 02:38:20PM +0200, Takashi Iwai wrote:

> > In userland an empty definition will be used for _IOC_TYPECHECK so there
> > won't be an error.  So userland already is already using the existing
> > value for SNDRV_SB_CSP_IOCTL_LOAD_CODE ...
> 
> Right.  It has an invalid direction (3), but apps won't care such
> details anyway.
> 
> > With a crude hack like
> > 
> > #define SNDRV_SB_CSP_IOCTL_LOAD_CODE				\
> > 	_IOC(_IOC_WRITE,'H', 0x11, sizeof(struct snd_sb_csp_microcode))
> > 
> > error checking can be bypassed and all will be fine as long as the
> > resulting value doesn't result in in a a duplicate case value - which it
> > doesn't, at least not in my testing.
> > 
> > Should work but isn't nice.
> 
> Indeed.  But which is uglier is hard to answer :)
> 
> If you are fine with the hacked ioctl number above, I can put it
> with some comments.  This won't break anything, at least.

Go ahead then and yes, this really deserves a comment.

  Ralf
