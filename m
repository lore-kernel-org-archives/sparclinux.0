From: Meelis Roos <mroos@linux.ee>
Date: Fri, 16 Jan 2009 11:02:33 +0000
Subject: fhc led registration warnings
Message-Id: <Pine.SOC.4.64.0901161258360.2120@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

While booting todays 2.6.29-rc1+git on E3500, these warning about FHC 
LEDs sysfs registration appeared in the logs. I sent the previous mail 
away and decided to send this one separately, but now I see that the 
location of platform-specific device registrations js the same where CPU 
detection problem were, so maybe they are related afterall.

[  136.437166] WARNING: at fs/sysfs/dir.c:462 sysfs_add_one+0x44/0x60()
[  136.437226] sysfs: duplicate filename 'sunfire-fhc-leds.0' can not be created
[  136.437288] Modules linked in:
[  136.437343] Call Trace:
[  136.437407]  [000000000045c8cc] warn_slowpath+0x6c/0xc0
[  136.437467]  [0000000000541a04] sysfs_add_one+0x44/0x60
[  136.437530]  [0000000000542d4c] sysfs_do_create_link+0x12c/0x1a0
[  136.437595]  [0000000000542e1c] sysfs_create_link+0x1c/0x40
[  136.437660]  [00000000005ed544] bus_add_device+0xe4/0x180
[  136.437735]  [00000000005eb8e0] device_add+0x300/0x540
[  136.437800]  [00000000005efb30] platform_device_add+0xd0/0x1e0
[  136.437865]  [00000000005efc58] platform_device_register+0x18/0x40
[  136.437941]  [00000000006c5744] fhc_probe+0xf8/0x264
[  136.438016]  [0000000000627170] of_platform_device_probe+0x50/0xe0
[  136.438082]  [00000000005ee23c] driver_probe_device+0x9c/0x1c0
[  136.438145]  [00000000005ee3e4] __driver_attach+0x84/0xa0
[  136.438205]  [00000000005ed998] bus_for_each_dev+0x58/0xa0
[  136.438267]  [00000000005ee080] driver_attach+0x20/0x40
[  136.438326]  [00000000005ed16c] bus_add_driver+0xac/0x240
[  136.438387]  [00000000005ee648] driver_register+0x68/0x160
[  136.438604] ---[ end trace 139ce121c98e96c9 ]---
[  136.439011] fhc: Could not register LEDS platform device
[  136.439104] fhc: probe of f0071c1c failed with error -17
[  136.439296] ------------[ cut here ]------------
[  136.439351] WARNING: at fs/sysfs/dir.c:462 sysfs_add_one+0x44/0x60()
[  136.439413] sysfs: duplicate filename 'sunfire-fhc-leds.0' can not be created
[  136.439474] Modules linked in:
[  136.439525] Call Trace:
[  136.439576]  [000000000045c8cc] warn_slowpath+0x6c/0xc0
[  136.439636]  [0000000000541a04] sysfs_add_one+0x44/0x60
[  136.439696]  [0000000000542d4c] sysfs_do_create_link+0x12c/0x1a0
[  136.439761]  [0000000000542e1c] sysfs_create_link+0x1c/0x40
[  136.439822]  [00000000005ed544] bus_add_device+0xe4/0x180
[  136.439888]  [00000000005eb8e0] device_add+0x300/0x540
[  136.439949]  [00000000005efb30] platform_device_add+0xd0/0x1e0
[  136.440015]  [00000000005efc58] platform_device_register+0x18/0x40
[  136.440082]  [00000000006c5744] fhc_probe+0xf8/0x264
[  136.440147]  [0000000000627170] of_platform_device_probe+0x50/0xe0
[  136.440212]  [00000000005ee23c] driver_probe_device+0x9c/0x1c0
[  136.440276]  [00000000005ee3e4] __driver_attach+0x84/0xa0
[  136.440337]  [00000000005ed998] bus_for_each_dev+0x58/0xa0
[  136.440398]  [00000000005ee080] driver_attach+0x20/0x40
[  136.440458]  [00000000005ed16c] bus_add_driver+0xac/0x240
[  136.440520]  [00000000005ee648] driver_register+0x68/0x160
[  136.440576] ---[ end trace 139ce121c98e96ca ]---
[  136.440982] fhc: Could not register LEDS platform device
[  136.441070] fhc: probe of f01c923c failed with error -17



-- 
Meelis Roos (mroos@linux.ee)
