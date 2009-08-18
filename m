From: David Miller <davem@davemloft.net>
Date: Tue, 18 Aug 2009 01:39:21 +0000
Subject: Re: sparc-leon patches round 5 (to follow) (right numbering)
Message-Id: <20090817.183921.84673342.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20090802.195140.26174602.davem@davemloft.net>
In-Reply-To: <20090802.195140.26174602.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Konrad Eisele <konrad@gaisler.com>
Date: Mon, 17 Aug 2009 12:27:32 +0200

> Hi,
> 
>> arch/sparc/kernel/built-in.o: In function `leon_node_init':
>> (.init.text+0x29c4): undefined reference to `_amba_init'
> 
> I posted the patchset version 6 (see mailing list). This time
> _amba_init() is not called directly. I had to use another aproach
> than the XXX_initcall() aproach that Thomas Boegendoerfer suggested:
> leon_node_init() is called too early in the boot process
> (main()->setup_arch()->paging_init()->prom_build_devicetree()..) and
> as far as I understand it there is no xxx_initcall() that gets
> called that early => therefore I used a callback instead:

Ok.

I applied all of the Leon patches, thanks a lot.

