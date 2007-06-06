From: David Miller <davem@davemloft.net>
Date: Wed, 06 Jun 2007 19:41:04 +0000
Subject: Re: Ultra 1 hang on boot
Message-Id: <20070606.124104.78711303.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0706061524480.12237@math>
In-Reply-To: <Pine.SOC.4.64.0706061524480.12237@math>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Wed, 6 Jun 2007 15:49:38 +0300 (EEST)

> boot: test -p
> Allocated 8 Megs of memory at 0x40000000 for kernel
> Uncompressing image...
> Loaded kernel version 2.6.22
> 
> PROMLIB: Sun IEEE Boot Prom 'OBP 3.25.0 1999/12/03 11:37'
> PROMLIB: Root node compatible:
> Linux version 2.6.22-rc4 (mroos@melon) (gcc version 4.1.3 20070528 (prerelease) (Debian 4.1.2-9)) #8 Tue Jun 5 17:10:23 EEST 2007
> ARCH: SUN4U
> Ethernet address: 08:00:20:88:6d:6a
> Remapping the kernel... done.
> 
> Any other config option to try for debugging?
> The only section warnings are promcon section warnings - may these 
> result in this hang or do they kick in later?

I have a fix for those but they ought to be harmless.

Since it takes years for me to get my ultra1 up and build
a kernel, can you figure out the most recent kernel that
worked properly?

Thanks.
