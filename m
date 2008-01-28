From: Takashi Iwai <tiwai@suse.de>
Date: Mon, 28 Jan 2008 11:55:09 +0000
Subject: Re: 2.6.24-rc8-mm1: old sparc64 bug
Message-Id: <s5hejc26u76.wl%tiwai@suse.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20080117023514.9df393cf.akpm@linux-foundation.org>
	<200801250104.34669.m.kozlowski@tuxland.pl>
	<s5hhch1j0ek.wl%tiwai@suse.de>
	<200801251934.35782.m.kozlowski@tuxland.pl>
In-Reply-To: <200801251934.35782.m.kozlowski@tuxland.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, David Miller <davem@davemloft.net>, perex@perex.cz

At Fri, 25 Jan 2008 19:34:35 +0100,
Mariusz Kozlowski wrote:
> 
> Hello,
> 
> > > 	I was digging through the gentoo bugzilla and found this:
> > > 
> > > http://bugs.gentoo.org/show_bug.cgi?id1823
> > > 
> > > As you see this bug is present since at least 2.6.17. I can reproduce
> > > that here on my hardware with 2.6.24-rc8-mm1. All you need to do is install
> > > mp3blaster on sparc64, run:
> > > 
> > > $ mp3blaster some_mp3_file.mp3 
> > > 
> > > and stop it by pressing ctrl-c. It oopses when you stop it. It doesn't happen
> > > every time but it'll oops in a few tries.
> > 
> > This looks similar like a bug I fixed ago.  Damn, it's still there.
> > 
> > Could you build with CONFIG_SND_DEBUG=y ?  It addas some sanity checks
> > and might catch the fatal condition.
> 
> Done. I don't think it changed much though :-/

OK, could you try the patch below?


thanks,

Takashi

---

diff -r edbe1b84179b sound/core/oss/pcm_oss.c
--- a/sound/core/oss/pcm_oss.c	Mon Jan 28 12:30:17 2008 +0100
+++ b/sound/core/oss/pcm_oss.c	Mon Jan 28 12:56:13 2008 +0100
@@ -1621,6 +1621,7 @@ static int snd_pcm_oss_sync(struct snd_p
 					snd_pcm_format_set_silence(runtime->format,
 								   runtime->oss.buffer,
 								   size1);
+					size1 /= runtime->channels; /* frames */
 					fs = snd_enter_user();
 					snd_pcm_lib_write(substream, (void __user *)runtime->oss.buffer, size1);
 					snd_leave_user(fs);
