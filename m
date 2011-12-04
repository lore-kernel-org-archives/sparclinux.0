From: David Miller <davem@davemloft.net>
Date: Sun, 04 Dec 2011 19:00:12 +0000
Subject: Re: [PATCH] sparc: Use kmemdup rather than duplicating its
Message-Id: <20111204.140012.2039227798298276086.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1321569820.1624.274.camel@localhost.localdomain>
In-Reply-To: <1321569820.1624.274.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: thomas@m3y3r.de
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Thomas Meyer <thomas@m3y3r.de>
Date: Thu, 17 Nov 2011 23:43:40 +0100

> The semantic patch that makes this change is available
> in scripts/coccinelle/api/memdup.cocci.
> 
> Signed-off-by: Thomas Meyer <thomas@m3y3r.de>

Applied.
