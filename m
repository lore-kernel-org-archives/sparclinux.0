From: Adrian Bunk <bunk@fs.tum.de>
Date: Sat, 07 Aug 2004 17:01:22 +0000
Subject: architectures with their own "config PCMCIA"
Message-Id: <20040807170122.GM17708@fs.tum.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: wli@holomorphy.com, davem@redhat.com, geert@linux-m68k.org, schwidefsky@de.ibm.com
Cc: linux390@de.ibm.com, sparclinux@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org

The following architetures have their own "config PCMCIA" instead of 
including drivers/pcmcia/Kconfig (in 2.6.8-rc3-mm1):
- m68k
- s390
- sparc
- sparc64

Is there any good reason for this, or would a patch to change these 
architectures to include drivers/pcmcia/Kconfig be OK?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

