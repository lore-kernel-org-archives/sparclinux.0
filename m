From: David Miller <davem@davemloft.net>
Date: Wed, 20 Feb 2013 06:41:37 +0000
Subject: Re: THP bug and crash on sparc64 3.8
Message-Id: <20130220.014137.1184382041985855584.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20130219.143320.1413047009797673492.davem@davemloft.net>
	<alpine.DEB.2.02.1302191134570.790@chino.kir.corp.google.com>
	<20130219.144608.1425049879680985441.davem@davemloft.net>
In-Reply-To: <20130219.144608.1425049879680985441.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: rientjes@google.com
Cc: mroos@ut.ee, linux-mm@vger.kernel.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org


Ok I've written an alternative version of the fix that I've been busy
testing all evening.

I think it's much better and it's about to be posted as a series of 3
patches.

Thanks.
