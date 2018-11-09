From: David Miller <davem@davemloft.net>
Date: Fri, 09 Nov 2018 03:13:20 +0000
Subject: Re: [PATCH 3/8] sparc: prom: use property "name" directly to construct node names
Message-Id: <20181108.191320.1503108955211963619.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20181107223151.14991-1-robh@kernel.org>
        <20181107223151.14991-4-robh@kernel.org>
In-Reply-To: <20181107223151.14991-4-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: robh@kernel.org
Cc: frowand.list@gmail.com, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Rob Herring <robh@kernel.org>
Date: Wed,  7 Nov 2018 16:31:46 -0600

> In preparation to remove direct accesses to the device_node.name
> pointer, retrieve the node name from the "name" property instead.
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: sparclinux@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

On some 32-bit sparcs, the OF runs in non-cached memory.

Sucking in the OF device tree take a signficant amount of the
boot time on such systems.

And these changes are going to make it even slower.

Please just put a wrapper around dp->name or whatever and use that,
instead of making more get property OF calls which can be very
expensive.
