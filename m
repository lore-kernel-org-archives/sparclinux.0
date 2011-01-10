From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 10 Jan 2011 16:17:45 +0000
Subject: Re: [PATCH v2] SPARC: added U-Boot build target: uImage
Message-Id: <20110110161745.GA13763@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1294674552-26656-1-git-send-email-daniel@gaisler.com>
In-Reply-To: <1294674552-26656-1-git-send-email-daniel@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Daniel.

Looks better...

>  define archhelp
>    echo  '* image        - kernel image ($(boot)/image)'
>    echo  '* zImage       - stripped kernel image ($(boot)/zImage)'
> +  echo  '  uImage       - U-Boot SPARC32/LEON Image'
>    echo  '  tftpboot.img - image prepared for tftp'

On the commandline you use "sparc32" - so to be consistent I think we should
use "sparc32" in the help text too. But I do not feel strong about this at all.


> +OBJCOPYFLAGS_image.bin := -S -O binary -R .note -R .comment
> +$(obj)/image.bin: $(obj)/image FORCE
> +	$(call if_changed,objcopy)

I recall that we remove .note in similar places.
Could you double check what other archs do here.

> +
> +$(obj)/image.gz: $(obj)/image.bin
> +	$(call if_changed,gzip)
> +
> +# Start of Main memory which this Linux kernel will be loaded to.
> +ifndef CONFIG_UBOOT_LOAD_ADDR
> +CONFIG_UBOOT_LOAD_ADDR=0x40004000
> +endif

I do not see that value in testign for the three newly introduced
Kconfig symbols.
In your backported kernel it may make sense but in mainline the symbols
will always be defined as Kconfig define them.

So just reference them direct.

	Sam
