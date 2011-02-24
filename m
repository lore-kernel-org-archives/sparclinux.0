From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 24 Feb 2011 16:34:24 +0000
Subject: Re: [RFC PATCH 13/15] dt/serial: Eliminate users of of_platform_{, un}register_driver
Message-Id: <201102241734.25048.arnd@arndb.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20110223043015.20795.37090.stgit@localhost6.localdomain6>
	<20110223043442.20795.4037.stgit@localhost6.localdomain6>
In-Reply-To: <20110223043442.20795.4037.stgit-bi+AKbBUZKagILUCTcTcHdKyNwTtLsGr@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Cc: sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org

On Wednesday 23 February 2011, Grant Likely wrote:
> Get rid of users of of_platform_driver in drivers/serial.  The
> of_platform_{,un}register_driver functions are going away, so the
> users need to be converted to using the platform_bus_type directly.
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

of_serial changes look good.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

