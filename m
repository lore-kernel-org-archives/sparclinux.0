From: David Miller <davem@davemloft.net>
Date: Thu, 04 Aug 2011 10:13:56 +0000
Subject: Re: [PATCH 16/23] sparc: Use HAVE_MEMBLOCK_NODE_MAP
Message-Id: <20110804.031356.626082809394107925.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1311694534-5161-1-git-send-email-tj@kernel.org>
	<1311694534-5161-17-git-send-email-tj@kernel.org>
	<20110804095218.GB2731@htj.dyndns.org>
In-Reply-To: <20110804095218.GB2731@htj.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tj@kernel.org
Cc: benh@kernel.crashing.org, yinghai@kernel.org, hpa@zytor.com, tony.luck@intel.com, ralf@linux-mips.org, schwidefsky@de.ibm.com, liqin.chen@sunplusct.com, lethal@linux-sh.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@redhat.com, sparclinux@vger.kernel.org

From: Tejun Heo <tj@kernel.org>
Date: Thu, 4 Aug 2011 11:52:18 +0200

> On Tue, Jul 26, 2011 at 05:35:27PM +0200, Tejun Heo wrote:
>> sparc doesn't access early_node_map[] directly and enabling
>> HAVE_MEMBLOCK_NODE_MAP is trivial - replacing add_active_range() calls
>> with memblock_set_node() and selecting HAVE_MEMBLOCK_NODE_MAP is
>> enough.
>> 
>> Signed-off-by: Tejun Heo <tj@kernel.org>
>> Cc: "David S. Miller" <davem@davemloft.net>
>> Cc: sparclinux@vger.kernel.org
> 
> David just confirmed this worked fine on sparc and was okay with this
> going through tip.

Yep:

Acked-by: David S. Miller <davem@davemloft.net>
