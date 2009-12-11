From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 11 Dec 2009 06:54:55 +0000
Subject: Re: [PATCH 07/11] of: merge machine_is_compatible()
Message-Id: <fa686aa40912102254u7cd53819q6550d7b2413d0121@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20091124081316.6216.66310.stgit@angua>
	<20091124081906.6216.67035.stgit@angua>
	<1259208310.16367.231.camel@pasglop>
In-Reply-To: <1259208310.16367.231.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Cc: sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org, microblaze-uclinux-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org

On Wed, Nov 25, 2009 at 9:05 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Tue, 2009-11-24 at 01:19 -0700, Grant Likely wrote:
>> Merge common code between PowerPC and Microblaze
>
> I don't like moving this one to common code without the of_ prefix. I
> think you should move it with the of_ prefix, and then add a alias in
> powerpc and microblaze without of_ in a header until we fix all call
> sites (which you can put on your to-do list :-)

I've written another patch to rename it.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
