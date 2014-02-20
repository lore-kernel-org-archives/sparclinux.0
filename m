From: David Miller <davem@davemloft.net>
Date: Thu, 20 Feb 2014 00:44:24 +0000
Subject: Re: [PATCH 2/2] sparc64 - add mem to iomem resource
Message-Id: <20140219.194424.926635714703329586.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1392750679-6966-2-git-send-email-bpicco@meloft.net>
In-Reply-To: <1392750679-6966-2-git-send-email-bpicco@meloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bob Picco <bpicco@meloft.net>
Date: Tue, 18 Feb 2014 14:11:19 -0500

> From: bob picco <bpicco@meloft.net>
> 
> This patch adds sparc RAM to /proc/iomem. It also identifies the
> code, data and bss regions of the kernel.
> 
> Signed-off-by: Bob Picco <bob.picco@oracle.com>

As I mentioned in your patch #1, there is no need for this.
