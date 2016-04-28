From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 28 Apr 2016 19:54:06 +0000
Subject: Re: [patch V3] lib: GCD: add binary GCD algorithm
Message-Id: <20160428195326.GB29802@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1461843824-19853-1-git-send-email-zengzhaoxiu@163.com>
 <20160428164856.10120.qmail@ns.horizon.com>
In-Reply-To: <20160428164856.10120.qmail@ns.horizon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

> __ffs on the available architectures:
> 	Alpha: sometimes (CONFIG_ALPHA_EV6, CONFIG_ALPHA_EV67)
> 	ARC: sometimes (!CONFIG_ISA_ARCOMPACT)
> 	ARM: sometimes (V5+)
> 	ARM64: NO, could be written using RBIT and CLZ
> 	AVR: yes
> 	Blackfin: NO, could be written using hweight()
> 	C6x: yes
> 	CRIS: NO
> 	FR-V: yes
> 	H8300: NO
> 	Hexagon: yes
> 	IA64: yes
> 	M32R: NO
> 	M68k: sometimes
> 	MetaG: NO
> 	Microblaze: NO
> 	MIPS: sometimes
> 	MN10300: yes
> 	OpenRISC: NO
> 	PA-RISC: NO?  Interesting code, but I think it's a net loss.
> 	PowerPC: yes
> 	S390: sometimes (CONFIG_HAVE_MARCH_Z9_109_FEATURES)
> 	Score: NO
> 	SH: NO
> 	SPARC: NO
SPARC: sparc64: YES, sparc32: NO
Patch needs to be updated to refelct this.

	Sam
