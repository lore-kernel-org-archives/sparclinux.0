From: Laszlo Valko <valko@linux.karinthy.hu>
Date: Mon, 23 Nov 2009 16:01:52 +0000
Subject: Re: 2.6.31.6 freezes on v210
Message-Id: <20091123170152.A6464@linux.karinthy.hu>
List-Id: <sparclinux.vger.kernel.org>
References: <20091120210249.A20906@linux.karinthy.hu>
In-Reply-To: <20091120210249.A20906@linux.karinthy.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Nov 23, 2009 at 04:57:44PM +0100, Hermann Lauer wrote:
> On Sun, Nov 22, 2009 at 12:26:05AM +0100, Laszlo Valko wrote:
> > > Will try your config with a 2.6.28 kernel next week. Could you please provide
> > > your working 2.6.28 vmlinux binary on the web/ftp so that I can try this
> > > on my machines ?
> > 
> > Here's the 2.6.28 kernel that worked for me:
> > http://info.mediastorm.hu/kernel-2.6.28-hardened-r9
> 
> ends very soon with:
> 
> Rebooting with command: boot gem:dhcp
> Boot device: /pci@8,600000/network@2:dhcp  File and args: 
> Timed out waiting for BOOTP/DHCP reply
> Timed out waiting for BOOTP/DHCP reply
> Timed out waiting for BOOTP/DHCP reply
> ERROR: Last Trap: Fast Data Access MMU Miss
> 
> {2} ok 

Is this supposed to boot from net? /usr/src/linux/arch/sparc/boot/image
is a kernel image that can be booted from network?

I boot it with silo.

Regards,
Laszlo

> 
> So for the SunFire 880/480 still no kernel >=2.6.27 found booting.
> At least made netbooting working again, hope this helps davem.
> 
> Thanks anyway,
>  Hermann
> 
> -- 
> Netzwerkadministration/Zentrale Dienste, Interdiziplinaeres 
> Zentrum fuer wissenschaftliches Rechnen der Universitaet Heidelberg
> IWR; INF 368; 69120 Heidelberg; Tel: (06221)54-8236 Fax: -5224
> Email: Hermann.Lauer@iwr.uni-heidelberg.de

