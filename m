From: Meelis Roos <mroos@linux.ee>
Date: Wed, 23 Mar 2005 12:58:45 +0000
Subject: Re: sunbmac panic when no card present
Message-Id: <Pine.SOC.4.61.0503231458150.5000@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0503221030220.29185@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0503221030220.29185@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> There are three such prom_getintdefault() calls in bigmac_ether_init(),
> Meelis can you try commenting them out one by one to see which one triggers
> the crash?  Perhaps that bp->qec_sdev or bp->bigmac_sdev pointers are
> corrupt or point to structures which don't have their prom_node values
> setup properly.  A comparison of the prom_node values with /usr/sbin/prtconf -pv
> output would determine this.

Will test now that my 2.4 compile has finished.

-- 
Meelis Roos
