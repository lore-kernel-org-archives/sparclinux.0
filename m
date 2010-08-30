From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 30 Aug 2010 17:31:44 +0000
Subject: Re: [PATCH 8/9] x86: of: irq additions to make drivers/of/* build on x86
Message-Id: <AANLkTiky2-Sr6+0+yyCuo3sVNYB6cxOuSHQkE9LbyynA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20100628215407.2017bf2f@debian> <20100829235100.6dcedcb8@debxo>
	<20100830000614.0d571f10@debxo>
	<c7823e09-3ce8-434f-98f4-6a84a996c942@SG2EHSMHS001.ehs.local>
In-Reply-To: <c7823e09-3ce8-434f-98f4-6a84a996c942-RaUQJvECHitZbvUCbuG1mrjjLBE8jN/0@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Stephen Neuendorffer <stephen.neuendorffer-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Cc: pgf-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mitch Bradley <wmb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Andres Salomon <dilinger-pFFUokh25LWsTnJN9+BGXg@public.gmane.org>, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org

On Mon, Aug 30, 2010 at 9:58 AM, Stephen Neuendorffer
<stephen.neuendorffer@xilinx.com> wrote:
>
>
>> -----Original Message-----
>> From: Andres Salomon [mailto:dilinger@queued.net]
>> Sent: Sunday, August 29, 2010 9:06 PM
>> To: devicetree-discuss@lists.ozlabs.org
>> Cc: sparclinux@vger.kernel.org; x86@kernel.org; tglx@linutronix.de;
> mingo@redhat.com; hpa@zytor.com;
>> cjb@laptop.org; Mitch Bradley; pgf@laptop.org;
> linux-kernel@vger.kernel.org; davem@davemloft.net;
>> grant.likely@secretlab.ca; Stephen Neuendorffer
>> Subject: [PATCH 8/9] x86: of: irq additions to make drivers/of/* build
> on x86
>>
>>
>> This functionality overlaps with patches previously submitted
>> by Stephen Neuendorffer. =A0I don't care whose eventually get applied,
>> so long as drivers/of/* becomes buildable on x86.
>>
>> Signed-off-by: Andres Salomon <dilinger@queued.net>
>
> Agreed..
> Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>

Okay, I've thought about this problem some more, and I think I've
decided how I want it solved.  Nack on this particular patch because
it adds NO_IRQ to arch/x86/kernel/irq.c (it has been nacked before).
Instead, I'd like the of irq code to be reworked a bit to make this
nicer and isolate the NO_IRQ definition only to the OF irq .c file
(when the arch doesn't explicitly define it).

Right now, there are two files in drivers/of referencing NO_IRQ;
drivers/of/platform.c and drivers/of/irq.c.  platform.c only
references in the context of figuring out how many irqs there are and
populating a resource table.  I'd like to remove that code from
platform.c and add a pair of helper functions to irq.c.  Then the top
of irq.c could conditionally #define NO_IRQ 0 and thereby prevent the
definition leaking out to the rest of the kernel.

Eventually I'll get around to doing this myself, but it would be
helpful to me if either you or Stephen could craft and test a patch.

Perhaps something like:

int of_irq_count(device_node *np)
{
        /* Count and return the number of IRQs. */
}

int of_irq_to_resource_table(device_node *np, struct resource *res, int max)
{
        for (i =3D 0; i < max; i++; res++)
                if (of_irq_to_resource(np, i, res) =3D NO_IRQ)
                        break;
        return i;
}

>> ---
>> @@ -275,6 +276,13 @@ void smp_x86_platform_ipi(struct pt_regs *regs)
>>
>> =A0EXPORT_SYMBOL_GPL(vector_used_by_percpu_irq);
>>
>> +unsigned int irq_create_of_mapping(struct device_node *controller,
>> + =A0 =A0 =A0 =A0 =A0 =A0 const u32 *intspec, unsigned int intsize)
>> +{
>> + =A0 =A0 return intspec[0] + 1;
>> +}
>> +EXPORT_SYMBOL_GPL(irq_create_of_mapping);
>> +

This simplistic implementation is of course non-ideal, but it works as
a stop-gap measure until I've got the irq infrastructure more mature.

g.
