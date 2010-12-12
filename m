From: David Miller <davem@davemloft.net>
Date: Sun, 12 Dec 2010 22:52:31 +0000
Subject: Re: [RFC 4/8] sparc: prom: Remove unused definition of prom_stdin
Message-Id: <20101212.145231.70187160.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4CF9BC2E.9050300@julian.is-a-geek.org>
In-Reply-To: <4CF9BC2E.9050300@julian.is-a-geek.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Julian Calaby <jcalaby@julian.is-a-geek.org>
Date: Sat, 04 Dec 2010 14:57:34 +1100

> Signed-off-by: Julian Calaby <julian.calaby@gmail.com>

prom_stdin is still assigned (unnecessarily) in init_64.c so we
really can remove this thing completely.

I'll make a patch which does that.
