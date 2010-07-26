From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 26 Jul 2010 22:42:20 +0000
Subject: Re: [PATCH v3] of: Create asm-generic/of.h and provide default
Message-Id: <AANLkTikcV3jJUm_My-oK-drudSDz3M2iH1cWhxdt+W1s@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20100726220405.1550.63442.stgit@angua> <20100726222627.GA23501@merkur.ravnborg.org>
In-Reply-To: <20100726222627.GA23501@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Sam Ravnborg <sam@ravnborg.org>
Cc: sfr@canb.auug.org.au, monstr@monstr.eu, microblaze-uclinux@itee.uq.edu.au, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, benh@kernel.crashing.org, sparclinux@vger.kernel.org, davem@davemloft.net

On Mon, Jul 26, 2010 at 4:26 PM, Sam Ravnborg <sam@ravnborg.org> wrote:
> On Mon, Jul 26, 2010 at 04:04:55PM -0600, Grant Likely wrote:
>> of_node_to_nid() is only relevant in a few architectures. =A0Don't force
>> everyone to implement it anyway. =A0This patch also adds asm-generic/of.h
>> which will be used to contain other overrideable symbols.
>>
>> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>> ---
>>
>> Changes in v3: don't use asm-generic, just keep macros in of.h
>> Changes in v2: address comments from sfr, add asm-generic/of.h
>
> The use of asm-generic makes perfect sense.
> This is how we usually deal with arch specific stuff.
>
> With v3 of your patch we have a different result depending
> on if we do:
> #include <linux/of.h>
>
> or we do:
> #include <asm/prom.h>
>
> This is undesireable.

The patch does maintain consistency.  Including only asm/prom.h may
mean that of_node_to_nid is undefined, but it will never result in a
different definition.  linux/of.h includes asm/prom.h before doing the
#ifdef test.

> I suggest to go back to v2 of your patch where you use asm-generic/of.h.

Stephen suggested dropping asm-generic/of.h.  I'm happy to do it either way.

> linux/of.h shall include asm/of.h
> Then all archs shall have a of.h that may
> include the asm-generic variant.
>
>
> One patch to introduce of.h all over.
> And a second patch to do the of_node_to_nid stuff would be appropriate.
>
>
>> diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/=
prom.h
>> index da7dd63..dca25a5 100644
>> --- a/arch/powerpc/include/asm/prom.h
>> +++ b/arch/powerpc/include/asm/prom.h
>> @@ -103,6 +103,11 @@ struct device_node *of_find_next_cache_node(struct =
device_node *np);
>> =A0/* Get the MAC address */
>> =A0extern const void *of_get_mac_address(struct device_node *np);
>>
>
> This shall go in asm/of.h
>> +#ifdef CONFIG_NUMA
>> +extern int of_node_to_nid(struct device_node *device);
>> +#define of_node_to_nid of_node_to_nid
>
> This define is used to tell asm-generic/of.h that the arch has
> a local definition - OK.
>
>> +#endif
>> +
>> =A0/**
>> =A0 * of_irq_map_pci - Resolve the interrupt for a PCI device
>> =A0 * @pdev: =A0 =A0the device whose interrupt is to be resolved
>
>> diff --git a/include/linux/of.h b/include/linux/of.h
>> index b0756f3..cc936ca 100644
>> --- a/include/linux/of.h
>> +++ b/include/linux/of.h
>> @@ -146,6 +146,11 @@ static inline unsigned long of_read_ulong(const __b=
e32 *cell, int size)
>>
>> =A0#define OF_BAD_ADDR =A0((u64)-1)
>>
>> +#ifndef of_node_to_nid
>> +static inline int of_node_to_nid(struct device_node *np) { return 0; }
>> +#define of_node_to_nid of_node_to_nid
>
> But I fail to see the purpose of this define.

It protects against some later include file doing a #define
of_node_to_nid and thus resulting in an inconsistent definition.  If
some code tries to do this then the preprocessor will complain.  This
is the pattern that Stephen suggested.

g.
