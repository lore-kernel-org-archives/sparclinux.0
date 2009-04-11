From: Robert Reif <reif@earthlink.net>
Date: Sat, 11 Apr 2009 16:05:09 +0000
Subject: sparc32 fails to boot
Message-Id: <49E0BFB5.7050401@earthlink.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I just tried booting RC1 and I am getting the following repeating errors.

The last kernel I tried was 2.6.29-rc4 so that's a lot to bisect so
any ideas before I start bisecting?

I also had a very hard time getting a kernel small enough to boot.
I had to throw away virtually everything to finally get it to boot.
I don't know if that's related.

boot: Linux console=ttyS0
Uncompressing image...
Loaded kernel version 2.6.30
Loading initial ramdisk (2218440 bytes at 0x3000000 phys, 0x60000000 
virt)...
PROMLIB: obio_ranges 5
OF stdout device is: /obio/zs@0,100000:a
Booting Linux...
er_driver+0x184/0x1bc ] [f0264700 : _etext+0x908e8/0x99610 ] [f0011054 : 
do_one_initcall+0x4c/0x194 ] [f024fb44 : _etext+0x7bd2c/0x99610 ] 
[f0015368 : kernel_thread+0x34/0x50 ] [f01cdea8 : rest_init+0x10/0x
fb95c000: redzone 1:0xaaaaaaaaaaaaaaaa, redzone 2:0xaaaaaaaaaaaaaaaa
slab error in cache_alloc_debugcheck_after(): cache `size-512': double 
free, or memory outside object was overwritten
[f016a14c : __alloc_skb+0x48/0x120 ] [f00f7a84 : 
kobject_uevent_env+0x260/0x3bc ] [f0146860 : device_add+0x504/0x644 ] 
[f0146a28 : device_create_vargs+0x70/0xa8 ] [f0146a80 : 
device_create+0x20/0x30 ] [f012
fb168000: redzone 1:0xaaaaaaaaaaaaaaaa, redzone 2:0xaaaaaaaaaaaaaaaa
slab error in cache_alloc_debugcheck_after(): cache `cred_jar': double 
free, or memory outside object was overwritten
[f004e214 : prepare_usermodehelper_creds+0x2c/0xcc ] [f004449c : 
call_usermodehelper_setup+0x64/0x84 ] [f00f7b84 : 
kobject_uevent_env+0x360/0x3bc ] [f0146860 : device_add+0x504/0x644 ] 
[f0146a28 : device_cr
f327a000: redzone 1:0xaaaaaaaaaaaaaaaa, redzone 2:0xaaaaaaaaaaaaaaaa
slab error in cache_alloc_debugcheck_after(): cache `size-256': double 
free, or memory outside object was overwritten
[f01469dc : device_create_vargs+0x24/0xa8 ] [f0146a80 : 
device_create+0x20/0x30 ] [f01283f4 : tty_register_device+0xc0/0xd0 ] 
[f0128588 : tty_register_driver+0x184/0x1bc ] [f0264700 : 
_etext+0x908e8/0x99610
f327b000: redzone 1:0xaaaaaaaaaaaaaaaa, redzone 2:0xaaaaaaaaaaaaaaaa
slab error in cache_alloc_debugcheck_after(): cache `skbuff_head_cache': 
double free, or memory outside object was overwritten
[f016a12c : __alloc_skb+0x28/0x120 ] [f00f7a84 : 
kobject_uevent_env+0x260/0x3bc ] [f0146860 : device_add+0x504/0x644 ] 
[f0146a28 : device_create_vargs+0x70/0xa8 ] [f0146a80 : 
device_create+0x20/0x30 ] [f012
f
