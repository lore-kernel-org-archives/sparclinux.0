From: Rob Herring <robh@kernel.org>
Date: Fri, 09 Nov 2018 13:02:46 +0000
Subject: Re: [PATCH 3/8] sparc: prom: use property "name" directly to construct node names
Message-Id: <CAL_Jsq+VAkCmEpHKK-D8SjJ2pVuTbXuVVbLzpjKyOQY-jvmG8g@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20181107223151.14991-1-robh@kernel.org> <20181107223151.14991-4-robh@kernel.org>
 <20181108.191320.1503108955211963619.davem@davemloft.net>
In-Reply-To: <20181108.191320.1503108955211963619.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: Frank Rowand <frowand.list@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org

On Thu, Nov 8, 2018 at 9:13 PM David Miller <davem@davemloft.net> wrote:
>
> From: Rob Herring <robh@kernel.org>
> Date: Wed,  7 Nov 2018 16:31:46 -0600
>
> > In preparation to remove direct accesses to the device_node.name
> > pointer, retrieve the node name from the "name" property instead.
> >
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: sparclinux@vger.kernel.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
>
> On some 32-bit sparcs, the OF runs in non-cached memory.
>
> Sucking in the OF device tree take a signficant amount of the
> boot time on such systems.
>
> And these changes are going to make it even slower.
>
> Please just put a wrapper around dp->name or whatever and use that,
> instead of making more get property OF calls which can be very
> expensive.

It's not making calls into OF. It is retrieving the property from the
kernel's copy of the DT (allocated by memblock). So the only
difference is we have to walk the struct property list to find "name".
That's perhaps offset by the fact that we'll be doing one less
property retrieval from OF when this is all done. Right now, we
retrieve "name" from OF twice per node.

Rob
