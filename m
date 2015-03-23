From: David Miller <davem@davemloft.net>
Date: Mon, 23 Mar 2015 19:05:08 +0000
Subject: Re: Generic IOMMU pooled allocator
Message-Id: <20150323.150508.149509757161802782.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20150322192726.GB19474@oracle.com>
 <20150323.122922.887448418154237329.davem@davemloft.net>
 <20150323165406.GG14061@oracle.com>
In-Reply-To: <20150323165406.GG14061@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sowmini.varadhan@oracle.com
Cc: aik@au1.ibm.com, aik@ozlabs.ru, anton@au1.ibm.com, paulus@samba.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Mon, 23 Mar 2015 12:54:06 -0400

> If it was only an optimization (i.e., removing it would not break
> any functionality), and if this was done for older hardware,
> and *if* we believe that the direction of most architectures is to 
> follow the sun4v/HV model, then, given that the sun4u code only uses 1 
> arena pool anyway, one thought that I have for refactoring this
> is the following:

Why add performance regressions to old machines who already are
suffering too much from all the bloat we are constantly adding to the
kernel?
