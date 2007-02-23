From: Tomasz Chmielewski <mangoo@wpkg.org>
Date: Fri, 23 Feb 2007 13:32:30 +0000
Subject: Re: (Sparc64) 2.6.20 seems to ignore initramfs
Message-Id: <45DEECEE.6070108@wpkg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <200702231108.10185.andrew@walrond.org>
In-Reply-To: <200702231108.10185.andrew@walrond.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Walrond <andrew@walrond.org>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

Andrew Walrond schrieb:
> On a Sun T1000 I am trying to boot 2.6.20 using initramfs. (I use the same 
> procedure successfully on x86_64 and itanium2 servers).
> 
> The relevent silo section looks like this:
> 
> image=/boot/2.6.20.image
>         label=2.6.20
>         initrd=/boot/2.6.20.initramfs
>         partition=2
>         read-only
> 
> The kernel loads and boots and I see
> 

(...)

> 
> So it knows about the initramfs, but then tries to mount a root filesystem 
> instead...
> 
> I haven't tried this (initramfs)  with earlier kernels, so I don't know 
> whether this is a regression. Any clues about how to solve this would be 
> greatly appreciated.

Does it make a difference if you embed initramfs directly in the kernel?

CONFIG_INITRAMFS_SOURCE="/path/to/your/initramfs/directory"


-- 
Tomasz Chmielewski
http://wpkg.org

