From: Tejun Heo <tj@kernel.org>
Date: Thu, 04 Aug 2011 09:52:18 +0000
Subject: Re: [PATCH 16/23] sparc: Use HAVE_MEMBLOCK_NODE_MAP
Message-Id: <20110804095218.GB2731@htj.dyndns.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1311694534-5161-1-git-send-email-tj@kernel.org>
 <1311694534-5161-17-git-send-email-tj@kernel.org>
In-Reply-To: <1311694534-5161-17-git-send-email-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: benh@kernel.crashing.org, yinghai@kernel.org, hpa@zytor.com, tony.luck@intel.com, ralf@linux-mips.org, schwidefsky@de.ibm.com, liqin.chen@sunplusct.com, lethal@linux-sh.org, davem@dave
Cc: mingo@redhat.com, sparclinux@vger.kernel.org

On Tue, Jul 26, 2011 at 05:35:27PM +0200, Tejun Heo wrote:
> sparc doesn't access early_node_map[] directly and enabling
> HAVE_MEMBLOCK_NODE_MAP is trivial - replacing add_active_range() calls
> with memblock_set_node() and selecting HAVE_MEMBLOCK_NODE_MAP is
> enough.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: sparclinux@vger.kernel.org

David just confirmed this worked fine on sparc and was okay with this
going through tip.

Thanks.

-- 
tejun
