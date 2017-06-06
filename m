From: David Miller <davem@davemloft.net>
Date: Tue, 06 Jun 2017 20:42:02 +0000
Subject: Re: [PATCH v3] arch/sparc: support NR_CPUS = 4096
Message-Id: <20170606.164202.1936961931658038230.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1496781149-648310-1-git-send-email-jane.chu@oracle.com>
In-Reply-To: <1496781149-648310-1-git-send-email-jane.chu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jane.chu@oracle.com
Cc: tglx@linutronix.de, bob.picco@oracle.com, steven.sistare@oracle.com, atish.patra@oracle.com, Liam.Howlett@oracle.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Jane Chu <jane.chu@oracle.com>
Date: Tue,  6 Jun 2017 14:32:29 -0600

> Linux SPARC64 limits NR_CPUS to 4064 because init_cpu_send_mondo_info()
> only allocates a single page for NR_CPUS mondo entries. Thus we cannot
> use all 4096 CPUs on some SPARC platforms.
> 
> To fix, allocate (2^order) pages where order is set according to the size
> of cpu_list for possible cpus. Since cpu_list_pa and cpu_mondo_block_pa
> are not used in asm code, there are no imm13 offsets from the base PA
> that will break because they can only reach one page.
> 
> Orabug: 25505750
> 
> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> 
> Reviewed-by: Bob Picco <bob.picco@oracle.com>
> Reviewed-by: Atish Patra <atish.patra@oracle.com>

Looks a lot better, applied, thanks!
