From: daniel@gaisler.com
Date: Thu, 06 Jan 2011 16:43:20 +0000
Subject: Re: [PATCH] SPARC: added U-Boot build target: uImage
Message-Id: <20110106114320.gtu9yt34m8g8840w@webmail.bluegenesis.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1294224160-7333-2-git-send-email-daniel@gaisler.com>
In-Reply-To: <1294224160-7333-2-git-send-email-daniel@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: sparclinux@vger.kernel.org

Hi Sam,

On Wed, 5 Jan 2011 20:19:15  0100, Sam Ravnborg  wrote:
Hi Daniel. 
  >
  > On Wed, Jan 05, 2011 at 11:42:40AM  0100, Daniel Hellstrom wrote:
  > > This is only for LEON as u-boot for SPARC only supports LEON. 
  > >
  > > Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
  > > ---
  > >  arch/sparc/Makefile      |    3   -
  > >  arch/sparc/boot/Makefile |   36
  > >  2 files changed, 38 insertions( ), 1 deletions(-)
  > >
  > > diff --git a/arch/sparc/Makefile b/arch/sparc/Makefile
  > > index 113225b..012d289 100644
  > > --- a/arch/sparc/Makefile
  > >     b/arch/sparc/Makefile
  > > @@ -88,7  88,7 @@ boot := arch/sparc/boot
  > >  # Default target
  > >  all: zImage
  > >
  > > -image zImage tftpboot.img vmlinux.aout: vmlinux
  > >  image zImage uImage tftpboot.img vmlinux.aout: vmlinux
  > >   $(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
  > >
  > >  archclean:
  > > @@ -102,6  102,7 @@ ifeq ($(ARCH),sparc)
  > >  define archhelp
  > >    echo  '* image        - kernel image ($(boot)/image)'
  > >    echo  '* zImage       - stripped kernel image ($(boot)/zImage)'
  > >    echo  '  uImage       - U-Boot SPARC32/LEON Image'
  > >    echo  '  tftpboot.img - image prepared for tftp'
  > >  endef
  > >  else
  > > diff --git a/arch/sparc/boot/Makefile b/arch/sparc/boot/Makefile
  > > index 97e3feb..9574958 100644
  > > --- a/arch/sparc/boot/Makefile
  > >     b/arch/sparc/boot/Makefile
  > > @@ -5,6  5,7 @@
  > >
  > >  ROOT_IMG := /usr/src/root.img
  > >  ELFTOAOUT := elftoaout
  > >  MKIMAGE  := $(srctree)/scripts/mkuboot.sh
  > >
  > >  hostprogs-y := piggyback_32 piggyback_64 btfixupprep
  > >  targets := tftpboot.img btfix.o btfix.S image zImage vmlinux.aout
  > > @@ -90,5  91,40 @@ $(obj)/tftpboot.img: $(obj)/image 
$(obj)/piggyback_64 System.map $(ROOT_IMG) FOR
  > >  $(obj)/vmlinux.aout: vmlinux FORCE
  > >   $(call if_changed,elftoaout)
  > >   @echo '  kernel: $@ is ready'
  > >  else
  > >
  > >  # The following lines make a readable image for U-Boot. 
  > >  #  uImage   - Binary file read by U-boot
  > >  #  uImage.o - object file of uImage for loading with a
  > >  #             flash programmer understanding ELF. 
  > >
  > >  OBJCOPYFLAGS_image.bin := -S -O binary -R .note -R .comment
  > >  $(obj)/image.bin: $(obj)/image FORCE
  > >   $(call if_changed,objcopy)
  > >
  > >  $(obj)/image.gz: $(obj)/image.bin
  > >   $(call if_changed,gzip)
  > >
  > >  # Start of Main memory which this Linux kernel will be loaded to. 
  > >  ifndef UIMAGE_LOADADDR
  > >  UIMAGE_LOADADDR=0x40004000
  > >  endif
  > >
  >
  > Rather than hardcoding such addresses in the Makefile could
  > we come up with something so we get board support
  > included in the KConfig files?
   
  Of course, however is that really good, I mean we don't want to 
rebuild the kernel just to change the load location. One kernel may end 
up at different addresses at different boards... 
   
  It is not really hardcoded, it is just the default address, one can 
override the defualt address by adding a define at the make line, for 
example:
  $ make ARCH=sparc CROSS_COMPILE=sparc-linux- 
UIMAGE_LOADADDR=0x00004000 uImage
   
  >
  > I for once would love to be able to select
  > "GR-LEON4-ITX" in Kconfig and then everything is
  > set correct up concerning LOADADDR for uimage. 
   
  There are very many different boards to support, that is a lot of job 
maintaining, I'm not sure we want to go there. Note that the LEON is a 
SoC and that there a lot of different chips, and a lot of different 
boards... Why the LEON3 port works without a BSP between the different 
chips/boards are thanks to Plug&Play at the processor local bus... The 
standard location of all LEON3 is basically 0x40004000 or 0x60004000 
(if two memory interfaces are supported), I can only think of one chip 
that has this different. 
   
  >
  > Same goes for the start address which is hardcoded to 0xf0004000. 
  >
  > I looked briefly at the other archs but did not find a good one
  > to copy this from. 
  >
  >
  > >  # The first sector after the U-Boot image (512k). Override this 
accoring to
  > >  # your u-boot binary size and FLASH block size. 
  > >  ifndef UIMAGE_FLASHADDR
  > >  UIMAGE_FLASHADDR=0x00080000
  > >  endif
  > >
  > >  quiet_cmd_uimage = UIMAGE  $@
  > >        cmd_uimage = $(CONFIG_SHELL) $(MKIMAGE) -A sparc -O linux 
-T kernel \
  > >                 -C gzip -a $(UIMAGE_LOADADDR) -e 0xf0004000 -n 
'Linux-$(KERNELRELEASE)' \
  > >                 -d $< $@
  > >
  > >  targets  = uImage
  > >  $(obj)/uImage: $(obj)/image.gz
  > >   $(call if_changed,uimage)
  > >   sparc-linux-ld -Tdata $(UIMAGE_FLASHADDR) -r -b binary 
arch/sparc/boot/uImage -o arch/sparc/boot/uImage.o
  > >   @echo '  Image $@ is ready'
  >
  > What is the purpose of uImage.o?
  The uImage is readable by u-boot and can be loaded into memory by 
U-BOOT, however sometimes is easier to load the uImage image directly 
into RAM/FLASH using a tool such as GRMON/TSIM/GRSIM. So the uImage.o 
is an ELF image ready to be loaded into memory using a debugger of some 
sort, just for convenience when networking isn't available for u-boot 
or when a system is first time programmed before shipping... 
   
  > At least sh does not have it - but thay have a lot of other U-boot targets. 
  > And can we fix is so we get a nice display when the command is executed?
   
  what do you what to be printed? is another echo enough?
   
  Best Regards,
  Daniel
   

