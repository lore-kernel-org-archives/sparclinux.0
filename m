From: David Miller <davem@davemloft.net>
Date: Wed, 22 Oct 2008 05:03:14 +0000
Subject: Re: [PATCH] sparc: Add checkstack support
Message-Id: <20081021.220314.199655159.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20081021052309.GA26928@palantir8>
In-Reply-To: <20081021052309.GA26928@palantir8>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Tue, 21 Oct 2008 06:23:09 +0100

> Add sparc support to checkstack.
> 
> 	Signed-off-by: Martin Habets <errandir_news@mph.eclipse.co.uk>

This regex works for sparc64 too, so I added that to the arch
string match while applying this.

Thanks!
