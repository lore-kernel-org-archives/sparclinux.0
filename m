From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 18 May 2011 04:29:23 +0000
Subject: Re: SBus devices sometimes detected, sometimes not
Message-Id: <BANLkTikhKqcpdadpM3RQdYvDrPn46_v6_Q@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1105021259220.6200@math.ut.ee> <20110517.134312.226762699.davem@davemloft.net>
In-Reply-To: <20110517.134312.226762699.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: David Miller <davem@davemloft.net>
Cc: mroos@linux.ee, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, May 17, 2011 at 2:43 PM, David Miller <davem@davemloft.net> wrote:
> From: Meelis Roos <mroos@linux.ee>
> Date: Mon, 2 May 2011 13:39:46 +0300 (EEST)
>
>> This is 2.6.39-rc3..rc5 on Sun Ultra 1 with SBus hme card.
>> On about 50% of boots, hme is found fine and works. On other half boots
>> (not strictly in any order) SBus hme is not detected with this error:
>>
>> hme: probe of f006be34 failed with error -22
>>
>> grepping the logs, I sometimes also find similar errors about qlogicpti:
>>
>> qpti: probe of f00798c4 failed with error -22
>>
>> The node addresses are always the same for the device.
>>
>> 2.6.38 did not have this problem.
>
> Grant, I'm trying to diagnose this bug report which is a 2.6.39-rcX regre=
ssion
> and I think it's a side-effect of your changes to move away from
> of_platform_{,un}register_driver().
>
> Somehow an OF device driver's ->probe() is being called with a NULL
> "->of_match", that's why the probe returns -22 (-EINVAL) since in
> your transformations that is the first thing you check.
>
> There are only a few ways this can happen that I can tell, firstly
> the of_driver_match_device() call has to fail.
>
> It could then happen if pdrv->id_table is non-NULL, but in these two
> cases (drivers/net/sunhme.c:hme_sbus_driver and
> drivers/scsi/qlogicpti.c:qpti_sbus_driver) no id_table is assigned.
>
> The next possibility would be if pdrv->name matches the device's
> name, but in these two cases ("SUNW,hme" vs. "hme" and "QLGC,pti"
> vs. "qpti") that should not be the case either.

This is the failure case I was most concerned about when merging the
busses, but as you say the device naming convention is different for
OF-generated devices and therefore unlikely, and also easy to check
for.

> There is only one more way this could happen, and that is if the
> device bus pointer is NULL. =A0Because in that situation the
> match function doesn't get called and all devices can match.
>
> This is also very unlikely, because platform_device_add() always
> assigns pdev->dev.bus to &platform_bus_type before the device_add()
> call.

Actually, platform_device_add() doesn't get called for the of_device
case; mostly because there are still a couple of things that need to
be unified before platform_device_add() can replace of_device_add().
of_device_register() is called instead which doesn't set the bus
pointer.  However, both versions of scan_one_device() in arch/sparc do
explicitly set the bus pointer before adding the device, so this still
doesn't look like the issue, and if it was it doesn't explain the
intermittent nature of the problem.

> The fact that this failure happens only on some boots for Meelis leads
> me to belive that some datastructure is corrupted. =A0Perhaps there is
> an incorrect __init or __devinit somewhere, or we reference freed up
> data some other way.

I would agree that that is a likely scenario.

> Any ideas?

It would be good to know the exact failure mode, so we need to know if
of_driver_match_device() is setting of_match which is subsequently
getting cleared, or if of_driver_match_device() isn't getting called
at all.  Meelis, can you add something like the following code to
include/linux/of_device.h in the of_driver_match_device() function
between the of_match_device() call and the return statement:

if (dev->of_match)
        printk("found match; node=3D%s, driver=3D%s\n",
                 dev->of_node->full_name, drv->name);

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
