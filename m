From: Aleksa Sarai <asarai@suse.de>
Date: Sat, 03 Jun 2017 14:13:27 +0000
Subject: Re: [PATCH v3 1/2] tty: add compat_ioctl callbacks
Message-Id: <7bd066af-bd37-5a66-74b7-1267b58a43f8@suse.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20170603135111.5444-1-asarai@suse.de>
 <20170603135111.5444-2-asarai@suse.de>
In-Reply-To: <20170603135111.5444-2-asarai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, Christian Brauner <christian.brauner@ubuntu.com>, Valentin Rothberg <vrothberg@suse.com>

> diff --git a/Makefile b/Makefile
> index 470bd4d9513a..fb689286d83a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -401,6 +401,7 @@ KBUILD_CFLAGS   := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
>   		   -fno-strict-aliasing -fno-common \
>   		   -Werror-implicit-function-declaration \
>   		   -Wno-format-security \
> +		   -Wno-error=int-in-bool-context \
>   		   -std=gnu89 $(call cc-option,-fno-PIE)


Ah sorry, I committed that by accident. I'll send a fixed version.

-- 
Aleksa Sarai
Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/
