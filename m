From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Fri, 25 Nov 2016 12:32:28 +0000
Subject: Re: [patch] sparc64: enable IRQs on error paths
Message-Id: <20161125123228.GA7578@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20161125111054.GE5938@mwanda>
In-Reply-To: <20161125111054.GE5938@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org

On (11/25/16 14:12), Dan Carpenter wrote:
> There are several error paths where we should enable IRQs but we don't.
> 
> Fixes: bb620c3d3925 ("sparc: Make sparc64 use scalable lib/iommu-common.c functions")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

I dont have any problem with the fix, but the commit id flagged in
"Fixes" is inaccurate- this problem pre-existed before bb620c3d3925.

I think 6a32fd4d is the commit  that this Fixes.

--Sowmini

