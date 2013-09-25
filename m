From: David Rientjes <rientjes@google.com>
Date: Wed, 25 Sep 2013 02:35:29 +0000
Subject: Re: [Resend with ACK][PATCH] mm/arch: use NUMA_NODE
Message-Id: <alpine.DEB.2.02.1309241935190.26187@chino.kir.corp.google.com>
List-Id: <sparclinux.vger.kernel.org>
References: <524019D0.9070706@huawei.com>
In-Reply-To: <524019D0.9070706@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, 23 Sep 2013, Jianguo Wu wrote:

> Use more appropriate NUMA_NO_NODE instead of -1 in all archs' module_alloc()
> 
> Signed-off-by: Jianguo Wu <wujianguo@huawei.com>
> Acked-by: Ralf Baechle <ralf@linux-mips.org>

Acked-by: David Rientjes <rientjes@google.com>
