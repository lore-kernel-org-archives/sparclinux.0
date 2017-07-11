From: David Laight <David.Laight@ACULAB.COM>
Date: Tue, 11 Jul 2017 14:23:29 +0000
Subject: RE: [PATCH] tty: Fix TIOCGPTPEER ioctl definition
Message-Id: <063D6719AE5E284EB5DD2968C1650D6DD003758C@AcuExch.aculab.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20170711001207.GA11642@glebfm.cloud.tilaa.com>
In-Reply-To: <20170711001207.GA11642@glebfm.cloud.tilaa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Gleb Fotengauer-Malinovskiy' <glebfm@altlinux.org>, Aleksa Sarai <asarai@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>, Valentin Rothberg <vrothberg@suse.com>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>, "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Dmitry V. Levin" <ldv@altlinux.org>, Jiri Slaby <jslaby@suse.com>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, Christian Brauner <christian.brauner@ubuntu.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>

From: Linuxppc-dev  Gleb Fotengauer-Malinovskiy
> Sent: 11 July 2017 01:12
> This ioctl does nothing to justify an _IOC_READ or _IOC_WRITE flag
> because it doesn't copy anything from/to userspace to access the
> argument.
> 
> Fixes: 54ebbfb1 ("tty: add TIOCGPTPEER ioctl")
...
> -#define TIOCGPTPEER	_IOR('T', 0x41, int) /* Safely open the slave */
> +#define TIOCGPTPEER	_IO('T', 0x41) /* Safely open the slave */

This is a user API change. When was the ioctl added?

	David

