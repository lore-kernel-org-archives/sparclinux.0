From: Marc Zyngier <maz@misterjones.org>
Date: Fri, 01 May 2009 18:53:13 +0000
Subject: Re: X4422A dual-gigabit + dual-UW2 SCSI?
Message-Id: <20090501205313.2d2881ac@taxman.wild-wind.fr.eu.org>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.00.0905012036320.23623@thorbardin.lasthome.solace.krynn>
In-Reply-To: <alpine.LRH.2.00.0905012036320.23623@thorbardin.lasthome.solace.krynn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, 1 May 2009 20:38:06 +0200 (CEST)
coyote@cojot.name wrote:

> Does the X4422A card (Dual-Gigaswift cassini) and Dual-UW2 SCSi work
> under Linux (either x86 or sparc).. Does anyone know? Looking at
> cassini.c, it doesn't feel so but I am unsure...

I used it for a while on a PA-RISC machine running Linux, without any
particular problem (except for a PA specific patch that made it to
mainline ages ago...).

It should not be worse on Sparc.

	M.
