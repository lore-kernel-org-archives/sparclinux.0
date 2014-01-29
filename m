From: David Miller <davem@davemloft.net>
Date: Wed, 29 Jan 2014 08:01:11 +0000
Subject: Re: [PATCH v2 00/11] SILO/TILO/sun4u: support TFTP booting modern kernels
Message-Id: <20140129.000111.1291183073549526777.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Mon, 23 Dec 2013 21:43:22 +0200

> Linux 3.13 exposes some limitations on old UltraSPARCs where the PROM
> maps only 10 MB - the standard kernel TFTP boot no longer works very
> well... See e-mail thread <http://marc.info/?t8592472200001&r=1&w=2>.
> 
> This patch set makes some improvements to TILO to help on that. Basically
> it enables to boot a compressed kernel from dynamically allocated
> space. I'm now able to tftpboot a bloaty 3.13-rc5 + initramfs on Sun
> Ultra 5/10 with an image created by tilo.
> 
> The patch set also allows to cross-compile and run tilo e.g. on x86.

Great work, applied and pushed out to the silo GIT repo.

Thanks!
