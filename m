From: Meelis Roos <mroos@linux.ee>
Date: Thu, 17 Feb 2005 08:14:21 +0000
Subject: ALSA cs4231 problem on SS5
Message-Id: <Pine.SOC.4.61.0502170850430.15129@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Well, I've decided to test my SS5 with Linux 2.6 in any way I can. 
Yesterday evening I tried ALSA sound and it does not seem to work. First 
it gives this error on startup:

ALSA sound/sparc/cs4231.c:577: mce_down [fd01d000]: serious init problem - codec still busy

Alsamixer works, aumix via oss mixer emu also seems to work. I turned 
all channels to max and unmuted everything but Mono out (tried with it 
on and off).

But play KDE_Startup.wav emits no sound. On my PC the specific file 
plays for 8.5s, on SS5 the play command from sox package takes 10.6s to 
finsh and exits normally then. At the beginning I hear a buzzing click 
from headphones and that's all. No sound from the internal speaker at 
all.

OSS driver in 2.4 works well so the hardware is probably OK.

/proc/interrupts shows
   9:          0    cs4231

/proc/io_map shows
fd01d000-fd01dfff: cs4231

/proc/openprom settings for SUNW,CS4231@4,c000000:
device_type	'serial'
intr		00000039.00000000
name		'SUNW,CS4231'
reg		00000004.0c000000.00000040

-- 
Meelis Roos (mroos@linux.ee)
