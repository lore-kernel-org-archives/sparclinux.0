From: Andi Kleen <ak@suse.de>
Date: Thu, 13 Sep 2007 09:53:32 +0000
Subject: Re: [PATCH 00/10] x86: Reduce Memory Usage and Inter-Node message traffic (v3)
Message-Id: <200709131153.32576.ak@suse.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20070912015644.927677070@sgi.com>
In-Reply-To: <20070912015644.927677070@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: travis@sgi.com
Cc: Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <clameter@sgi.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, sparclinux@vger.kernel.org

On Wednesday 12 September 2007 03:56, travis@sgi.com wrote:
> Note:
>
> This patch consolidates all the previous patches regarding
> the conversion of static arrays sized by NR_CPUS into per_cpu
> data arrays and is referenced against 2.6.23-rc6 .


Looks good to me from the x86 side. I'll leave it to Andrew to
handle for now though because it touches too many files
outside x86.

-Andi
