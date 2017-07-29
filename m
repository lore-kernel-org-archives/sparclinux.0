From: David Miller <davem@davemloft.net>
Date: Sat, 29 Jul 2017 21:05:46 +0000
Subject: Re: [PATCH v3] sparc64: Increase max_phys_bits to 51 and VA bits to 53 for M8.
Message-Id: <20170729.140546.696467137007484976.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1501291772-470855-1-git-send-email-vijay.ac.kumar@oracle.com>
In-Reply-To: <1501291772-470855-1-git-send-email-vijay.ac.kumar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Vijay Kumar <vijay.ac.kumar@oracle.com>
Date: Fri, 28 Jul 2017 19:29:32 -0600

> On M8 chips, use a max_phys_bits value of 51.
> 
> Also, M8 supports VA bits up to 54 bits. However, for now
> restrict VA bits to 53 due to 4-level pagetable limitation.
> 
> Signed-off-by: Vijay Kumar <vijay.ac.kumar@oracle.com>
> Reviewed-by: Bob Picco <bob.picco@oracle.com>

Applied.
