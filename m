From: Georg Chini <georg.chini@triaton-webhosting.com>
Date: Wed, 03 Jan 2007 12:38:06 +0000
Subject: Re: Third Try: [PATCH] cs4231 alsa driver: Fix IRQ and initialisation
Message-Id: <459BA3AE.7070503@triaton-webhosting.com>
List-Id: <sparclinux.vger.kernel.org>
References: <459593A2.2000600@hp.com>
In-Reply-To: <459593A2.2000600@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


David Miller wrote:

>But it seems that nowadays the ISA CS4231 driver is using a value of
>"64" for period_bytes_min.  Perhaps the Sparc driver should do that
>too :-)
>
>
>  
>
My machine seems too slow to handle this. With values less
than 256 sound will not work properly. I think it starts missing
interrupts.

Regards
              Georg
