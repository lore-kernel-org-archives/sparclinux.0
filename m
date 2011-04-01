From: =?UTF-8?Q?Moritz_M=C3=BChlenhoff?= <jmm@inutil.org>
Date: Fri, 01 Apr 2011 19:42:06 +0000
Subject: Re: linux-image-2.6.26-1-sparc64-smp: [sparc] SunFire480R cassini
Message-Id: <20110401194206.GA12436@pisco.westfalen.local>
List-Id: <sparclinux.vger.kernel.org>
References: <20100113082925.GA15798@lemon.iwr.uni-heidelberg.de>
In-Reply-To: <20100113082925.GA15798@lemon.iwr.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Mar 01, 2010 at 12:30:05PM +0100, Hermann Lauer wrote:
> On Wed, Jan 13, 2010 at 09:29:25AM +0100, Hermann Lauer wrote:
> > I tried again with vanilla 2.6.32 (2.6.27-2.6.31 are unusable due to a kernel
> > memory corruption bug), the driver is still crashing my Sunfire V480R.
> 
> Tried today vanilla 2.6.33, then did a:
> 
> # modprobe -v cassini cassini_debug=-1
> insmod /lib/modules/2.6.33/kernel/drivers/net/cassini.ko cassini_debug=-1
> 
> In kern.log the messages appeared:
> 
> Mar  1 12:17:14 tantalus kernel: cassini.c:v1.6 (21 May 2008)
> Mar  1 12:17:14 tantalus kernel: PCI: Enabling device: (0002:00:02.0), cmd 146
> Mar  1 12:17:15 tantalus kernel: cassini: MAC address not found in ROM VPD
> Mar  1 12:17:15 tantalus kernel: eth0: Sun Cassini+ (64bit/33MHz PCI/Cu) Ethernet[24] 08:00:20:cb:31:01
> Mar  1 12:17:15 tantalus kernel: PCI: Enabling device: (0003:00:01.0), cmd 146
> Mar  1 12:17:15 tantalus kernel: cassini: MAC address not found in ROM VPD
> Mar  1 12:17:15 tantalus kernel: udev: renamed network interface eth0 to eth15
> Mar  1 12:17:15 tantalus kernel: eth0: Sun Cassini+ (64bit/66MHz PCI/Cu) Ethernet[30] 08:00:20:bc:c7:b7
> Mar  1 12:17:15 tantalus kernel: udev: renamed network interface eth0 to eth16
> Mar  1 12:20:48 tantalus kernel: eth15: Link up at 1000 Mbps, full-duplex.
> Mar  1 12:20:48 tantalus kernel: eth15: TX pause enabled
> Mar  1 12:20:59 tantalus kernel: eth15: no IPv6 routers present
> 
> As before, setting up the interface with ifconfig works.
> After sending out 68 pings the machine crashed with the usual 
> Hardware FATAL RESET.
> 
> What can be done to debug this further ?

Is this fixed in later kernels, e.g. the 2.6.38 from Debian unstable?

If so and the fix can be isolated we can fix it in 2.6.32 for Squeeze.

Cheers,
        Moritz
