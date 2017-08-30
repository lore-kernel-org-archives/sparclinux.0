From: Pasha Tatashin <pasha.tatashin@oracle.com>
Date: Wed, 30 Aug 2017 13:19:58 +0000
Subject: Re: [PATCH v7 07/11] sparc64: optimized struct page zeroing
Message-Id: <e07c05b1-c0be-bf7f-9a29-11dc41b79d10@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1503972142-289376-1-git-send-email-pasha.tatashin@oracle.com>
 <1503972142-289376-8-git-send-email-pasha.tatashin@oracle.com>
 <20170829.181208.171985548699678313.davem@davemloft.net>
In-Reply-To: <20170829.181208.171985548699678313.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Dave,

Thank you for acking.

The reason I am not doing initializing stores is because they require a 
membar, even if only regular stores are following (I hoped to do a 
membar before first load). This is something I was thinking was not 
true, but after consulting with colleagues and checking processor 
manual, I verified that it is the case.

Pasha

> 
> You should probably use initializing stores when you are doing 8
> stores and we thus know the page struct is cache line aligned.
> 
> But other than that:
> 
> Acked-by: David S. Miller <davem@davemloft.net>
