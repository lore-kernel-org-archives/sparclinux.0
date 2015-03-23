From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Mon, 23 Mar 2015 19:09:38 +0000
Subject: Re: Generic IOMMU pooled allocator
Message-Id: <20150323190938.GL14061@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20150322192726.GB19474@oracle.com>
 <20150323.122922.887448418154237329.davem@davemloft.net>
 <20150323165406.GG14061@oracle.com>
 <20150323.150508.149509757161802782.davem@davemloft.net>
In-Reply-To: <20150323.150508.149509757161802782.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: aik@au1.ibm.com, aik@ozlabs.ru, anton@au1.ibm.com, paulus@samba.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

On (03/23/15 15:05), David Miller wrote:
> 
> Why add performance regressions to old machines who already are
> suffering too much from all the bloat we are constantly adding to the
> kernel?

I have no personal opinion on this- it's a matter of  choosing
whether we want to have some extra baggage in the library to support
old hardware, or keep the code lean-and-mean for the future,
where the model has changed.

I'll let others on this list make the call.

--Sowmini

