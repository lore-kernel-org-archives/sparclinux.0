From: Georg Chini <georg.chini@triaton-webhosting.com>
Date: Thu, 28 Dec 2006 21:27:12 +0000
Subject: Re: IRQ-problem with cs4231 alsa driver on SBUS
Message-Id: <459436B0.2090103@triaton-webhosting.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4593BC00.4010902@triaton-webhosting.com>
In-Reply-To: <4593BC00.4010902@triaton-webhosting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello,

Georg Chini wrote:

> With OSS it works fine for a while, but after exactly 99999 IRQ's
> from the cs4231 card I get the following kernel message:
>
>
I was wrong, the message appears after 100000 IRQ's, even if I
use different applications (mplayer, xmms, twinkle) and close
them in between. Mplayer and xmms use ALSA.
I changed the minimum period size in cs4231.c from 4096 to 256
bytes, but I verified that the problem occurs also with other
period sizes. I tested 256, 512 and 1024. With larger period sizes
it takes too long to wait for the error.

Regards
             Georg Chini
