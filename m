From: David Miller <davem@davemloft.net>
Date: Sun, 05 Nov 2006 21:27:49 +0000
Subject: Re: Strange kernel messages bootinh 2.6.18.2 on an E4000
Message-Id: <20061105.132749.122592824.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20061105120547.GA3665@pelagius.h-e-r-e-s-y.com>
In-Reply-To: <20061105120547.GA3665@pelagius.h-e-r-e-s-y.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: andrew@walrond.org
Date: Sun, 5 Nov 2006 12:05:47 +0000

> However, on the E4000 (haven't checked E4500 but I guess that will be
> the same) I see lots of these:
> 
>  kobject_add failed for fhc with -EEXIST, don't try to register things
>  with the same name in the same directory.
>  Call Trace:
>   [0000000000427ba8] of_device_register+0x2c/0x60
>   [000000000076cf80] scan_one_device+0x8b8/0x924
>   [000000000076d000] scan_tree+0x14/0x3c
>   [000000000076d0c4] of_bus_driver_init+0x9c/0xa4
>   [0000000000416b24] init+0x168/0x360
>   [0000000000417578] kernel_thread+0x38/0x48
>   [0000000000416d34] rest_init+0x18/0x34
>  /fhc: Could not register of device.
> 
> 
> Well, 8 to be precise. (= # slots in the e4000 ?)
> 
> Any clues what this is about, and how to fix it?

This should be easy to fix, thanks for the report.  I'll take
a look.

> Also, hotplug/udev fails to load up much in the way of modules (eg
> sunhme for the net interfaces). Works fine if I do it manually. I
> haven't looking into this yet, but a cursory glance suggested the lack
> of any sbus related scripts might be to blame?

Only in 2.6.18 do these drivers even have MODULE loading device
ID information, and nobody has done the userland components yet.

Ubuntu and Debian use a hack'ish script that automatically finds the
correct SBUS modules by dumping the firmware device tree and looking
for certain node names.  They have a simple file that has firmware
node name to kernel module name mappings, which the bootup and
installer infrastructure make use of.  I forget where all of this is,
but I've tested it and it does work.

> Anyhow, hotplug/udev did a better job on the T1000, but probably
> because it is pci based?

Right.
