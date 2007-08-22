From: "Tom \"spot\" Callaway" <tcallawa@redhat.com>
Date: Wed, 22 Aug 2007 21:44:41 +0000
Subject: Re: sun4v oops
Message-Id: <1187819081.3439.370.camel@dhcp83-165.boston.redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1187814718.3439.350.camel@dhcp83-165.boston.redhat.com>
In-Reply-To: <1187814718.3439.350.camel@dhcp83-165.boston.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


On Wed, 2007-08-22 at 13:39 -0700, David Miller wrote:
> From: "Tom \"spot\" Callaway" <tcallawa@redhat.com>
> Date: Wed, 22 Aug 2007 16:31:58 -0400
> 
> > Got this oops with the attached config very quickly after init, threw me
> > back to the prom. Firmware is fully updated on the box, latest SILO too.
> > 
> > Starting udev: OOPS: Bogus kernel PC [0000000000000000] in fault handler
> > OOPS: RPC [0000000000477aa4]
> > OOPS: Fault was to vaddr[f7f22000]
> 
> Something jumped to address zero.
> 
> This happened at address 0x477aa4, find out where that is.
> 
> Also, if you're using gcc-4.2.x for kernel builds, don't.
> There is a miscompile, that others have run into, which
> I have tracked down and am trying to build a test case
> for so the gcc folks can look at and hopefully fix it.

I'm not. Fedora is still on gcc 4.1.

System.map says:

00000000004778bc t rcu_start_batch
0000000000477928 t __rcu_process_callbacks
0000000000477b98 t rcu_process_callbacks
0000000000477bd4 t rcu_barrier_callback

Not sure how useful that is. I accidentally rebooted into this kernel,
and it booted all the way to login this time, but I noticed the
following in dmesg:

ldc.c:v1.0 (June 25, 2007)
ldc: Domaining disabled.
NET: Registered protocol family 16
VIO: Adding device channel-devices
VIO: Adding device vldc-port-0-0
VIO: Adding device vldc-port-0-1
VIO: Adding device vldc-port-0-2
VIO: Adding device vldc-port-1-0
VIO: Adding device vldc-port-3-0
VIO: Adding device vldc-port-3-8
VIO: Adding device ds-0
VIO: Adding device ds-1
VIO: Adding device ds-0
kobject_add failed for ds-0 with -EEXIST, don't try to register things
with the 
same name in the same directory.
Call Trace:
 [00000000005536e8] kobject_shadow_add+0x1a4/0x1e8
 [000000000055373c] kobject_add+0x10/0x1c
 [00000000005b60a8] device_add+0x88/0x588
 [00000000005b65bc] device_register+0x14/0x20
 [000000000044fd58] vio_create_one+0x408/0x45c
 [000000000044fdc8] vio_add+0x1c/0x24
 [000000000043c340] mdesc_register_notifier+0x40/0x78
 [00000000007e2c00] vio_init+0x17c/0x19c
 [00000000007d6390] kernel_init+0x228/0x3c8
 [000000000042783c] kernel_thread+0x38/0x48
 [0000000000685e74] rest_init+0x18/0x64
VIO: Could not register device ds-0, err=-17

One last item: This kernel loads the e1000 driver fine, but while it
detects the devices, it doesn't think there is link on the eth0 port (or
any of eth0-3 for that matter). There is definitely a good link there,
but it won't pull an IP over dhcp.

bash-3.1# dmesg |grep e1000
e1000: 0001:07:00.0: e1000_probe: (PCI Express:2.5Gb/s:Width x4)
00:14:4f:1d:9f:4e
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
e1000: 0001:07:00.1: e1000_probe: (PCI Express:2.5Gb/s:Width x4)
00:14:4f:1d:9f:4f
e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network Connection
e1000: 0000:04:00.0: e1000_probe: (PCI Express:2.5Gb/s:Width x4)
00:14:4f:1d:9f:4c
e1000: eth2: e1000_probe: Intel(R) PRO/1000 Network Connection
e1000: 0000:04:00.1: e1000_probe: (PCI Express:2.5Gb/s:Width x4)
00:14:4f:1d:9f:4d
e1000: eth3: e1000_probe: Intel(R) PRO/1000 Network Connection

lspci says:

0000:04:00.0 Ethernet controller: Intel Corporation 82571EB Gigabit
Ethernet Controller (rev 06)
0000:04:00.1 Ethernet controller: Intel Corporation 82571EB Gigabit
Ethernet Controller (rev 06)
0001:07:00.0 Ethernet controller: Intel Corporation 82571EB Gigabit
Ethernet Controller (rev 06)
0001:07:00.1 Ethernet controller: Intel Corporation 82571EB Gigabit
Ethernet Controller (rev 06)

Is this the correct place to report that regression, or should I go to
LKML or Intel?

Thanks,

~spot

