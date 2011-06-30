From: Ralf Baechle <ralf@linux-mips.org>
Date: Thu, 30 Jun 2011 09:17:54 +0000
Subject: SB16 build error.
Message-Id: <20110630091754.GA12119@linux-mips.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: linux-arch@vger.kernel.org, linux-mips@linux-mips.org, alsa-devel@alsa-project.org, florian@linux-mips.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, sparclinux@vger.kernel.org, Paul Mackerras <paulus@samba.org>, Matt Turner <mattst88@gmail.com>, Florian Fainelli <florian@openwrt.org>, Richard Henderson <rth@twiddle.net>

Found on a MIPS build but certain other architectures will have the same
issue:

  CC      sound/isa/sb/sb16_csp.o
sound/isa/sb/sb16_csp.c: In function ‘snd_sb_csp_ioctl’:
sound/isa/sb/sb16_csp.c:228: error: case label does not reduce to an integer constant
make[1]: *** [sound/isa/sb/sb16_csp.o] Error 1
make: *** [sound/isa/sb/sb16_csp.o] Error 2

This error message is caused by the _IOC_TYPECHECK() error check triggering
due to excessive ioctl size on Alpha, PowerPC, MIPS and SPARC which define
_IOC_SIZEBITS as 13.  On all other architectures define it as 14 so struct
snd_sb_csp_microcode with it's little over 12kB will just about fit into
the 16kB limit.

  Ralf
