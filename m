From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 06 Jul 2010 22:06:54 +0000
Subject: Re: [PATCH 2/4] sparc: break out some prom device-tree building code
Message-Id: <AANLkTilt0cdnCt5EI3adWNAxpNR4jmLL87sMpGVXP03Y@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20100628215407.2017bf2f@debian> <20100628220037.5744c207@debian>
	<AANLkTikDdAuDOxBVgV_QDY-YZOOZCyl1O5aYzDXCjW10@mail.gmail.com>
	<20100706145446.5e8540aa@Nokia-N900-42-11>
In-Reply-To: <20100706145446.5e8540aa@Nokia-N900-42-11>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Andres Salomon <dilinger-pFFUokh25LWsTnJN9+BGXg@public.gmane.org>
Cc: pgf-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mitch Bradley <wmb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org

On Tue, Jul 6, 2010 at 3:54 PM, Andres Salomon <dilinger@queued.net> wrote:
> On Tue, 6 Jul 2010 03:21:21 -0600
> Grant Likely <grant.likely@secretlab.ca> wrote:
>
>> On Mon, Jun 28, 2010 at 8:00 PM, Andres Salomon <dilinger@queued.net>
>> wrote:
>> >
>> > Stick code into drivers/of/pdt.c (Prom Device Tree) that other
>> > architectures with OpenFirmware resident in memory can make use of.
>> >
>> > Signed-off-by: Andres Salomon <dilinger@queued.net>
>>
>> Some more comments below...
>>
>
> Thanks for the review!
>
>
>
>> > =A0arch/sparc/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A01 +
>> > =A0arch/sparc/include/asm/prom.h =A0 | =A0 15 +++-
>> > =A0arch/sparc/kernel/prom.h =A0 =A0 =A0 =A0| =A0 14 ---
>> > =A0arch/sparc/kernel/prom_common.c | =A0173
>> > +------------------------------ drivers/of/Kconfig =A0 =A0 =A0 =A0 =A0=
 =A0 =A0|
>> > =A04 + drivers/of/Makefile =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A01 +
>> > =A0drivers/of/pdt.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0225
>> > +++++++++++++++++++++++++++++++++++++++ include/linux/of_pdt.h
>> > =A0 =A0 =A0| =A0 37 +++++++ 8 files changed, 282 insertions(+), 188
>> > deletions(-) create mode 100644 drivers/of/pdt.c
>> > =A0create mode 100644 include/linux/of_pdt.h
>> >
>> > diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
>> > index 6f1470b..b4cb63b 100644
>> > --- a/arch/sparc/Kconfig
>> > +++ b/arch/sparc/Kconfig
>> > @@ -150,6 +150,7 @@ config ARCH_NO_VIRT_TO_BUS
>> >
>> > =A0config OF
>> > =A0 =A0 =A0 =A0def_bool y
>> > + =A0 =A0 =A0 select OF_PROMTREE
>> >
>> > =A0config ARCH_SUPPORTS_DEBUG_PAGEALLOC
>> > =A0 =A0 =A0 =A0def_bool y if SPARC64
>> > diff --git a/arch/sparc/include/asm/prom.h
>> > b/arch/sparc/include/asm/prom.h index f845828..0834c2a 100644
>> > --- a/arch/sparc/include/asm/prom.h
>> > +++ b/arch/sparc/include/asm/prom.h
>> > @@ -18,6 +18,7 @@
>> > =A0* 2 of the License, or (at your option) any later version.
>> > =A0*/
>> > =A0#include <linux/types.h>
>> > +#include <linux/of_pdt.h>
>> > =A0#include <linux/proc_fs.h>
>> > =A0#include <linux/mutex.h>
>> > =A0#include <asm/atomic.h>
>> > @@ -65,8 +66,18 @@ extern struct device_node *of_console_device;
>> > =A0extern char *of_console_path;
>> > =A0extern char *of_console_options;
>> >
>> > -extern void (*prom_build_more)(struct device_node *dp, struct
>> > device_node ***nextp); -extern char *build_full_name(struct
>> > device_node *dp); +/* stuff used by of/pdt */
>> > +extern void * prom_early_alloc(unsigned long size);
>> > +extern void irq_trans_init(struct device_node *dp);
>> > +extern char *build_path_component(struct device_node *dp);
>> > +
>> > +extern char *prom_firstprop(int node, char *buffer);
>> > +extern char *prom_nextprop(int node, const char *oprop, char
>> > *buffer); +extern int prom_getproplen(int node, const char *prop);
>> > +extern int prom_getproperty(int node, const char *prop,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 char *buffer, in=
t bufsize);
>> > +extern int prom_getchild(int node);
>> > +extern int prom_getsibling(int node);
>>
>> These become the API required by of/pdt. =A0They should be defined in a
>> arch-independent header file. =A0Something like include/linux/of_pdt.h
>>
>> Right now only OLPC will be using this, so static function definitions
>> are just fine. =A0However, if there is ever more than one method for
>> talking to OFW, then these hooks will need to be converted into an ops
>> structure so the right one can be passed in at runtime.
>>
>
> Note that sparc and OLPC actually use slightly different function
> signatures; OLPC uses phandles for nodes, while sparc uses ints. =A0Not a
> huge difference, but enough that I didn't want to mess w/ a generic
> version of it early in the process.

phandle is simply defined as a u32.  It probably wouldn't be difficult
to change the sparc code to use phandle; redefining the type for sparc
if need be.

> =A0I agree that op structs would be
> nicer, and will probably move towards that.
>
> [...]
>
>> > diff --git a/include/linux/of_pdt.h b/include/linux/of_pdt.h
>> > new file mode 100644
>> > index 0000000..f62616e
>> > --- /dev/null
>> > +++ b/include/linux/of_pdt.h
>> > @@ -0,0 +1,37 @@
>> > +#include <linux/of.h> =A0/* linux/of.h gets to determine #include
>> > ordering */
>>
>> Do you really need this #include in this way? =A0Can it be moved inside
>> the #ifndef OF_PDT block below?
>>
>
> Not sure, will try out different variants and see what breaks.
>
> [...]
>
>> Another general comment, I'm still not thrilled with this code having
>> its own independent method for building the tree, but I doubt the
>> existing add/remove nodes and properties code is usable early enough
>> to be suitable for sparc. =A0How early do you extract the device tree on
>> OLPC? =A0How are you going to use the data?
>
> Not that early; very early code fetches information necessary to call
> into the PROM, and ensures that the kernel doesn't clobber OFW's
> memory. =A0 After that, we can build the dt at any point during init.
> The data is to be exported via proc for userspace to use in
> determining hardware (and firmware) info.

Okay, so it is only the userspace interface that you're interested in,
correct?  You have no needs/plans (as of yet) to register devices out
of the device tree?

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
