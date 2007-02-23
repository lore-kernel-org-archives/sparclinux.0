From: Andrew Walrond <andrew@walrond.org>
Date: Fri, 23 Feb 2007 15:47:24 +0000
Subject: Re: (Sparc64) 2.6.20 seems to ignore initramfs
Message-Id: <200702231547.24667.andrew@walrond.org>
List-Id: <sparclinux.vger.kernel.org>
References: <200702231108.10185.andrew@walrond.org> <200702231446.20929.andrew@walrond.org> <45DF056C.2010806@wpkg.org>
In-Reply-To: <45DF056C.2010806@wpkg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomasz Chmielewski <mangoo@wpkg.org>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Friday 23 February 2007 15:17, Tomasz Chmielewski wrote:
>
> Try to decrease the initramfs size just to know if it boots correctly.
>
> I.e., put just a sh/bash/ash/dash binary there (probably /dev/console
> node, too), executed in init.
>
> Then, try to start the kernel with initramfs embedded in the kernel,
> then as initrd etc. - this will show if the fault is on your side, or
> kernel's.

I have tracked this down to a broken version of gnu cpio (latest release, 2.7) 
which was used to create the initramfs archive. Bloody annoying since this 
has bitten me before! Last time I even sent the maintainer a bug report, and 
apparently a fix is in CVS waiting for the next release. Ho hum.

Sorry for the noise.

Andrew Walrond
