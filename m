From: David Miller <davem@davemloft.net>
Date: Sun, 19 Aug 2012 22:24:45 +0000
Subject: Re: [PATCH] silo: Don't touch %tick_cmpr on sun4v cpus.
Message-Id: <20120819.152445.110365253381974516.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20120815.011416.353619816610212386.davem@davemloft.net>
In-Reply-To: <20120815.011416.353619816610212386.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jurij Smakov <jurij@wooyd.org>
Date: Sun, 19 Aug 2012 16:41:42 +0100

> I just uploaded a new silo package (1.4.14+git20120819-1) including 
> these fixes to unstable, and would encourage everyone to test it (it 
> should appear on the mirrors within a few hours). After a grace period 
> of 10 days we are going to arrange for its propagation to testing, 
> given that no problems are reported.

Thanks a lot Jurij.

Just FYI I also pushed a ext4 fix into the SILO tree yesterday
after I received positive feedback from a bug reporter.
