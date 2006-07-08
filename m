From: Bob Breuer <breuerr@mc.net>
Date: Sat, 08 Jul 2006 23:12:32 +0000
Subject: Re: Sparc driver changes afoot for 2.6.18
Message-Id: <44B03BE0.1090906@mc.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20060624.001552.92583040.davem@davemloft.net>
In-Reply-To: <20060624.001552.92583040.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:
> In another email Raymond Burns notes that clock_probe() is invoked
> too early.  This may be related to your problem.

Yes, it's the same problem.  After getting around that problem, I've now
hit another potential problem.  Multiple instances of a device don't
seem to be uniquely identified.


kobject_add failed for zs with -EEXIST, don't try to register things
with the same name in the same directory.
[f001badc : of_device_register+0x20/0x60 ] [f01e30d8 :
sun4c_init_IRQ+0xcc/0x1e8 ] [f01e3348 : sun4d_init_sbi_irq+0x6c/0xd0 ]
[f01e335c : sun4d_init_sbi_irq+0x80/0xd0 ] [f01e33dc :
sun4d_init_IRQ+0x30/0xfc ] [f0010108 : init+0x94/0x330 ] [f0014ef4 :
kernel_thread+0x3c/0x50 ] [f0010010 : rest_init+0x18/0x2c ]
/obio/zs: Could not register of device.

kobject_add failed for Ross,RT626 with -EEXIST, don't try to register
things with the same name in the same directory.
[f001badc : of_device_register+0x20/0x60 ] [f01e30d8 :
sun4c_init_IRQ+0xcc/0x1e8 ] [f01e3348 : sun4d_init_sbi_irq+0x6c/0xd0 ]
[f01e33dc : sun4d_init_IRQ+0x30/0xfc ] [f0010108 : init+0x94/0x330 ]
[f0014ef4 : kernel_thread+0x3c/0x50 ] [f0010010 : rest_init+0x18/0x2c ]
/Ross,RT626: Could not register of device.
