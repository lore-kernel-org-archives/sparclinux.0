From: David Miller <davem@davemloft.net>
Date: Wed, 03 Dec 2008 20:46:30 +0000
Subject: Re: [revised v2 PATCH 5/5] sparc,sparc64: unify boot/
Message-Id: <20081203.124630.132449842.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20081203200044.GA6471@uranus.ravnborg.org>
In-Reply-To: <20081203200044.GA6471@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 3 Dec 2008 21:00:44 +0100

BTW:

> +ifeq ($(CONFIG_SPARC64),y)
> +quiet_cmd_piggy     = PIGGY   $@
> +      cmd_piggy     = $(obj)/piggyback_64 $@ System.map $(ROOT_IMG)
> +quiet_cmd_strip     = STRIP   $@
> +      cmd_strip     = $(STRIP) -R .comment -R .note -K sun4u_init -K _end -K _start vmlinux -o $@
> +
> +
> +# Actual linking
> +$(obj)/image: vmlinux FORCE
> +        $(call if_changed,strip)
> +        @echo '  kernel: $@ is ready'
> +
> +$(obj)/tftpboot.img: vmlinux $(obj)/piggyback_64 System.map $(ROOT_IMG) FORCE
> +        $(call if_changed,elftoaout)
> +        $(call if_changed,piggy)
> +        @echo '  kernel: $@ is ready'
> +
> +$(obj)/vmlinux.aout: vmlinux FORCE
> +        $(call if_changed,elftoaout)
> +        @echo '  kernel: $@ is ready'
> +endif

This is one of the things I had to fix up when I applied these
patches.  Those linking rules need to have initial tabs not spaces
before the commands to be run, or else the build breaks.

I guess you didn't do any "make image" testing, or did you? :-)

But don't worry I fixed that up in my tree when I applied
these patches and I dealt with the conflict too already.
