From: Michal Simek <monstr@monstr.eu>
Date: Wed, 07 Oct 2009 14:21:33 +0000
Subject: Re: [microblaze-uclinux] Re: [RFC PATCH 00/12] Merge common OpenFirmware
Message-Id: <4ACCA3ED.6090403@monstr.eu>
List-Id: <sparclinux.vger.kernel.org>
References: <20091007041007.16890.62194.stgit@angua>
	<fa686aa40910062149p5d7141e4x3ff849fd4d191f38@mail.gmail.com>
	<200910070209.59311.rob@landley.net>
	<fa686aa40910070702j470785d2ka2621122a8e2f1fd@mail.gmail.com>
In-Reply-To: <fa686aa40910070702j470785d2ka2621122a8e2f1fd-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: microblaze-uclinux-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org
Cc: Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org



Grant Likely wrote:
> On Wed, Oct 7, 2009 at 1:09 AM, Rob Landley <rob@landley.net> wrote:
>> On Tuesday 06 October 2009 23:49:04 Grant Likely wrote:
>>> However, I've completely devoted to this work for at least the next
>>> two months, so there are plenty more patches to follow.  Once I've
>>> got all the common code merged between Microblaze, PowerPC and Sparc
>>> I'll be fix the endian problems and making it easily usable by other
>>> architectures like ARM and MIPS.  Lots of work to be done.
>> Is there any news on getting QEMU to parse a device tree to figure out what
>> hardware to emulate?  (I.E. using the device tree code to let qemu provide
>> configurable board emulations instead of hardwiring them in C code?)
> 
> Not that I have, but I expect that I will be hacking on QEMU as part
> of this work.

ok great. Just let us know - we will test it.

Thanks,
Michal

> 
>> Also, what would be involved in getting x86 to (at least have the option to)
>> use the device tree stuff?
> 
> It would be very easy once the endian issues are worked out since the
> device tree is just a data format to be parsed.
> 
> g.
> 

-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel 2.6 Microblaze Linux - http://www.monstr.eu/fdt/
Microblaze U-BOOT custodian
