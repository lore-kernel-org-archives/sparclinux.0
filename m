From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 20 Apr 2015 00:48:07 +0000
Subject: Re: [PATCH 1/2] iommu-common: fix x86_64 compiler warnings
Message-Id: <55344CC7.7010600@roeck-us.net>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1429458174.git.sowmini.varadhan@oracle.com> <3169f099e5811c8f77813b0fa8c9a12e1d5314c0.1429458174.git.sowmini.varadhan@oracle.com>
In-Reply-To: <3169f099e5811c8f77813b0fa8c9a12e1d5314c0.1429458174.git.sowmini.varadhan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sowmini Varadhan <sowmini.varadhan@oracle.com>, sparclinux@vger.kernel.org
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org

On 04/19/2015 10:13 AM, Sowmini Varadhan wrote:
> Declare iommu_large_alloc as static. Remove extern definition  for
> iommu_tbl_pool_init().
>
> Signed-off-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>

Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>

