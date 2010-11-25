From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 25 Nov 2010 16:17:59 +0000
Subject: Re: RFC: Mega rename of device tree routines from of_*() to dt_*()
Message-Id: <AANLkTiknyKi1pzvUP2WnasudZwH27-a0FxCX0BSHBdQp@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1290607413.12457.44.camel@concordia> <1290692075.689.20.camel@concordia>
In-Reply-To: <1290692075.689.20.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: michael@ellerman.id.au
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-mips <linux-mips@linux-mips.org>, microblaze-uclinux@itee.uq.edu.au, devicetree-discuss@lists.ozlabs.org, linuxppc-dev list <linuxppc-dev@ozlabs.org>, sparclinux@vger.kernel.org, Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Thu, Nov 25, 2010 at 6:34 AM, Michael Ellerman
<michael@ellerman.id.au> wrote:
> On Thu, 2010-11-25 at 01:03 +1100, Michael Ellerman wrote:
>> Hi all,
>>
>> There were some murmurings on IRC last week about renaming the of_*()
>> routines.
> ...
>> The thinking is that on many platforms that use the of_() routines
>> OpenFirmware is not involved at all, this is true even on many powerpc
>> platforms. Also for folks who don't know the OpenFirmware connection
>> it reads as "of", as in "a can of worms".
> ...
>> So I'm hoping people with either say "YES this is a great idea", or "NO
>> this is stupid".
>
> I'm still hoping, but so far it seems most people have got better things
> to do, and of those that do have an opinion the balance is slightly
> positive.

I assume you'll be also publishing the script that you use for
generating the massive patch.  I expect that there will be a few
iterations of running the rename script to convert over all the
stragglers.  It should also be negotiated with Linus about when this
patch should get applied.  I do NOT want to cause massive merge pain
during the merge window.

Andrew/Linus: Before Michael proceeds too far with this rename, are
you okay with a mass rename of the device tree functions from of_* to
dt_*?  Nobody likes the ambiguous 'of_' prefix ("of?  of what?"), but
to fix it means large cross-tree patches and potential merge
conflicts.

> So here's a first cut of a patch to add the new names. I've not touched
> of_platform because that is supposed to go away. That will lead to some
> odd looking code in the interim, but I think is the right approach.

I would split it up into separate dt*.h files, one for each of*.h file
so that the #include lines can be changed in the C code at the same
time.  Each dt*.h file would include it's of*.h counterpart.  Then
after the code is renamed, and a release or two has passed to catch
the majority of users, the old definitions can be moved into the dt*.h
files.

However, it may be better to move and rename the definitions
immediately, and leave "#define of_*  dt_*" macros in the old of*.h
files which can be removed with a simple patch after all the users are
converted.  That would have a smaller impact in the cleanup stage.

> Most of these are straight renames, but some have changed more
> substantially. The routines for the flat tree have all become fdt_foo().
> I'd be inclined to drop "early_init" from them too, because they're
> basically all about early init, but Grant said he'd prefer not to I
> think. I've also renamed the flat tree tag constants to match libfdt.

It is all about early init now in Linus' tree, but Stephen
Neuendorffer has patches that use the fdt code at driver probe time
for parsing device tree fragments that describe an FPGA add-in board.

>
> I've left for_each_child_of_node(), because I read it as "of", but maybe
> it's "OF"?

hahaha!  I never considered that it might be OF, but now I probably
won't be able to help but read it that way!  I like Geert's suggestion
of dt_for_each_child_node

g.

>
> cheers
>
> #ifndef __DT_H
> #define __DT_H
>
> /* include/linux/device.h */
> #define dt_match_table =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0of_match_table
> #define dt_node =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_node

This could be very messy.  I've nervous about using #define to rename
structure members.  You'll need to check that any structure members
that use the same name as a global symbol are handled appropriately.

>
> /* include/linux/mod_devicetable.h */
> #define dt_device_id =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0of_device_id
>
> /* include/linux/of.h */
> #define dt_node_to_nid =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0of_node_to_nid
> #define dt_chosen =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_chosen
> #define dt_node_is_root =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_node_is_root
> #define dt_node_check_flag =A0 =A0 =A0 =A0 =A0 =A0 =A0of_node_check_flag
> #define dt_node_set_flag =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0of_node_set_flag
> #define dt_find_all_nodes =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_find_all_nodes
> #define dt_node_get =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_node_get
> #define dt_node_put =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_node_put
> #define dt_read_number =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0of_read_number
> #define dt_read_ulong =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_read_ulong
> #define dt_find_node_by_name =A0 =A0 =A0 =A0 =A0 =A0of_find_node_by_name
> #define dt_find_node_by_type =A0 =A0 =A0 =A0 =A0 =A0of_find_node_by_type
> #define dt_find_compatible_node =A0 =A0 =A0 =A0 of_find_compatible_node
> #define dt_find_matching_node =A0 =A0 =A0 =A0 =A0 of_find_matching_node
> #define dt_find_node_by_path =A0 =A0 =A0 =A0 =A0 =A0of_find_node_by_path
> #define dt_find_node_by_phandle =A0 =A0 =A0 =A0 of_find_node_by_phandle
> #define dt_get_parent =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_get_parent
> #define dt_get_next_parent =A0 =A0 =A0 =A0 =A0 =A0 =A0of_get_next_parent
> #define dt_get_next_child =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_get_next_child
> #define dt_find_node_with_property =A0 =A0 =A0of_find_node_with_property
> #define dt_device_is_compatible =A0 =A0 =A0 =A0 of_device_is_compatible
> #define dt_device_is_available =A0 =A0 =A0 =A0 =A0of_device_is_available
> #define dt_get_property =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_get_property
> #define dt_n_addr_cells =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_n_addr_cells
> #define dt_n_size_cells =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_n_size_cells
> #define dt_match_node =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_match_node
> #define dt_modalias_node =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0of_modalias_node
> #define dt_parse_phandle =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0of_parse_phandle
> #define dt_parse_phandles_with_args =A0 =A0 of_parse_phandles_with_args
> #define dt_machine_is_compatible =A0 =A0 =A0 =A0of_machine_is_compatible
> #define dt_attach_node =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0of_attach_node
> #define dt_detach_node =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0of_detach_node
> #define dt_find_property =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0of_find_property
>
> /* include/linux/of_fdt.h */
> #define fdt_find_string =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 find_flat_dt_stri=
ng
> #define fdt_scan =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0of_scan_f=
lat_dt
> #define fdt_get_prop =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0of_get_flat_d=
t_prop
> #define fdt_is_compatible =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_flat_dt_is_compa=
tible
> #define fdt_get_root =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0of_get_flat_d=
t_root
> #define fdt_early_init_scan_chosen =A0 =A0 =A0early_init_dt_scan_chosen
> #define fdt_early_init_check_for_initrd early_init_dt_check_for_initrd
> #define fdt_early_init_scan_memory =A0 =A0 =A0early_init_dt_scan_memory
> #define fdt_early_init_add_memory_arch =A0early_init_dt_add_memory_arch
> #define fdt_early_init_alloc_memory_arch early_init_dt_alloc_memory_arch
> #define fdt_early_init_setup_initrd_arch early_init_dt_setup_initrd_arch
> #define fdt_early_init_scan_root =A0 =A0 =A0 =A0early_init_dt_scan_root
> #define fdt_unflatten =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unflatten_devic=
e_tree
> #define fdt_early_init =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0early_init_devt=
ree
> #define FDT_MAGIC =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OF_DT_HEADER
> #define FDT_BEGIN_NODE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OF_DT_BEGIN_NODE
> #define FDT_END_NODE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OF_DT_END_NODE
> #define FDT_PROP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OF_DT_PROP
> #define FDT_NOP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OF_DT_NOP
> #define FDT_END =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OF_DT_END
> #define FDT_VERSION =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OF_DT_VERSION
>
> /* include/linux/of_address.h */
> #define dt_translate_address =A0 =A0 =A0 =A0 =A0 =A0of_translate_address
> #define dt_address_to_resource =A0 =A0 =A0 =A0 =A0of_address_to_resource
> #define dt_iomap =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0of_iomap
> #define dt_get_address =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0of_get_address
> #define dt_get_pci_address =A0 =A0 =A0 =A0 =A0 =A0 =A0of_get_pci_address
> #define dt_pci_address_to_resource =A0 =A0 =A0of_pci_address_to_resource
>
> /* include/linux/of_device.h */
> #define dt_match_device =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_match_device
> #define dt_device_make_bus_id =A0 =A0 =A0 =A0 =A0 of_device_make_bus_id
> #define dt_driver_match_device =A0 =A0 =A0 =A0 =A0of_driver_match_device
> #define dt_dev_get =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0of_dev_get
> #define dt_dev_put =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0of_dev_put
> #define dt_device_add =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_device_add
> #define dt_device_register =A0 =A0 =A0 =A0 =A0 =A0 =A0of_device_register
> #define dt_device_unregister =A0 =A0 =A0 =A0 =A0 =A0of_device_unregister
> #define dt_device_get_modalias =A0 =A0 =A0 =A0 =A0of_device_get_modalias
> #define dt_device_uevent =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0of_device_uevent
> #define dt_device_node_put =A0 =A0 =A0 =A0 =A0 =A0 =A0of_device_node_put
>
> /* include/linux/of_irq.h */
> #define dt_irq =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0of_irq
> #define dt_irq_parse_and_map =A0 =A0 =A0 =A0 =A0 =A0irq_of_parse_and_map
> #define dt_irq_workarounds =A0 =A0 =A0 =A0 =A0 =A0 =A0of_irq_workarounds
> #define dt_irq_dflt_pic =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_irq_dflt_pic
> #define dt_irq_map_oldworld =A0 =A0 =A0 =A0 =A0 =A0 of_irq_map_oldworld
> #define dt_irq_map_raw =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0of_irq_map_raw
> #define dt_irq_map_one =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0of_irq_map_one
> #define dt_irq_create_mapping =A0 =A0 =A0 =A0 =A0 irq_create_of_mapping
> #define dt_irq_to_resource =A0 =A0 =A0 =A0 =A0 =A0 =A0of_irq_to_resource
> #define dt_irq_count =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0of_irq_count
> #define dt_irq_to_resource_table =A0 =A0 =A0 =A0of_irq_to_resource_table
> #define DT_IRQ_MAX_SPEC =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OF_MAX_IRQ_SPEC
> #define DT_IRQ_QUIRK_OLDWORLD_MAC =A0 =A0 =A0 OF_IMAP_OLDWORLD_MAC
> #define DT_IRQ_QUIRK_NO_PHANDLE =A0 =A0 =A0 =A0 OF_IMAP_NO_PHANDLE
>
> /* include/linux/of_mdio.h */
> #define dt_mdiobus_register =A0 =A0 =A0 =A0 =A0 =A0 of_mdiobus_register
> #define dt_phy_find_device =A0 =A0 =A0 =A0 =A0 =A0 =A0of_phy_find_device
> #define dt_phy_connect =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0of_phy_connect
> #define dt_phy_connect_fixed_link =A0 =A0 =A0 of_phy_connect_fixed_link
>
> /* include/linux/of_spi.h */
> #define dt_register_spi_devices =A0 =A0 =A0 =A0 of_register_spi_devices
>
> /* include/linux/of_gpio.h */
> #define dt_gpio_flags =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_gpio_flags
> #define DT_GPIO_ACTIVE_LOW =A0 =A0 =A0 =A0 =A0 =A0 =A0OF_GPIO_ACTIVE_LOW
> #define dt_mm_gpio_chip =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_mm_gpio_chip
> #define to_dt_mm_gpio_chip =A0 =A0 =A0 =A0 =A0 =A0 =A0to_of_mm_gpio_chip
> #define dt_get_gpio_flags =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_get_gpio_flags
> #define dt_gpio_count =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_gpio_count
> #define dt_mm_gpiochip_add =A0 =A0 =A0 =A0 =A0 =A0 =A0of_mm_gpiochip_add
> #define dt_gpiochip_add =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_gpiochip_add
> #define dt_gpiochip_remove =A0 =A0 =A0 =A0 =A0 =A0 =A0of_gpiochip_remove
> #define dt_node_to_gpiochip =A0 =A0 =A0 =A0 =A0 =A0 of_node_to_gpiochip
> #define dt_get_gpio =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_get_gpio
>
> /* include/linux/dt_i2c.h */
> #define dt_i2c_register_devices =A0 =A0 =A0 =A0 of_i2c_register_devices
> #define dt_find_i2c_device_by_node =A0 =A0 =A0of_find_i2c_device_by_node
>
> #endif /* __DT_H */
>
>
>
>
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
