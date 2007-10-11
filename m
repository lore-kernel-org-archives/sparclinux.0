From: Adrian Bunk <bunk@kernel.org>
Date: Thu, 11 Oct 2007 11:05:55 +0000
Subject: Re: Scsi on sparc build break in 2.6.23.
Message-Id: <20071011110555.GV16424@stusta.de>
List-Id: <sparclinux.vger.kernel.org>
References: <200710110552.49129.rob@landley.net>
In-Reply-To: <200710110552.49129.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Landley <rob@landley.net>
Cc: linux-scsi@vger.kernel.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Oct 11, 2007 at 05:52:48AM -0500, Rob Landley wrote:
> CONFIG_SCSI_SUNESP=y breaks the build in 2.6.23:
> 
>   LD      vmlinux
> `scsi_esp_unregister' referenced in section `__ksymtab' of drivers/built-in.o: 
> defined in discarded section `.exit.text' of drivers/built-in.o
> make: *** [vmlinux] Error 1
> 
> Do you need my full .config to reproduce this?

Please always attach the .config when reporting errors.
The few bytes don't matter and it often saves some time.

I have an idea regarding what might be going wrong in this case,
but it would cost me additional time to look at it because you didn't 
send your .config.

> Rob

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

