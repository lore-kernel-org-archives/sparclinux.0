From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 16 Jan 2009 10:06:57 +0000
Subject: Re: sparc64 modpost failure - insw/outsw undefined
Message-Id: <20090116100657.GA20279@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0901161113300.2120@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0901161113300.2120@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Jan 16, 2009 at 11:16:06AM +0200, Meelis Roos wrote:
> Trying todays 2.6.29-rc1+git on a sparc64, config below:
> 
>   MODPOST 499 modules
> ERROR: "insw" [drivers/scsi/fdomain.ko] undefined!
> ERROR: "outsw" [drivers/scsi/fdomain.ko] undefined!
> ERROR: "insl" [drivers/net/ne2k-pci.ko] undefined!
> ERROR: "outsl" [drivers/net/ne2k-pci.ko] undefined!
> ERROR: "outsw" [drivers/net/ne2k-pci.ko] undefined!
> ERROR: "insw" [drivers/net/ne2k-pci.ko] undefined!
> ERROR: "outsl" [drivers/net/3c59x.ko] undefined!
> ERROR: "insl" [drivers/net/3c59x.ko] undefined!
> ERROR: "insw" [drivers/ata/pata_it821x.ko] undefined!
> ERROR: "insw" [drivers/ata/libata.ko] undefined!
> ERROR: "outsl" [drivers/ata/libata.ko] undefined!
> ERROR: "outsw" [drivers/ata/libata.ko] undefined!
> ERROR: "insl" [drivers/ata/libata.ko] undefined!

My fault....
I moved the EXPORT_SYMBOL() from sparc64_ksyms.c to PeeCeeI.c.

But I overlooked a small detail in the Makefile:

lib-$(CONFIG_SPARC64) += PeeCeeI.o


PeeCeeI is a lib- thing so it only get pulled in when needed.

Changing the above to:
obj-$(CONFIG_SPARC64) += PeeCeeI.o

should fix it.

This is not the right fix - I need to dig a little.

	Sam
