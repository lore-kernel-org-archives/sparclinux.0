From: "David S. Miller" <davem@davemloft.net>
Date: Wed, 14 Dec 2005 20:32:53 +0000
Subject: Re: 2.6.15.rc5+git fails to boot on Ultra 5
Message-Id: <20051214.123253.49815060.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0512141730370.26778@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0512141730370.26778@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Don't enable CONFIG_CC_OPTIMIZE_FOR_SIZE please.
It builds unusable kernels on sparc64.

I'm pretty sure you turned that on because that trace
is what you get with such a miscompiled kernel.
