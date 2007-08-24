From: David Miller <davem@davemloft.net>
Date: Fri, 24 Aug 2007 21:41:53 +0000
Subject: Re: errno codes intertwined
Message-Id: <20070824.144153.48812936.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0708241815540.28540@fbirervta.pbzchgretzou.qr>
In-Reply-To: <Pine.LNX.4.64.0708241815540.28540@fbirervta.pbzchgretzou.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jengelh@computergmbh.de
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, parisc-linux@parisc-linux.org

From: Jan Engelhardt <jengelh@computergmbh.de>
Date: Fri, 24 Aug 2007 18:24:48 +0200 (CEST)

> So I'm just asking: can I rely on the same errno across Linuxes?
> And should the errno values be fixed up?

You cannot rely on error numbers being the same, every
architecture has something to a few to many differences
in this area.

