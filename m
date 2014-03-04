From: David Miller <davem@davemloft.net>
Date: Tue, 04 Mar 2014 20:44:25 +0000
Subject: Re: [PATCH] sparc64 - add mem to iomem resource
Message-Id: <20140304.154425.1542983020051636702.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1393865682-6856-1-git-send-email-bpicco@meloft.net>
In-Reply-To: <1393865682-6856-1-git-send-email-bpicco@meloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bob Picco <bpicco@meloft.net>
Date: Mon,  3 Mar 2014 11:54:42 -0500

> From: bob picco <bpicco@meloft.net>
> 
> This patch adds sparc RAM to /proc/iomem. It also identifies the
> code, data and bss regions of the kernel.
> 
> Signed-off-by: Bob Picco <bob.picco@oracle.com>

Ok, I'm fine with this patch regardless of what happens with the
other patch.
