From: Aleksa Sarai <asarai@suse.de>
Date: Tue, 11 Jul 2017 02:07:43 +0000
Subject: Re: [PATCH] tty: Fix TIOCGPTPEER ioctl definition
Message-Id: <f1cac5bf-d34f-9684-b27b-20e973f454a0@suse.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20170711001207.GA11642@glebfm.cloud.tilaa.com>
In-Reply-To: <20170711001207.GA11642@glebfm.cloud.tilaa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, Arnd Bergmann <arnd@arndb.de>, Christian Brauner <christian.brauner@ubuntu.com>, Valentin Rothberg <vrothberg@suse.com>, "Dmitry V. Levin" <ldv@altlinux.org>, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org

> This ioctl does nothing to justify an _IOC_READ or _IOC_WRITE flag
> because it doesn't copy anything from/to userspace to access the
> argument.

   Acked-by: Aleksa Sarai <asarai@suse.de>

Oops, I misunderstood what _IOR means semantically. TIL -- thanks!

-- 
Aleksa Sarai
Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/
