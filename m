From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 28 Apr 2009 03:59:39 +0000
Subject: Re: "leds: Add openfirmware platform device support" breaks sparc
Message-Id: <fa686aa40904272059q604d61c5u1fe584a2166545f1@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20090303160906.9b30b376.akpm@linux-foundation.org>
	<20090303192932.31705cf7@lappy.seanm.ca>
	<20090303.163713.131742043.davem@davemloft.net>
	<20090427152051.5067e888.akpm@linux-foundation.org>
In-Reply-To: <20090427152051.5067e888.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Simek <monstr@monstr.eu>, tpiepho@freescale.com, linuxppc-dev@ozlabs.org, rpurdie@linux.intel.com, smaclennan@pikatech.com, sparclinux@vger.kernel.org, David Miller <davem@davemloft.net>, John Williams <john.williams@petalogix.com>

On Mon, Apr 27, 2009 at 4:20 PM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Tue, 03 Mar 2009 16:37:13 -0800 (PST)
> David Miller <davem@davemloft.net> wrote:
>
>> From: Sean MacLennan <smaclennan@pikatech.com>
>> Date: Tue, 3 Mar 2009 19:29:32 -0500
>>
>> > It has been..... uhhhh carry the two... longer than I want to admit
>> > since I worked on a sparc. Would GPIO based LEDS make sense on a sparc
>> > platform? Is sparc used much in the embedded world?
>> >
>> > If yes, the of_register_platform_driver is just a nice wrapper. It
>> > would be trivial to either change it to work on sparc, or add the
>> > wrapper to the sparc includes.
>>
>> We generally create the platform devices by hand for LED
>> devices on sparc64.
>>
>> I'd CONFIG_POWERPC depend this thing for now.
>
> Nobody has done this, so current mainline's sparc64 allmodconfig remains
> busted.
>
>
> This?
>
> --- a/drivers/leds/Kconfig~a
> +++ a/drivers/leds/Kconfig
> @@ -139,6 +139,7 @@ config LEDS_GPIO_PLATFORM
> =A0config LEDS_GPIO_OF
> =A0 =A0 =A0 =A0bool "OpenFirmware platform device bindings for GPIO LEDs"
> =A0 =A0 =A0 =A0depends on LEDS_GPIO && OF_DEVICE
> + =A0 =A0 =A0 depends on POWERPC
> =A0 =A0 =A0 =A0default y
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0Let the leds-gpio driver drive LEDs which have been de=
fined as


PowerPC actually uses CONFIG_PPC, so this doesn't work.  However, this
might be better:  I've compile tested it on powerpc, but I don't have
microblaze or sparc xcompilers right now.  Also, probably word-wrapped
since I'm pasting it into my mailer, but I wanted to keep this within
the thread.  I'll repost "for real" first thing tomorrow morning.

g.

commit 302d02a46c67938cf4ef310fec90734cb38acabe
Author: Grant Likely <grant.likely@secretlab.ca>
Date:   Mon Apr 27 21:54:35 2009 -0600

    of: make of_(un)register_platform_driver common code.

    Some drivers using of_register_platform_driver() wrapper break on sparc
    because the wrapper isn't in the header file.  This patch moves it from
    Microblaze and PowerPC implementations and makes it common code.

    Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

diff --git a/arch/microblaze/include/asm/of_platform.h
b/arch/microblaze/include/asm/of_platform.h
index 187c0ee..3749127 100644
--- a/arch/microblaze/include/asm/of_platform.h
+++ b/arch/microblaze/include/asm/of_platform.h
@@ -36,16 +36,6 @@ static const struct of_device_id of_default_bus_ids[] =
=3D {
        {},
 };

-/* Platform drivers register/unregister */
-static inline int of_register_platform_driver(struct of_platform_driver *d=
rv)
-{
-       return of_register_driver(drv, &of_platform_bus_type);
-}
-static inline void of_unregister_platform_driver(struct
of_platform_driver *drv)
-{
-       of_unregister_driver(drv);
-}
-
 /* Platform devices and busses creation */
 extern struct of_device *of_platform_device_create(struct device_node *np,
                                                const char *bus_id,
diff --git a/arch/powerpc/include/asm/of_platform.h
b/arch/powerpc/include/asm/of_platform.h
index 53b4650..d4aaa34 100644
--- a/arch/powerpc/include/asm/of_platform.h
+++ b/arch/powerpc/include/asm/of_platform.h
@@ -11,16 +11,6 @@
  *
  */

-/* Platform drivers register/unregister */
-static inline int of_register_platform_driver(struct of_platform_driver *d=
rv)
-{
-       return of_register_driver(drv, &of_platform_bus_type);
-}
-static inline void of_unregister_platform_driver(struct
of_platform_driver *drv)
-{
-       of_unregister_driver(drv);
-}
-
 /* Platform devices and busses creation */
 extern struct of_device *of_platform_device_create(struct device_node *np,
                                                   const char *bus_id,
diff --git a/include/linux/of_platform.h b/include/linux/of_platform.h
index 3d327b6..9084066 100644
--- a/include/linux/of_platform.h
+++ b/include/linux/of_platform.h
@@ -51,6 +51,16 @@ extern int of_register_driver(struct of_platform_driver =
*drv,
                              struct bus_type *bus);
 extern void of_unregister_driver(struct of_platform_driver *drv);

+/* Platform drivers register/unregister */
+static inline int of_register_platform_driver(struct of_platform_driver *d=
rv)
+{
+       return of_register_driver(drv, &of_platform_bus_type);
+}
+static inline void of_unregister_platform_driver(struct
of_platform_driver *drv)
+{
+       of_unregister_driver(drv);
+}
+
 #include <asm/of_platform.h>

 extern struct of_device *of_find_device_by_node(struct device_node *np);


--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
