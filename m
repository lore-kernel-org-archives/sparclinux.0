From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Fri, 03 Apr 2015 21:51:54 +0000
Subject: Re: [PATCH v8 RFC 1/3] sparc: Break up monolithic iommu table/lock into finer graularity pools and l
Message-Id: <20150403215154.GK26158@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1427761300.git.sowmini.varadhan@oracle.com>
 <8406d119fb885255387a400551de994cb4a4c331.1427761300.git.sowmini.varadhan@oracle.com>
 <1428008044.20500.272.camel@kernel.crashing.org>
 <20150403182852.GI26158@oracle.com>
 <1428095210.20500.291.camel@kernel.crashing.org>
In-Reply-To: <1428095210.20500.291.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: aik@au1.ibm.com, anton@au1.ibm.com, paulus@samba.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net

On (04/04/15 08:06), Benjamin Herrenschmidt wrote:
> 
> No, I meant "n < pool->hint", ie, the start of the newly allocated
> block.

ah, got it. I'll do my drill with patchset and get back, probably by
Monday.

--Sowmini
