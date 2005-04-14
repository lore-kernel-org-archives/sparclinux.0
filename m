From: Georg Chini <georg.chini@triaton-webhosting.com>
Date: Thu, 14 Apr 2005 21:15:54 +0000
Subject: cs4231 ALSA-driver on ultra1 - no sound
Message-Id: <425EDD8A.60607@triaton-webhosting.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello,

when I try to use the cs4231 driver on a ultra1 (sparc64) I get the following messages in
/var/log/messages:

Apr 14 19:45:09 ultra kernel: ALSA sound/sparc/cs4231.c:1349: cs4231: port = 000001ffdc000000, id = 0xa
Apr 14 19:45:09 ultra kernel: ALSA sound/sparc/cs4231.c:571: mce_down [000001ffdc000000] - auto calibration time out (0)
Apr 14 19:45:09 ultra kernel: ALSA sound/sparc/cs4231.c:577: mce_down [000001ffdc000000]: serious init problem - codec 
still busy
Apr 14 19:45:09 ultra kernel: ALSA sound/sparc/cs4231.c:443: out: auto calibration time out - reg = 0x0, value = 0x0
Apr 14 19:45:09 ultra kernel: ALSA sound/sparc/cs4231.c:443: out: auto calibration time out - reg = 0x1, value = 0x0
Apr 14 19:45:09 ultra kernel: ALSA sound/sparc/cs4231.c:443: out: auto calibration time out - reg = 0x2, value = 0x9f
Apr 14 19:45:09 ultra kernel: ALSA sound/sparc/cs4231.c:443: out: auto calibration time out - reg = 0x3, value = 0x9f
Apr 14 19:45:09 ultra kernel: ALSA sound/sparc/cs4231.c:443: out: auto calibration time out - reg = 0x4, value = 0x9f
Apr 14 19:45:09 ultra kernel: ALSA sound/sparc/cs4231.c:443: out: auto calibration time out - reg = 0x5, value = 0x9f
Apr 14 19:45:09 ultra kernel: ALSA sound/sparc/cs4231.c:443: out: auto calibration time out - reg = 0x6, value = 0xbf

I can use alsamixer to unmute everything but I get no sound. When I try

aplay /usr/local/mozilla/res/samples/test.wav

I get the following output:

Playing WAVE '/usr/local/mozilla/res/samples/test.wav' : Unsigned 8 bit, Rate 22050 Hz, Mono
aplay: pcm_write:1146: write error: Input/output error

/var/log/messages shows:

Apr 14 19:46:36 ultra kernel: ALSA sound/core/pcm_native.c:1424: playback drain error (DMA or IRQ trouble?)

/proc/interrupts shows 0 IRQ's for cs4231.

I tried kernel 2.6.11.7 and 2.6.12-rc2 with the same results.
If I increase all udelay's in cs4231.c by a factor of ten, the timeout messages vanish, but there is still no sound.

Any ideas?

Regards
        Georg Chini

