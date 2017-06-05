From: David Miller <davem@davemloft.net>
Date: Mon, 05 Jun 2017 20:24:37 +0000
Subject: Re: [v1 5/6] sparc64: new context wrap
Message-Id: <20170605.162437.147811943419915807.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1496244325-180257-6-git-send-email-pasha.tatashin@oracle.com>
In-Reply-To: <1496244325-180257-6-git-send-email-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Pasha Tatashin <pasha.tatashin@oracle.com>
Date: Mon, 5 Jun 2017 16:10:04 -0400

> Going through NCPU proportional loop for xcall purpose or 'mm'
> pointers is a fundamental limitation when there is only one global
> context counter per system. To solve this limitation would be a
> different project: we will need multiple context counters per system:
> up-to one per core. Bob Picco is working on adding this support. In
> that case the loop sizes are going to be bound by:
> NCPU / (# context domains)

I see, I think MIPS uses per-cpu context IDs, perhaps you can see how
they handle this.

Thanks.
