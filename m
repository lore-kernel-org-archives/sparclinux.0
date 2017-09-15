From: Mark Rutland <mark.rutland@arm.com>
Date: Fri, 15 Sep 2017 20:38:53 +0000
Subject: Re: [PATCH v8 10/11] arm64/kasan: explicitly zero kasan shadow memory
Message-Id: <20170915203852.GA10749@remoulade>
List-Id: <sparclinux.vger.kernel.org>
References: <20170914223517.8242-1-pasha.tatashin@oracle.com>
 <20170914223517.8242-11-pasha.tatashin@oracle.com>
 <20170915011035.GA6936@remoulade>
 <c76f72fc-21ed-62d0-014e-8509c0374f96@oracle.com>
In-Reply-To: <c76f72fc-21ed-62d0-014e-8509c0374f96@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Sep 14, 2017 at 09:30:28PM -0400, Pavel Tatashin wrote:
> Hi Mark,
> 
> Thank you for looking at this. We can't do this because page table is not
> set until cpu_replace_ttbr1() is called. So, we can't do memset() on this
> memory until then.

I see. Sorry, I had missed that we were on the temporary tables at this point
in time.

I'm still not keen on duplicating the iteration. Can we split the vmemmap code
so that we have a variant that takes a GFP? 

That way we could explicitly pass __GFP_ZERO for those cases where we want a
zeroed page, and are happy to pay the cost of initialization.

Thanks
Mark.
