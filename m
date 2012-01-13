From: David Miller <davem@davemloft.net>
Date: Fri, 13 Jan 2012 23:09:05 +0000
Subject: Re: [WIP] sparc32: replace bootmem with memblock
Message-Id: <20120113.150905.1428599056040466925.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20120103204516.GA4271@merkur.ravnborg.org>
In-Reply-To: <20120103204516.GA4271@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 3 Jan 2012 21:45:16 +0100

> +/* Reserve memory for initrd (if present) */
> +void __init find_ramdisk(unsigned long phys_base)
>  {

I would suggest duplicating the comment from sparc64's find_ramdisk()
which explains the KERNBASE/phys_base adjustments and that they are
an artifact of how the bootloader calculates the ramdisk address it
passes to the kernel.
