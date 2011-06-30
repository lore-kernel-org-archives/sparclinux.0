From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 30 Jun 2011 12:54:16 +0000
Subject: Re: SB16 build error.
Message-Id: <201106301454.16530.arnd@arndb.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20110630091754.GA12119@linux-mips.org> <s5hy60jwocc.wl%tiwai@suse.de> <20110630123212.GA6690@linux-mips.org>
In-Reply-To: <20110630123212.GA6690@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, florian@linux-mips.org, Florian Fainelli <florian@openwrt.org>, linux-arch@vger.kernel.org, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

On Thursday 30 June 2011, Ralf Baechle wrote:
> #define SNDRV_SB_CSP_IOCTL_LOAD_CODE                            \
>         _IOC(_IOC_WRITE,'H', 0x11, sizeof(struct snd_sb_csp_microcode))
> 
> error checking can be bypassed and all will be fine as long as the
> resulting value doesn't result in in a a duplicate case value - which it
> doesn't, at least not in my testing.
> 
> Should work but isn't nice.

Right. It's probably the best we can do. I think we added a few similar
definitions when we originally introduce _IOC_TYPECHECK. The idea was
never to break existing code, but rather to avoid merging new drivers that
use inconsistent ioctl command numbers.

	Arnd
