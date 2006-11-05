From: andrew@walrond.org
Date: Sun, 05 Nov 2006 12:05:47 +0000
Subject: Strange kernel messages bootinh 2.6.18.2 on an E4000
Message-Id: <20061105120547.GA3665@pelagius.h-e-r-e-s-y.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello list,

I've been porting my little Heretix distro to pure 64bit sparc64, and
have had a few issues along the way. 2.6.18.1 caused some head
scratching by booting fine on a T1000, but not at all on either an
E4000 or an E4500, but I assume that was fixed by the FHC patch in
2.6.18.2, which boots up nicely on all all the machines.

However, on the E4000 (haven't checked E4500 but I guess that will be
the same) I see lots of these:

 kobject_add failed for fhc with -EEXIST, don't try to register things
 with the same name in the same directory.
 Call Trace:
  [0000000000427ba8] of_device_register+0x2c/0x60
  [000000000076cf80] scan_one_device+0x8b8/0x924
  [000000000076d000] scan_tree+0x14/0x3c
  [000000000076d0c4] of_bus_driver_init+0x9c/0xa4
  [0000000000416b24] init+0x168/0x360
  [0000000000417578] kernel_thread+0x38/0x48
  [0000000000416d34] rest_init+0x18/0x34
 /fhc: Could not register of device.


Well, 8 to be precise. (= # slots in the e4000 ?)

Any clues what this is about, and how to fix it?

Also, hotplug/udev fails to load up much in the way of modules (eg
sunhme for the net interfaces). Works fine if I do it manually. I
haven't looking into this yet, but a cursory glance suggested the lack
of any sbus related scripts might be to blame?

Anyhow, hotplug/udev did a better job on the T1000, but probably
because it is pci based?

Andrew Walrond
