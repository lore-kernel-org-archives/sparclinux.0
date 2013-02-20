From: Meelis Roos <mroos@linux.ee>
Date: Wed, 20 Feb 2013 13:35:52 +0000
Subject: Re: THP bug and crash on sparc64 3.8
Message-Id: <alpine.SOC.1.00.1302201437190.20165@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <20130219.143320.1413047009797673492.davem@davemloft.net> <alpine.DEB.2.02.1302191134570.790@chino.kir.corp.google.com> <20130219.144608.1425049879680985441.davem@davemloft.net> <20130220.014137.1184382041985855584.davem@davemloft.net>
In-Reply-To: <20130220.014137.1184382041985855584.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: rientjes@google.com, linux-mm@vger.kernel.org, Linux Kernel list <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org

> Ok I've written an alternative version of the fix that I've been busy
> testing all evening.
> 
> I think it's much better and it's about to be posted as a series of 3
> patches.

Works much better. aptitude worked fine, as did 5 times
cp -a linux test; rm -r linux

However, "git gc" in a copy of the repository hung the machine hard, 
nothing in the logs.

3.8.0 with THP disabled can run both cp;rm and git gc several 
times without a problem.

-- 
Meelis Roos (mroos@linux.ee)
