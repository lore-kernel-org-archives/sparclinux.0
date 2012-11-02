From: David Miller <davem@davemloft.net>
Date: Fri, 02 Nov 2012 21:30:06 +0000
Subject: Re: sparc64 crypto static linking problem
Message-Id: <20121102.173006.1622063178828674534.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1211012117400.16377@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1211012117400.16377@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Thu, 1 Nov 2012 21:22:19 +0200 (EET)

> While trying 3.7.0-rc3-00075-g1e207eb on sparc64, I configured sparc64 
> versionis of the ciphers. Modular where my original cipher was modular 
> and static where my original cipher was static (config snippet below). 
> This results in linking error when multiple thing are static:
> 
>  LD      arch/sparc/crypto/built-in.o
> arch/sparc/crypto/aes-sparc64.o:(.rodata+0x0): multiple definition of `__mod_of_device_table'
> arch/sparc/crypto/md5-sparc64.o:(.rodata+0x0): first defined here
> arch/sparc/crypto/crc32c-sparc64.o:(.rodata+0x0): multiple definition of `__mod_of_device_table'
> arch/sparc/crypto/md5-sparc64.o:(.rodata+0x0): first defined here

Thanks I'll fix this up.
