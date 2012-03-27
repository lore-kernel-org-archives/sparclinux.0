From: Frans van Berckel <fberckel@xs4all.nl>
Date: Tue, 27 Mar 2012 15:25:26 +0000
Subject: Re: v440 & expert 3D
Message-Id: <1332861926.1709.9.camel@deblnxsrv224.lan>
List-Id: <sparclinux.vger.kernel.org>
References: <1332502667.1755.10.camel@deblnxsrv224.lan>
In-Reply-To: <1332502667.1755.10.camel@deblnxsrv224.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, 2012-03-23 at 12:37 +0100, Frans van Berckel wrote: 
> Does a Expert 3D fits in a SunFire v440 well. Because in it holds at -
> console [tty0] enabled, bootconsole disabled. It does not switch.
> 
> I am running the default kernel 3.2 from Debian testing. With a PGX64 in
> the same box it runs well! The card is installed in pci2 slot.

Today I hooked a serial kabel, take off the usb keyboard. And fount out
the system reboots spontaneously at the switch with a Expert 3D only
installed. How do I boot a little bit more verbose, getting debug info?

Thanks,

Frans van Berckel

[    0.000000] Booting Linux...
[    0.000000] CPU CAPS: [flush,stbar,swap,muldiv,v9,ultra3,mul32,div32]
[    0.000000] CPU CAPS: [v8plus,vis,vis2]
[    0.000000] PERCPU: Embedded 6 pages/cpu @fffff8000a400000 s20096
r8192
d20864 u1048576
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on. 
Total pages: 2415404
[    0.000000] Kernel command line: root=/dev/sda2 ro
[    0.000000] PID hash table entries: 4096 (order: 2, 32768 bytes)
[    0.000000] Dentry cache hash table entries: 4194304 (order: 12,
33554432 bytes)
[    0.000000] Inode-cache hash table entries: 2097152 (order: 11,
16777216 bytes)
[    0.000000] Memory: 20740128k available (3656k kernel code, 1552k
data,
232k init) [fffff80000000000,000000323fe68000]
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  CONFIG_RCU_FANOUT set to non-default value of 32
[    0.000000]  RCU dyntick-idle grace-period acceleration is enabled.
[    0.000000] NR_IRQS:255
[    0.000000] clocksource: mult[64000000] shift[24]
[    0.000000] clockevent: mult[28f5c29] shift[32]
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled, bootconsole disabled

SC Alert: Host System has Reset

SC Alert: Failed to send email alert for recent event.

Fatal Error Reset
CPU 0000.0000.0000.0000 AFSR 0080.0000.0000.0000 JEIC
AFAR 0000.0000.0000.0000

