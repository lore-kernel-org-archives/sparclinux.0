From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 20 Apr 2015 00:50:19 +0000
Subject: Re: [PATCH 2/2] iommu-common: rename iommu_pool_hash to iommu_hash_common
Message-Id: <55344D4B.6080603@roeck-us.net>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1429458174.git.sowmini.varadhan@oracle.com> <b170eb1ca5dbe92a4f4dd0ac7e0c3e84a6e14464.1429458174.git.sowmini.varadhan@oracle.com>
In-Reply-To: <b170eb1ca5dbe92a4f4dd0ac7e0c3e84a6e14464.1429458174.git.sowmini.varadhan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sowmini Varadhan <sowmini.varadhan@oracle.com>, sparclinux@vger.kernel.org
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org

On 04/19/2015 10:13 AM, Sowmini Varadhan wrote:
> When CONFIG_DEBUG_FORCE_WEAK_PER_CPU is set, the DEFINE_PER_CPU_SECTION
> macro will define an extern __pcpu_unique_##name variable that could
> conflict with the same definition in powerpc at this time. Avoid that
> conflict by renaming iommu_pool_hash in iommu-common.c
>
> Thanks to Guenter Roeck for catching this, and helping to test the fix.
>
> Signed-off-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>

Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>

