From: Russell King - ARM Linux <linux@armlinux.org.uk>
Date: Tue, 31 May 2016 14:21:42 +0000
Subject: Re: [RFT PATCH 1/2] serial: Fix console setup section mismatch
Message-Id: <20160531142142.GX19428@n2100.arm.linux.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <1464704372-17668-1-git-send-email-k.kozlowski@samsung.com>
In-Reply-To: <1464704372-17668-1-git-send-email-k.kozlowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, May 31, 2016 at 04:19:31PM +0200, Krzysztof Kozlowski wrote:
> Remove __init annotation from all of console->setup implementations
> because:
> 1. The pointer to it is stored in a struct console which is not
>    marked with __initdata.
> 2. It is referenced by register_console() from kernel which is not
>    marked with __init.

However, many of these drivers, the console can only be used when the
driver is built-in, and register_console() is only called early in
initialisation.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
