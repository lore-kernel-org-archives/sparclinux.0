From: David Rientjes <rientjes@google.com>
Date: Mon, 09 Apr 2018 20:08:31 +0000
Subject: Re: [PATCH 2/3] mm: replace __HAVE_ARCH_PTE_SPECIAL
Message-Id: <alpine.DEB.2.21.1804091307480.56406@chino.kir.corp.google.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1523282229-20731-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1523282229-20731-3-git-send-email-ldufour@linux.vnet.ibm.com>
 <20180409175757.GA12938@infradead.org>
In-Reply-To: <20180409175757.GA12938@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, 9 Apr 2018, Christoph Hellwig wrote:

> > -#ifdef __HAVE_ARCH_PTE_SPECIAL
> > +#ifdef CONFIG_ARCH_HAS_PTE_SPECIAL
> >  # define HAVE_PTE_SPECIAL 1
> >  #else
> >  # define HAVE_PTE_SPECIAL 0
> 
> I'd say kill this odd indirection and just use the
> CONFIG_ARCH_HAS_PTE_SPECIAL symbol directly.
> 
> 

Agree, and I think it would be easier to audit/review if patches 1 and 3 
were folded together to see the relationship between the newly added 
selects and what #define's it is replacing.  Otherwise, looks good!
