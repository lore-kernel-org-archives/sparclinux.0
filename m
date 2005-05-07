From: Adrian Bunk <bunk@stusta.de>
Date: Sat, 07 May 2005 14:41:35 +0000
Subject: select of non-existing I2C* symbols
Message-Id: <20050507144135.GL3590@stusta.de>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.58.0503021553140.25732@ppc970.osdl.org> <20050303002733.GH10124@redhat.com> <20050302203812.092f80a0.akpm@osdl.org> <20050304105247.B3932@flint.arm.linux.org.uk> <20050304032632.0a729d11.akpm@osdl.org> <20050304113626.E3932@flint.arm.linux.org.uk> <20050506235842.A23651@flint.arm.linux.org.uk> <427C9DBD.1030905@ppp0.net> <20050507122622.C11839@flint.arm.linux.org.uk> <427CC082.4000603@ppp0.net>
In-Reply-To: <427CC082.4000603@ppp0.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jan Dittmer <jdittmer@ppp0.net>, spyro@f2s.com, zippel@linux-m68k.org, starvik@axis.com, wli@holomorphy.com
Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net, dev-etrax@axis.com, sparclinux@vger.kernel.org

On Sat, May 07, 2005 at 03:20:02PM +0200, Jan Dittmer wrote:
>...
> Link to this page: http://l4x.org/k/?diff[v1]=mm

arm26, cris, sparc: select of non-existing I2C* symbols:

@ Ian, Mikael, William:
This could be fixed by sourcing drivers/i2c/Kconfig in arch/*/Kconfig,
but it would be better to switch to use drivers/Kconfig.

@ Roman:
Shouldn't kconfig exit with an error if a not available symbol gets
selected?


> Jan

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

