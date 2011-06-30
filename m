From: Takashi Iwai <tiwai@suse.de>
Date: Thu, 30 Jun 2011 13:14:23 +0000
Subject: Re: SB16 build error.
Message-Id: <s5hiprnwjf4.wl%tiwai@suse.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20110630091754.GA12119@linux-mips.org>
	<s5h8vsjy68z.wl%tiwai@suse.de>
	<20110630105254.GA25732@linux-mips.org>
	<s5h39iry3xp.wl%tiwai@suse.de> <s5hy60jwocc.wl%tiwai@suse.de>
	<20110630123212.GA6690@linux-mips.org>
	<s5hoc1fwl37.wl%tiwai@suse.de>
	<20110630124333.GA9727@linux-mips.org>
In-Reply-To: <20110630124333.GA9727@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-arch@vger.kernel.org, linux-mips@linux-mips.org, alsa-devel@alsa-project.org, florian@linux-mips.org, "David S. Miller" <davem@davemloft.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-kernel@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, sparclinux@vger.kernel.org, Paul Mackerras <paulus@samba.org>, Matt Turner <mattst88@gmail.com>, Florian Fainelli <florian@openwrt.org>, Richard Henderson <rth@twiddle.net>

At Thu, 30 Jun 2011 13:43:33 +0100,
Ralf Baechle wrote:
> 
> On Thu, Jun 30, 2011 at 02:38:20PM +0200, Takashi Iwai wrote:
> 
> > > In userland an empty definition will be used for _IOC_TYPECHECK so there
> > > won't be an error.  So userland already is already using the existing
> > > value for SNDRV_SB_CSP_IOCTL_LOAD_CODE ...
> > 
> > Right.  It has an invalid direction (3), but apps won't care such
> > details anyway.
> > 
> > > With a crude hack like
> > > 
> > > #define SNDRV_SB_CSP_IOCTL_LOAD_CODE				\
> > > 	_IOC(_IOC_WRITE,'H', 0x11, sizeof(struct snd_sb_csp_microcode))
> > > 
> > > error checking can be bypassed and all will be fine as long as the
> > > resulting value doesn't result in in a a duplicate case value - which it
> > > doesn't, at least not in my testing.
> > > 
> > > Should work but isn't nice.
> > 
> > Indeed.  But which is uglier is hard to answer :)
> > 
> > If you are fine with the hacked ioctl number above, I can put it
> > with some comments.  This won't break anything, at least.
> 
> Go ahead then and yes, this really deserves a comment.

OK, here is the patch.


Takashi

=From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: sb16 - Fix build errors on MIPS and others with 13bit
 ioctl size

One of ioctl definition in sound/sb16_csp.h contains the data size
over 8kB, and this causes build errors on architectures like MIPS,
which define _IOC_SIZEBITS.

For avoiding this build errors but keeping the compatibility, manually
exapnd with _IOC() instead of using _IOW() for the problematic ioctl.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/sb16_csp.h |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/include/sound/sb16_csp.h b/include/sound/sb16_csp.h
index 736eac7..af1b49e 100644
--- a/include/sound/sb16_csp.h
+++ b/include/sound/sb16_csp.h
@@ -99,7 +99,14 @@ struct snd_sb_csp_info {
 /* get CSP information */
 #define SNDRV_SB_CSP_IOCTL_INFO		_IOR('H', 0x10, struct snd_sb_csp_info)
 /* load microcode to CSP */
-#define SNDRV_SB_CSP_IOCTL_LOAD_CODE	_IOW('H', 0x11, struct snd_sb_csp_microcode)
+/* NOTE: struct snd_sb_csp_microcode overflows the max size (13 bits)
+ * defined for some architectures like MIPS, and it leads to build errors.
+ * (x86 and co have 14-bit size, thus it's valid, though.)
+ * As a workaround for skipping the size-limit check, here we don't use the
+ * normal _IOW() macro but _IOC() with the manual argument.
+ */
+#define SNDRV_SB_CSP_IOCTL_LOAD_CODE	\
+	_IOC(_IOC_WRITE, 'H', 0x11, sizeof(struct snd_sb_csp_microcode))
 /* unload microcode from CSP */
 #define SNDRV_SB_CSP_IOCTL_UNLOAD_CODE	_IO('H', 0x12)
 /* start CSP */
-- 
1.7.6

