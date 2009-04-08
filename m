From: seb@frankengul.org
Date: Wed, 08 Apr 2009 23:25:42 +0000
Subject: Re: SunFire V240 hangs
Message-Id: <20090408232542.GF1142@frankengul.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20090408200711.GA1142@frankengul.org>
In-Reply-To: <20090408200711.GA1142@frankengul.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Apr 08, 2009 at 04:02:08PM -0700, David Miller wrote:
> From: seb@frankengul.org
> Date: Thu, 9 Apr 2009 01:01:01 +0200
> 
> > On Wed, Apr 08, 2009 at 03:45:53PM -0700, David Miller wrote:
> >> > Strange, with arch_initcall(pcr_arch_init); commented, the kernel builds fine;
> >> > 
> >> > However, the good news is that this kernel boots fine.
> >> 
> >> I suspect it will boot fine if you wait for the NMI tester to
> >> timeout too.
> > 
> > Hum, how long does it takes to timeout ?
> 
> It can take from 20 to 30 seconds, for each processor.
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

If I remember well, I let the machine on for several hours last time I tried, and the kernel never
recovered.
At this time, the machine froze completely. 5 minutes later, there is still no sign of life on the console.

Here's the last known output of the kernel.

[   49.357679] initcall backlight_class_init+0x0/0x74 returned 0 after 0 usecs
[   49.357685] calling  tty_class_init+0x0/0x38 @ 1
[   49.357700] initcall tty_class_init+0x0/0x38 returned 0 after 0 usecs
[   49.357706] calling  vtconsole_class_init+0x0/0xe8 @ 1
[   49.357749] initcall vtconsole_class_init+0x0/0xe8 returned 0 after 0 usecs
[   49.357757] calling  register_node_type+0x0/0x9c @ 1
[   49.357777] initcall register_node_type+0x0/0x9c returned 0 after 0 usecs
[   49.357783] calling  spi_init+0x0/0x7c @ 1
[   49.357813] initcall spi_init+0x0/0x7c returned 0 after 0 usecs
[   49.357818] calling  i2c_init+0x0/0x70 @ 1
[   49.357866] initcall i2c_init+0x0/0x70 returned 0 after 0 usecs
[   49.357872] calling  cpu_type_probe+0x0/0x274 @ 1
[   49.357879] initcall cpu_type_probe+0x0/0x274 returned 0 after 0 usecs
[   49.357885] calling  pcr_arch_init+0x0/0x14c @ 1
[   55.


	Seb
