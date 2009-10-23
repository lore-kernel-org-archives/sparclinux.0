From: =?UTF-8?B?UmHDumwgUG9yY2Vs?= <armin76@gentoo.org>
Date: Fri, 23 Oct 2009 19:24:09 +0000
Subject: Re: temperature & fan-control
Message-Id: <4AE202D9.9090305@gentoo.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1256288818.1858.15.camel@deblnxsrv254.opensoftwarenetwork.nl>
In-Reply-To: <1256288818.1858.15.camel@deblnxsrv254.opensoftwarenetwork.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Frans van Berckel wrote:
> Hi,
> 
> Is speeding the fans on a Blade 1000/2000 and Fire 280R well supported
> by the kernel? What sensor modules & tools are needed to compile?
> 
> Thanks,
> 
> Frans van Berckel
> 
> uname -a: Linux sunbladesrv249 2.6.32-rc5-kernelbuilder #1 SMP Tue Oct
> 20 23:34:41 CEST 2009 sparc GNU/Linux
> 
> prtconf:     pci (driver probably installed)
> prtconf:         ebus (driver probably installed)
> prtconf:             flashprom (driver probably installed)
> prtconf:             bbc (driver probably installed)
> prtconf:             ppm (driver probably installed)
> prtconf:             i2c (driver probably installed)
> prtconf:                 dimm-fru (driver probably installed)
> prtconf:                 dimm-fru (driver probably installed)
> prtconf:                 dimm-fru (driver probably installed)
> prtconf:                 dimm-fru (driver probably installed)
> prtconf:                 dimm-fru (driver probably installed)
> prtconf:                 dimm-fru (driver probably installed)
> prtconf:                 dimm-fru (driver probably installed)
> prtconf:                 dimm-fru (driver probably installed)
> prtconf:                 nvram (driver probably installed)
> prtconf:                 idprom (driver probably installed)
> prtconf:             i2c (driver probably installed)
> prtconf:                 cpu-fru (driver probably installed)
> prtconf:                 temperature (driver probably installed)
> prtconf:                 cpu-fru (driver probably installed)
> prtconf:                 temperature (driver probably installed)
> prtconf:                 fan-control (driver probably installed)
> prtconf:                 card-reader (driver probably installed)
> prtconf:                 motherboard-fru (driver probably installed)
> prtconf:                 i2c-bridge (driver probably installed)
> 
> 
> lsmod: Module                  Size  Used by
> lsmod: openpromfs              4731  1 
> lsmod: evdev                   8479  0 
> lsmod: sd_mod                 32227  4 
> lsmod: crc_t10dif              1507  1 sd_mod
> lsmod: sg                     27580  0 
> lsmod: sr_mod                 14561  0 
> lsmod: cdrom                  36852  1 sr_mod
> lsmod: qla2xxx               231393  3 
> lsmod: scsi_transport_fc      43776  1 qla2xxx
> lsmod: ohci_hcd               19010  0 
> lsmod: sym53c8xx              73756  0 
> lsmod: ohci1394               27982  0 
> lsmod: scsi_tgt               10531  1 scsi_transport_fc
> lsmod: ehci_hcd               33847  0 
> lsmod: scsi_transport_spi     23476  1 sym53c8xx
> lsmod: scsi_mod              163367  8 sd_mod,sg, sr_mod,qla2xxx,
> scsi_transport_fc, sym53c8xx, scsi_tgt, scsi_transport_spi
> lsmod: ieee1394               84208  1 ohci1394
> 
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Frans,

can't say about the 280R, but the fan control on the Blade 1000/2000
worked until kernel 2.6.29, when it stopped working and hasn't worked
since then. If you downgrade to a 2.6.28 kernel for example, you don't
need any tool for it to work, you just need the CONFIG_ENVCTRL option
enabled in your kernel either as built-in or as a module.

@all: feel free to correct me if i'm wrong :)
