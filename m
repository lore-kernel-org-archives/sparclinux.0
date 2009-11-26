From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 26 Nov 2009 04:02:02 +0000
Subject: Re: [PATCH 01/11] of/flattree: Merge early_init_dt_check_for_initrd()
Message-Id: <fa686aa40911252002w5d09bd8qc8170ba4f61345ae@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20091124081316.6216.66310.stgit@angua>
	<20091124081747.6216.88376.stgit@angua>
	<1259207478.16367.218.camel@pasglop>
In-Reply-To: <1259207478.16367.218.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Cc: sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org, microblaze-uclinux-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org

On Wed, Nov 25, 2009 at 8:51 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Tue, 2009-11-24 at 01:17 -0700, Grant Likely wrote:
>> Merge common code between PowerPC and Microblaze
>>
>> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>> Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>
>> Tested-by: Michal Simek <monstr@monstr.eu>
>
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>
> Remind me how you want to merge that ? via my tree ?

Since it is cross-arch, I'll ask Linus to pull directly.  We'll see if
that takes.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
