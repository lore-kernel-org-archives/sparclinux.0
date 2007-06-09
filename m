From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date: Sat, 09 Jun 2007 19:47:59 +0000
Subject: Re: [2/3] 2.6.22-rc4: known regressions v2
Message-Id: <200706092147.59551.bzolnier@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <466ADBE4.5090707@googlemail.com> <466AE609.1030605@googlemail.com>
In-Reply-To: <466AE609.1030605@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@suse.cz>, Ben Collins <bcollins@ubuntu.com>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, Robert de Rooy <robert.de.rooy@gmail.com>, Gregor Jasny <gjasny@googlemail.com>, sparclinux@vger.kernel.org, David Miller <davem@davemloft.net>, Mark Lord <mlord@pobox.com>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>, Mikael Pettersson <mikpe@it.uu.se>

On Saturday 09 June 2007, Michal Piotrowski wrote:

> IDE
> 
> Subject    : libata and legacy ide pcmcia failure
> References : http://lkml.org/lkml/2007/5/17/305
> Submitter  : Robert de Rooy <robert.de.rooy@gmail.com>
> Handled-By : Mark Lord <mlord@pobox.com>
> Status     : problem is being debugged

Not a regression, this device has never worked with Linux.

Bart
