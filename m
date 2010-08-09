From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 09 Aug 2010 05:41:54 +0000
Subject: Re: [PATCH 2/3] sparc: make driver/of/pdt no longer sparc-specific
Message-Id: <AANLkTimDGP+2K7gswDsfUW0FjomfOBRfTKEqDV9-=zm6@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20100808231116.21c7d6f3@dev.queued.net>
	<AANLkTimG7u5eXWSn5VznKfuFcFD+evTzo1_QpAFmCdpL@mail.gmail.com>
	<20100809013245.1cefb9bf@dev.queued.net>
In-Reply-To: <20100809013245.1cefb9bf-ztAUm9HJea/EueBKFXcDjA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Andres Salomon <dilinger-pFFUokh25LWsTnJN9+BGXg@public.gmane.org>
Cc: sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Sun, Aug 8, 2010 at 11:32 PM, Andres Salomon <dilinger@queued.net> wrote:
> On Sun, 8 Aug 2010 23:12:21 -0600
> Grant Likely <grant.likely@secretlab.ca> wrote:
>
>> Hi Andres, thanks for the patch. =A0Comments below.
>>
>> g.
>>
>> On Sun, Aug 8, 2010 at 9:11 PM, Andres Salomon <dilinger@queued.net>
>> wrote:
> [...]
>> > +
>> > =A0unsigned int prom_early_allocated __initdata;
>> >
>> > -#include "../../../drivers/of/pdt.c"
>> > +static struct of_pdt_ops prom_sparc_ops __initdata =3D {
>> > + =A0 =A0 =A0 .firstprop =3D prom_common_firstprop,
>> > + =A0 =A0 =A0 .nextprop =3D prom_common_nextprop,
>> > + =A0 =A0 =A0 .getproplen =3D (int (*)(phandle, const char
>> > *))prom_getproplen,
>> > + =A0 =A0 =A0 .getproperty =3D (int (*)(phandle, const char *, char *,
>> > int))prom_getproperty,
>> > + =A0 =A0 =A0 .getchild =3D (phandle (*)(phandle))prom_getchild,
>> > + =A0 =A0 =A0 .getsibling =3D (phandle (*)(phandle))prom_getsibling,
>>
>> If you have to explicitly cast these function pointers, then you're
>> doing it wrong. =A0:-) =A0Listen to and fix the compiler complaint here.
>>
>
> Hm, can you please expand on that? =A0The reason it's necessary to cast is
> because sparc's prom_* functions are using ints instead of phandles. =A0I
> don't understand why casting is the wrong thing here.

because casting will mean the compiler can no longer catch errors when
someone accidentally assigns an incompatible function.

>> I can tell from the context here you're working from an older tree.
>> Please rebase onto Linus' current top-of-tree. =A0:-) =A0A bunch of OF
>> related patches have been merged for 2.6.36 that will conflict with
>> this patch.
>>
>
> Sorry, will do. =A0Was just looking for more feedback (while testing)
> before sending final versions of this stuff.

:-)

>>
>> > +
>> > +#if defined(CONFIG_SPARC)
>> > +static unsigned int prom_unique_id __initdata;
>> > +
>> > +#define inc_unique_id(p) do { \
>> > + =A0 =A0 =A0 (p)->unique_id =3D prom_unique_id++; \
>> > +} while (0)
>>
>> Use a static inline. =A0C code is preferred over preprocessor code.
>> Also preserver the namespace and use the of_pdt_ prefix (that goes for
>> all the new functions here in this file).
>
> This is processing multiple types, that's the reason for the macro.
>
> 'p' can be either a property struct, or device_node struct.

Ah, right.  I missed that.  A little ugly.  Personally I'd rather be
explicit and have a separate static inline for each usage.

> [...]
>> > - =A0 =A0 =A0 of_console_init();
>> > +void __init of_pdt_set_ops(struct of_pdt_ops *ops)
>> > +{
>> > + =A0 =A0 =A0 BUG_ON(!ops);
>> >
>> > - =A0 =A0 =A0 printk("PROM: Built device tree with %u bytes of memory.=
\n",
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0prom_early_allocated);
>> > + =A0 =A0 =A0 prom_ops =3D *ops;
>>
>> As mentioned above, why is the structure copied instead of just
>> storing the pointer.
>>
>
> Er, right, because originally the struct was handled differently. =A0No
> reason for it to be copied anymore.
>
> Thanks for the feedback!

np

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
