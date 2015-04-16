From: David Miller <davem@davemloft.net>
Date: Thu, 16 Apr 2015 19:46:45 +0000
Subject: Re: [PATCH v10 0/3] Generic IOMMU pooled allocator
Message-Id: <20150416.154645.1793237575915320132.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1428605063.git.sowmini.varadhan@oracle.com>
In-Reply-To: <cover.1428605063.git.sowmini.varadhan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sowmini.varadhan@oracle.com
Cc: aik@au1.ibm.com, anton@au1.ibm.com, paulus@samba.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Thu,  9 Apr 2015 15:33:29 -0400

> Investigation of network performance on Sparc shows a high
> degree of locking contention in the IOMMU allocator, and it
> was noticed that the PowerPC code has a better locking model.
> 
> This patch series tries to extract the generic parts of the 
> PowerPC code so that it can be shared across multiple PCI
> devices and architectures.

Series applied, thanks everyone for all the hard work!
