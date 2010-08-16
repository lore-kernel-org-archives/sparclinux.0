From: David Miller <davem@davemloft.net>
Date: Mon, 16 Aug 2010 06:17:58 +0000
Subject: Re: [PATCH 2/3] sparc: make driver/of/pdt no longer sparc-specific
Message-Id: <20100815.231758.241456849.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100809013245.1cefb9bf@dev.queued.net>
	<20100808.223444.62324566.davem@davemloft.net>
	<20100816002244.6ddf37e6@debxo>
In-Reply-To: <20100816002244.6ddf37e6@debxo>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dilinger@queued.net
Cc: grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Andres Salomon <dilinger@queued.net>
Date: Mon, 16 Aug 2010 00:22:44 -0400

> I'm tempted to break the phandle/device_node/property stuff out into a
> separate header (that gets exported), and include that from linux/of.h
> and asm/openprom.h.

We could put just phandle into linux/types.h
