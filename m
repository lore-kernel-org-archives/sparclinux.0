From: Admar Schoonen <admar@luon.net>
Date: Sun, 21 Nov 2004 14:58:28 +0000
Subject: 2.6.10-rc2: no mach64 framebuffer (and possible ext3 fs corruption?)
Message-Id: <20041121145828.GA13642@zonne.luon.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi all

I just tried out 2.6.10-rc2 with pwc-10.0.4 patch from saillard.org and the alsa
patch that Sjoerd Simons recently posted to this list.

First observations:
1. blank screen
2. machine lockup when trying to use alsa
3. ext3 filesystem corruption

Some further details:
1. I have tested it on a sun blade 100 with 2 ati mach64 cards. In 2.6.9 I have
2 working framebuffers, but no working X (I guess X is to blame, but I need to
dig a little deeper before I can file a bug). In 2.6.10-rc2, both screens remain
black (monitor says 'no signal'). I haven't checked if X was running, but
otherwise, the machine works fine.

2. loading the snd-ioctl32 module and trying some alsa suff freezes the machine.
This looks the same as when Sjoerd's patch isn't applied, so perhaps I made an
error here. Right now I'm compiling 2.6.9 with Sjoerd's patch to try again.

3. when I booted back in 2.6.6 (for a working framebuffer and X) I noticed some
files were corrupted on the root filesystem (ext3). I don't know when this has
happened. The root fs is on a Seagate 120 GB ide disk, about 6 months old which
hasn't shown any sign of defects yet. Some files were illegal FIFO's, some
illegal block devs and some had a bad mode. I don't know how or when these
corruptions occured. Lately, I've tried kernels 2.6.6 (I use that one the most),
2.6.9{-rcX} and 2.6.10-rc2 all with several pathes for pwc, framebuffer and
alsa, but they shouldn't be related to filesystem or disk actions.

If you need more information on any of these issues, please let me know.

Admar Schoonen

PS: please CC any replies to me as I'm not on this list.
