From: David Miller <davem@davemloft.net>
Date: Wed, 25 Mar 2015 18:12:35 +0000
Subject: Re: [PATCH v7 0/3] Generic IOMMU pooled allocator
Message-Id: <20150325.141235.238730018688792495.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1427295804.git.sowmini.varadhan@oracle.com>
In-Reply-To: <cover.1427295804.git.sowmini.varadhan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sowmini.varadhan@oracle.com
Cc: aik@au1.ibm.com, anton@au1.ibm.com, paulus@samba.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Wed, 25 Mar 2015 13:34:45 -0400

> Changes from patchv6: moved pool_hash initialization to
> lib/iommu-common.c and cleaned up code duplication from 
> sun4v/sun4u/ldc. 

Looks good to me.

PowerPC folks, what do you think?
