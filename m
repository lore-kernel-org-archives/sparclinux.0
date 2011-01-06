From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 06 Jan 2011 17:13:48 +0000
Subject: Re: [PATCH] SPARC: added U-Boot build target: uImage
Message-Id: <20110106171348.GA17263@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1294224160-7333-2-git-send-email-daniel@gaisler.com>
In-Reply-To: <1294224160-7333-2-git-send-email-daniel@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

>  > >  $(obj)/image.gz: $(obj)/image.bin
>  > >   $(call if_changed,gzip)
>  > >
>  > >  # Start of Main memory which this Linux kernel will be loaded to.
>  > >  ifndef UIMAGE_LOADADDR
>  > >  UIMAGE_LOADADDR=3D0x40004000
>  > >  endif
>  > >
>  >
>  > Rather than hardcoding such addresses in the Makefile could
>  > we come up with something so we get board support
>  > included in the KConfig files?
>  =A0
>  Of course, however is that really good, I mean we don't want to
> rebuild the kernel just to change the load location. One kernel may end
> up at different addresses at different boards...

kbuild is smart enough to only rebuild what needs to be
rebuild when we change the configuration.

So if we have:
config SPARC_UIMAGE_LAODADDR
	depends on SPARC_LEON
	int "Start of Main memory which this Linux kernel will be loaded to"

Then if you type "make" then only uimage is
called - and nothing else is rebuilt.

>  =A0
>  It is not really hardcoded, it is just the default address, one can
> override the defualt address by adding a define at the make line, for
> example:
>  $ make ARCH=3Dsparc CROSS_COMPILE=3Dsparc-linux-
> UIMAGE_LOADADDR=3D0x00004000 uImage

This would still be possible - the names just have a CONFIG_ prefix.


>  >
>  > I for once would love to be able to select
>  > "GR-LEON4-ITX" in Kconfig and then everything is
>  > set correct up concerning LOADADDR for uimage.
>  =A0
>  There are very many different boards to support, that is a lot of job
> maintaining, I'm not sure we want to go there. Note that the LEON is a
> SoC and that there a lot of different chips, and a lot of different
> boards... Why the LEON3 port works without a BSP between the different
> chips/boards are thanks to Plug&Play at the processor local bus... The
> standard location of all LEON3 is basically 0x40004000 or 0x60004000
> (if two memory interfaces are supported), I can only think of one chip
> that has this different.

But then lets go for a simpler variant where you at least cover these
two typical setups.
Then the board can document that they need "LEON BSP Type 1" og
"LEON BSP Type 2" in the kernel.

(Random names - we need better names).

>  > >  quiet_cmd_uimage =3D UIMAGE  $@
>  > >        cmd_uimage =3D $(CONFIG_SHELL) $(MKIMAGE) -A sparc -O linux
> -T kernel \
>  > >                 -C gzip -a $(UIMAGE_LOADADDR) -e 0xf0004000 -n
> 'Linux-$(KERNELRELEASE)' \
>  > >                 -d $< $@
>  > >
>  > >  targets  =3D uImage
>  > >  $(obj)/uImage: $(obj)/image.gz
>  > >   $(call if_changed,uimage)
>  > >   sparc-linux-ld -Tdata $(UIMAGE_FLASHADDR) -r -b binary
> arch/sparc/boot/uImage -o arch/sparc/boot/uImage.o
>  > >   @echo '  Image $@ is ready'
>  >
>  > What is the purpose of uImage.o?
>  The uImage is readable by u-boot and can be loaded into memory by
> U-BOOT, however sometimes is easier to load the uImage image directly
> into RAM/FLASH using a tool such as GRMON/TSIM/GRSIM. So the uImage.o
> is an ELF image ready to be loaded into memory using a debugger of some
> sort, just for convenience when networking isn't available for u-boot
> or when a system is first time programmed before shipping...
>  =A0
>  > At least sh does not have it - but thay have a lot of other U-boot tar=
gets.
>  > And can we fix is so we get a nice display when the command is execute=
d?
>  =A0
>  what do you what to be printed? is another echo enough?

I have in mind something like this:
quiet_cmd_uimage.o =3D UIMAGE.O $@
      cmd_uimage.o =3D sparc-linux-ld -Tdata $(UIMAGE_FLASHADDR) -r -b bina=
ry \
                     $@ -o $@.o

Then you can just do:

	$(call cmd,uimage.o)

    Sam
