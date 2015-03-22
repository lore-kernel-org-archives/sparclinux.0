From: David Miller <davem@davemloft.net>
Date: Sun, 22 Mar 2015 23:54:03 +0000
Subject: Re: 4.0.0-rc4: panic in free_block
Message-Id: <20150322.195403.1653355516554747742.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <CA+55aFwEq09vwnxPEYr67O7nuOEN9_n-uJKX11qSbuBNGJVghg@mail.gmail.com>
	<20150322.182311.109269221031797359.davem@davemloft.net>
	<550F51D5.2010804@oracle.com>
In-Reply-To: <550F51D5.2010804@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: david.ahern@oracle.com
Cc: torvalds@linux-foundation.org, sparclinux@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, bpicco@meloft.net

From: David Ahern <david.ahern@oracle.com>
Date: Sun, 22 Mar 2015 17:35:49 -0600

> I don't know if you caught Bob's message; he has a hack to bypass
> memcpy and memmove in mm/slab.c use a for loop to move entries. With
> the hack he is not seeing the problem.
> 
> This is the hack:
> 
> +static void move_entries(void *dest, void *src, int nr)
> +{
> +       unsigned long *dp = dest;
> +       unsigned long *sp = src;
> +
> +       for (; nr; nr--, dp++, sp++)
> +               *dp = *sp;
> +}
> +
> 
> and then replace the mempy and memmove calls in transfer_objects,
> cache_flusharray and drain_array to use move_entries.
> 
> I just put it on 4.0.0-rc4 and ditto -- problem goes away, so it
> clearly suggests the memcpy or memmove are the root cause.

Thanks, didn't notice that.

So, something is amuck.
