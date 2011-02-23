From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 23 Feb 2011 17:22:33 +0000
Subject: Re: [RFC PATCH 14/15] dt: Eliminate of_platform_{,un}register_driver
Message-Id: <AANLkTimp0moaqnRfn8hp_TQJxdh7G8ODG_SkwO_hz8kE@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20110223043015.20795.37090.stgit@localhost6.localdomain6>
 <20110223043447.20795.80653.stgit@localhost6.localdomain6> <4D653C48.4090608@gmail.com>
In-Reply-To: <4D653C48.4090608@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Rob Herring <robherring2@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, devicetree-discuss@lists.ozlabs.org, sfr@canb.auug.org.au, linux-kernel@vger.kernel.org, davem@davemloft.net, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

On Wed, Feb 23, 2011 at 9:56 AM, Rob Herring <robherring2@gmail.com> wrote:
> Grant,
>
> On 02/22/2011 10:34 PM, Grant Likely wrote:
>>
>> Final step to eliminate of_platform_bus_type. =A0They're all just
>> platform drivers now.
>>
>> Signed-off-by: Grant Likely<grant.likely@secretlab.ca>
>> ---
>
> snip
>
>> diff --git a/drivers/char/ipmi/ipmi_si_intf.c
>> b/drivers/char/ipmi/ipmi_si_intf.c
>> index b6ae6e9..132951d 100644
>> --- a/drivers/char/ipmi/ipmi_si_intf.c
>> +++ b/drivers/char/ipmi/ipmi_si_intf.c
>> @@ -2556,8 +2556,7 @@ static struct pci_driver ipmi_pci_driver =3D {
>>
>>
>> =A0#ifdef CONFIG_PPC_OF
>> -static int __devinit ipmi_of_probe(struct platform_device *dev,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const struct of_device_=
id *match)
>> +static int __devinit ipmi_of_probe(struct platform_device *dev)
>> =A0{
>> =A0 =A0 =A0 =A0struct smi_info *info;
>> =A0 =A0 =A0 =A0struct resource resource;
>> @@ -2568,6 +2567,9 @@ static int __devinit ipmi_of_probe(struct
>> platform_device *dev,
>>
>> =A0 =A0 =A0 =A0dev_info(&dev->dev, "probing via device tree\n");
>>
>> + =A0 =A0 =A0 if (!dev->dev.of_match)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> =A0 =A0 =A0 =A0ret =3D of_address_to_resource(np, 0,&resource);
>> =A0 =A0 =A0 =A0if (ret) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_warn(&dev->dev, PFX "invalid address =
from OF\n");
>> @@ -2600,7 +2602,7 @@ static int __devinit ipmi_of_probe(struct
>> platform_device *dev,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENOMEM;
>> =A0 =A0 =A0 =A0}
>>
>> - =A0 =A0 =A0 info->si_type =A0 =A0 =A0 =A0 =A0 =3D (enum si_type) match=
->data;
>> + =A0 =A0 =A0 info->si_type =A0 =A0 =A0 =A0 =A0 =3D (enum si_type) dev->=
dev.of_match->data;
>> =A0 =A0 =A0 =A0info->addr_source =A0 =A0 =A0 =3D SI_DEVICETREE;
>> =A0 =A0 =A0 =A0info->irq_setup =A0 =A0 =A0 =A0 =3D std_irq_setup;
>>
>> @@ -2652,9 +2654,9 @@ static struct of_device_id ipmi_match[] >> =A0 =A0=
 =A0 =A0{},
>> =A0};
>>
>> -static struct of_platform_driver ipmi_of_platform_driver =3D {
>> +static struct platform_driver ipmi_of_platform_driver =3D {
>> =A0 =A0 =A0 =A0.driver =3D {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "ipmi",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "of-ipmi",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.owner =3D THIS_MODULE,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.of_match_table =3D ipmi_match,
>> =A0 =A0 =A0 =A0},
>> @@ -3396,7 +3398,7 @@ static int __devinit init_ipmi_si(void)
>> =A0#endif
>>
>> =A0#ifdef CONFIG_PPC_OF
>> - =A0 =A0 =A0 of_register_platform_driver(&ipmi_of_platform_driver);
>> + =A0 =A0 =A0 platform_driver_register(&ipmi_of_platform_driver);
>> =A0 =A0 =A0 =A0of_registered =3D 1;
>> =A0#endif
>>
>> @@ -3457,7 +3459,7 @@ static int __devinit init_ipmi_si(void)
>>
>> =A0#ifdef CONFIG_PPC_OF
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (of_registered)
>> -
>> of_unregister_platform_driver(&ipmi_of_platform_driver);
>> +
>> platform_driver_unregister(&ipmi_of_platform_driver);
>> =A0#endif
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0driver_unregister(&ipmi_driver.driver);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_WARNING PFX
>> @@ -3558,7 +3560,7 @@ static void __exit cleanup_ipmi_si(void)
>>
>> =A0#ifdef CONFIG_PPC_OF
>> =A0 =A0 =A0 =A0if (of_registered)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_unregister_platform_driver(&ipmi_of_pla=
tform_driver);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 platform_driver_unregister(&ipmi_of_platfo=
rm_driver);
>> =A0#endif
>>
>> =A0 =A0 =A0 =A0mutex_lock(&smi_infos_lock);
>
> Um, you are doing exactly what you said I should not do. Now the driver h=
as
> 2 platform drivers defined. I have an updated patch that addresses your
> previous comments. I will send it out later today.

Thanks.  I wacked this whole series out one evening and converted all
the drivers at once, so it's not surprising that I missed some
duplications.  Send me your patch and I'll drop my changes here.

g.
