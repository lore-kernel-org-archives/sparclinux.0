From: David Miller <davem@davemloft.net>
Date: Thu, 03 Oct 2013 17:47:21 +0000
Subject: Re: "Missing cpus node, bailing out" warning on sparc64
Message-Id: <20131003.134721.869856713289661263.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1310031741370.16965@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1310031741370.16965@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Thu, 3 Oct 2013 17:45:35 +0300 (EEST)

> With the introduction of commit 183912d352a242a276a7877852f107459a13aff9 
> (of: move of_get_cpu_node implementation to DT core library), sparc64 
> has been seeing spurious warnings "Missing cpus node, bailing out" for 
> each cpu on boot since there is no /cpus DT node on sparc boxes.
> 
> While I can see no obvious harm, some logic should probably not assume 
> all DT bindings to have /cpus there?

We discussed this already, I plan on implementing, testing, and
submitting a fix.
