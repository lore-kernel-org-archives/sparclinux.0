From: "David S. Miller" <davem@davemloft.net>
Date: Wed, 23 Mar 2005 03:02:58 +0000
Subject: Re: sunbmac panic when no card present
Message-Id: <20050322190258.5253f49e.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0503221030220.29185@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0503221030220.29185@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, 22 Mar 2005 18:55:38 -0800
Eric Brower <ebrower@gmail.com> wrote:

> I'm assuming your "qe/be" card is actually installed in this system, correct?

I think it is.  The kernel is crashing on a prom_getproplen() call,
probably on a bogus prom node key, this is happening via prom_getintdefault().

There are three such prom_getintdefault() calls in bigmac_ether_init(),
Meelis can you try commenting them out one by one to see which one triggers
the crash?  Perhaps that bp->qec_sdev or bp->bigmac_sdev pointers are
corrupt or point to structures which don't have their prom_node values
setup properly.  A comparison of the prom_node values with /usr/sbin/prtconf -pv
output would determine this.
