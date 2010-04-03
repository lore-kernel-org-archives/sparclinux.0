From: David Miller <davem@davemloft.net>
Date: Sat, 03 Apr 2010 20:50:29 +0000
Subject: Re: [PATCH] sparc64: Fix array size reported by vmemmap_populate()
Message-Id: <20100403.135029.130833859.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1270327280.12516.368.camel@localhost>
In-Reply-To: <1270327280.12516.368.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Ben Hutchings <ben@decadent.org.uk>
Date: Sat, 03 Apr 2010 21:41:20 +0100

> vmemmap_populate() attempts to report the used index and total size of
> vmemmap_table, but it wrongly shifts the total size so that it is
> always shown as 0.
> 
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>

It's not the total, size, it's the total number of chunks that
the area supports.

So it's trying to say:

	entry=${NUM_CHUNKS}/${MAX_CHUNKS}

So I think the printk statement is correct and if you check
you'll find that every other vmemmap supporting platform
has this same printk statement.
