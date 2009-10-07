From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 07 Oct 2009 13:38:27 +0000
Subject: Re: [microblaze-uclinux] Re: [RFC PATCH 05/12] of: add common header
Message-Id: <fa686aa40910070638v16c1b811w4e5ecb61a9afd836@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20091007041007.16890.62194.stgit@angua>
	<20091007043052.16890.15975.stgit@angua>
	<20091007155717.8df62c4d.sfr@canb.auug.org.au>
	<4ACC861A.7020506@monstr.eu>
In-Reply-To: <4ACC861A.7020506-pSz03upnqPeHXe+LvDLADg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org
Cc: microblaze-uclinux-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org

On Wed, Oct 7, 2009 at 6:14 AM, Michal Simek <monstr@monstr.eu> wrote:
>
>
> Stephen Rothwell wrote:
>> Hi Grant,
>>
>> Just first obvious thing:
>>
>> On Tue, 06 Oct 2009 22:30:59 -0600 Grant Likely <grant.likely@secretlab.=
ca> wrote:
>>> diff --git a/arch/microblaze/include/asm/prom.h b/arch/microblaze/inclu=
de/asm/prom.h
>>> index 64e8b3a..5f461f0 100644
>>> --- a/arch/microblaze/include/asm/prom.h
>>> +++ b/arch/microblaze/include/asm/prom.h
>>> @@ -17,20 +17,10 @@
>>> =A0#ifndef _ASM_MICROBLAZE_PROM_H
>>> =A0#define _ASM_MICROBLAZE_PROM_H
>>> =A0#ifdef __KERNEL__
>>> -
>>> -/* Definitions used by the flattened device tree */
>>> -#define OF_DT_HEADER =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00xd00dfeed /* mark=
er */
>>
>> This is used in arch/microblaze/kernel/head.S, but you move its
>> definition inside "#ifndef __ASSEMBLY__" below. =A0You should probably
>> replace the include of asm/prom.h in arch/microblaze/kernel/head.S with
>> linux/of_fdt.h (assuming that the comment in there is correct).
>
> yes, Stephen is right here. I created one patch (in attachment) which fix=
ed it. I tested your
> patches on Microblaze (noMMU and MMU) and I have no problem with compilat=
ion and simple boot-up
> works for both versions too.
>
> With that my patch: Acked-by: Michal Simek <monstr@monstr.eu>

Thanks.  I'll merge your change with my patch so that bisect isn't broken.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
