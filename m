From: Keith M Wesolowski <wesolows@foobazco.org>
Date: Sun, 04 Jan 2004 22:48:28 +0000
Subject: Re: [SPARC32] Early kernel panic with 2.6.1rc1
Message-Id: <20040104224828.GD5492@foobazco.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1073231988.22653.23.camel@zorak>
In-Reply-To: <1073231988.22653.23.camel@zorak>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Jan 04, 2004 at 04:38:06PM -0600, Tom 'spot' Callaway wrote:

> I went ahead and rebuilt the kernel without the 8250 support enabled,
> and I got both of the oopses in the serial console. Attached is the full
> dmesg (includes oopses), the oopses, and the ksymoops results.

Please send me your .config so I can reproduce this.

> @@ -10,6 +10,7 @@
>  # The new 8250/16550 serial drivers
>  config SERIAL_8250
>  	tristate "8250/16550 and compatible serial support"
> +	depends on !SPARC32
>  	select SERIAL_CORE
>  	---help---
>  	  This selects whether you want to include the driver for the standard

This really isn't the right thing to depend on, although I'm not sure
what is.  This chip is found almost everywhere.

-- 
Keith M Wesolowski <wesolows@foobazco.org> http://foobazco.org/~wesolows
------(( Project Foobazco Coordinator and Network Administrator ))------
	"May Buddha bless all stubborn people!"
				-- Uliassutai Karakorum Blake
