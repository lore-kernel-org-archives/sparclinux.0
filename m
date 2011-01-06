From: daniel@gaisler.com
Date: Thu, 06 Jan 2011 17:23:32 +0000
Subject: Re: [PATCH] SPARC: added U-Boot build target: uImage
Message-Id: <20110106122332.fhrqe08740wwowg4@webmail.bluegenesis.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1294224160-7333-2-git-send-email-daniel@gaisler.com>
In-Reply-To: <1294224160-7333-2-git-send-email-daniel@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: sparclinux@vger.kernel.org


On Thu, 6 Jan 2011 18:13:48  0100, Sam Ravnborg  wrote:
>  > >  $(obj)/image.gz: $(obj)/image.bin
  > >  > >   $(call if_changed,gzip)
  > >  > >
  > >  > >  # Start of Main memory which this Linux kernel will be loaded to. 
  > >  > >  ifndef UIMAGE_LOADADDR
  > >  > >  UIMAGE_LOADADDR=0x40004000
  > >  > >  endif
  > >  > >
  > >  >
  > >  > Rather than hardcoding such addresses in the Makefile could
  > >  > we come up with something so we get board support
  > >  > included in the KConfig files?
  > >   
  > >  Of course, however is that really good, I mean we don't want to
  > > rebuild the kernel just to change the load location. One kernel may end
  > > up at different addresses at different boards... 
  >
  > kbuild is smart enough to only rebuild what needs to be
  > rebuild when we change the configuration. 
  >
  > So if we have:
  > config SPARC_UIMAGE_LAODADDR
  >  depends on SPARC_LEON
  >  int "Start of Main memory which this Linux kernel will be loaded to"
  >
  > Then if you type "make" then only uimage is
  > called - and nothing else is rebuilt. 
   
  Ok, that settles it, I will update this patch with a Kconfig option. 
   
  >
  > >   
  > >  It is not really hardcoded, it is just the default address, one can
  > > override the defualt address by adding a define at the make line, for
  > > example:
  > >  $ make ARCH=sparc CROSS_COMPILE=sparc-linux-
  > > UIMAGE_LOADADDR=0x00004000 uImage
  >
  > This would still be possible - the names just have a CONFIG_ prefix. 
  >
  >
  > >  >
  > >  > I for once would love to be able to select
  > >  > "GR-LEON4-ITX" in Kconfig and then everything is
  > >  > set correct up concerning LOADADDR for uimage. 
  > >   
  > >  There are very many different boards to support, that is a lot of job
  > > maintaining, I'm not sure we want to go there. Note that the LEON is a
  > > SoC and that there a lot of different chips, and a lot of different
  > > boards... Why the LEON3 port works without a BSP between the different
  > > chips/boards are thanks to Plug&Play at the processor local bus... The
  > > standard location of all LEON3 is basically 0x40004000 or 0x60004000
  > > (if two memory interfaces are supported), I can only think of one chip
  > > that has this different. 
  >
  > But then lets go for a simpler variant where you at least cover these
  > two typical setups. 
  > Then the board can document that they need "LEON BSP Type 1" og
  > "LEON BSP Type 2" in the kernel. 
  >
  > (Random names - we need better names). 
   
  I think it will do with one hex option per config, since any chip 
manufacturer may set any address. I will try to come up with a name for 
it. 
   
  >
  > >  > >  quiet_cmd_uimage = UIMAGE  $@
  > >  > >        cmd_uimage = $(CONFIG_SHELL) $(MKIMAGE) -A sparc -O linux
  > > -T kernel \
  > >  > >                 -C gzip -a $(UIMAGE_LOADADDR) -e 0xf0004000 -n
  > > 'Linux-$(KERNELRELEASE)' \
  > >  > >                 -d $< $@
  > >  > >
  > >  > >  targets  = uImage
  > >  > >  $(obj)/uImage: $(obj)/image.gz
  > >  > >   $(call if_changed,uimage)
  > >  > >   sparc-linux-ld -Tdata $(UIMAGE_FLASHADDR) -r -b binary
  > > arch/sparc/boot/uImage -o arch/sparc/boot/uImage.o
  > >  > >   @echo '  Image $@ is ready'
  > >  >
  > >  > What is the purpose of uImage.o?
  > >  The uImage is readable by u-boot and can be loaded into memory by
  > > U-BOOT, however sometimes is easier to load the uImage image directly
  > > into RAM/FLASH using a tool such as GRMON/TSIM/GRSIM. So the uImage.o
  > > is an ELF image ready to be loaded into memory using a debugger of some
  > > sort, just for convenience when networking isn't available for u-boot
  > > or when a system is first time programmed before shipping... 
  > >   
  > >  > At least sh does not have it - but thay have a lot of other 
U-boot targets. 
  > >  > And can we fix is so we get a nice display when the command is 
executed?
  > >   
  > >  what do you what to be printed? is another echo enough?
  >
  > I have in mind something like this:
  > quiet_cmd_uimage.o = UIMAGE.O $@
  >       cmd_uimage.o = sparc-linux-ld -Tdata $(UIMAGE_FLASHADDR) -r 
-b binary \
  >                      $@ -o $@.o
  >
  > Then you can just do:
  >
  >  $(call cmd,uimage.o)
   
  Sounds good,
   
  Thanks for your input,
  Daniel

