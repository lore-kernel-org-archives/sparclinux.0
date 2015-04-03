From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Fri, 03 Apr 2015 18:28:52 +0000
Subject: Re: [PATCH v8 RFC 1/3] sparc: Break up monolithic iommu table/lock into finer graularity pools and l
Message-Id: <20150403182852.GI26158@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1427761300.git.sowmini.varadhan@oracle.com>
 <8406d119fb885255387a400551de994cb4a4c331.1427761300.git.sowmini.varadhan@oracle.com>
 <1428008044.20500.272.camel@kernel.crashing.org>
In-Reply-To: <1428008044.20500.272.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: aik@au1.ibm.com, anton@au1.ibm.com, paulus@samba.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net



Just want to confirm:

> > + again:
> > +	if (pass = 0 && handle && *handle &&
> > +	    (*handle >= pool->start) && (*handle < pool->end))
> > +		start = *handle;
> > +	else
> > +		start = pool->hint;
> 
> Now this means "handle" might be < pool->hint, in that case you also
> need a lazy flush. Or rather only if the resulting alloc is. My
         :

> > +		} else {
> > +			/* give up */
> > +			n = DMA_ERROR_CODE;
> > +			goto bail;
> > +		}
> > +	}
> 
> Here, make this something like:
> 
> 	} else if (end < pool->hint)
> 		need_flush = true;

you mean 

 	} else if (start < pool->hint)

right?  (so I'm not missing some corner-case that you are thinking
about here)

--Sowmini
 
