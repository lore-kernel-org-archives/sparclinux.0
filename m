From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 11 Mar 2010 21:22:37 +0000
Subject: Re: [PATCH 33/37] sound/soc: use .dev.of_node instead of .node in
Message-Id: <fa686aa41003111322wc1f15b2hd3f653af060f56bf@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20100311174830.4824.19820.stgit@angua> <20100311180649.4824.10368.stgit@angua>
	<20100311193458.GA13289@opensource.wolfsonmicro.com>
In-Reply-To: <20100311193458.GA13289@opensource.wolfsonmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: monstr@monstr.eu, gregkh@suse.de, benh@kernel.crashing.org, akpm@linux-foundation.org, davem@davemloft.net, sfr@canb.auug.org.au, jgarzik@pobox.com, ben-linux@fluff.org, dwmw2@infradead.org, jeremy.kerr@canonical.com, James.Bottomley@suse.de, microblaze-uclinux@itee.uq.edu.au, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, sparclinux@vger.kernel.org, linux-ide@vger.kernel.org, netdev@vger.kernel.org, linux-i2c@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-scsi@vger.kernel.org, alsa-devel@alsa-project.org, timur@freescale.com, lrg@slimlogic.co.uk

On Thu, Mar 11, 2010 at 12:34 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Thu, Mar 11, 2010 at 11:06:50AM -0700, Grant Likely wrote:
>> .node is being removed
>>
>> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
>
> but please ensure that Liam and especially Timur also check this (both
> CCed).
>
> For enormous patch serieses like this it's really nice if you can ensure
> that each person is only CCed on the patches that they need to review.
> Much less stuff in the inbox.

Yeah, sorry about that (and to everyone receiving this thread, I'm
really sorry.  I won't do it again).  I've already been yelled at for
that.  What happened is that on a previous series I was yelled at for
not sending all patches to everyone (so that the patches could be
reviewed in context).  So, naturally, I made sure to include everyone
on the whole series this time....  doh.

Next time I post I'll constrain it to small chunks.

Thanks for the review.

g.
