From: "David S. Miller" <davem@davemloft.net>
Date: Thu, 15 Dec 2005 21:49:10 +0000
Subject: Re: 2.6.15.rc5+git fails to boot on Ultra 5
Message-Id: <20051215.134910.89935616.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0512141730370.26778@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0512141730370.26778@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Thu, 15 Dec 2005 11:28:43 +0200 (EET)

> > I'm pretty sure you turned that on because that trace
> > is what you get with such a miscompiled kernel.
> 
> I turend it on for every machine when I was asked - because Linus told 
> it's faster :-)

It turns out he was comparing "2.6.14 with -O2" to "2.6.15-rc5-GIT
with -Os" lmbench results on his powerpc system.  When he did a
pure 2.6.15-rc5-GIT -O2 vs -Os comparison, the differences were in
the noise.  The kernel is smaller, but not measurably faster.
