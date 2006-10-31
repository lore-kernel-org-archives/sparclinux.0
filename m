From: David Miller <davem@davemloft.net>
Date: Tue, 31 Oct 2006 21:51:48 +0000
Subject: Re: serial port registration messages
Message-Id: <20061031.135148.85410184.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0610311728060.27442@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0610311728060.27442@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Tue, 31 Oct 2006 17:40:35 +0200 (EET)

> Maybe we should just increase the buffer size (too)?

It's not just about buffer sizes, it's about uniqueness
and the only unique thing amongst all PROM devices is
the PROM node number, so that's what we must use as the
ID.
