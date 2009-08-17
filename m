From: Konrad Eisele <konrad@gaisler.com>
Date: Mon, 17 Aug 2009 10:27:32 +0000
Subject: Re: sparc-leon patches round 5 (to follow) (right numbering)
Message-Id: <4A893094.8050400@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20090802.195140.26174602.davem@davemloft.net>
In-Reply-To: <20090802.195140.26174602.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

 > arch/sparc/kernel/built-in.o: In function `leon_node_init':
 > (.init.text+0x29c4): undefined reference to `_amba_init'

I posted the patchset version 6 (see mailing list). This time
_amba_init() is not called directly. I had to use another aproach
than the XXX_initcall() aproach that Thomas Boegendoerfer suggested:
leon_node_init() is called too early in the boot process
(main()->setup_arch()->paging_init()->prom_build_devicetree()..) and
as far as I understand it there is no xxx_initcall() that gets
called that early => therefore I used a callback instead:

...
void __initdata (*prom_amba_init)(struct device_node *dp, struct device_node ***nextp) = 0;
...
	if (prom_amba_init &&
...
		prom_amba_init(dp, nextp);
	}
...


The callback will be initialized by the _bootloader_.

 > When you fix this up and repost the series, do me another favor, try
 > to build the kernel successfully after each and every patch.  With
 > LEON enabled, the tree does not build after patch #3 because srmmu.c
 > doesn't include asm/leon.h yet and thus srmmu_swprobe() isn't declared.

I didnt really undestand this one: The patch is split up in 5 subpatches
that should logically divide the big patch. There guess are dependencies
among the subpatches. The only way I can think of is to send all 5 subpatches
as one big patch.

Is it ok with the version 6 patches that I just sent on the mailing list
anyway? (that is 5 subpatches)?

-- Greetings Konrad


