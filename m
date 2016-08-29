From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 29 Aug 2016 16:38:53 +0000
Subject: Re: [PATCH 1/2] sparc: Use kmalloc_array() in three functions
Message-Id: <e7217d5e-44e6-a6fa-33a1-e3c85f0c36bc@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <0ca0235c-ddb9-0534-3bde-b4aaa48da92e@users.sourceforge.net>
 <fbdf6d83-08ac-a6b2-1674-53bc86c69ae8@users.sourceforge.net>
 <4475e65d-415d-9cde-1fe1-c17e120849c4@redhat.com> <57C42335.5000106@bfs.de>
In-Reply-To: <57C42335.5000106@bfs.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: wharms@bfs.de
Cc: SF Markus Elfring <elfring@users.sourceforge.net>, sparclinux@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>



On 29/08/2016 13:57, walter harms wrote:
> > > -	buf = kmalloc(sizeof(char) * (count + 1), GFP_KERNEL);
> > > +	buf = kmalloc_array(count + 1, sizeof(*buf), GFP_KERNEL);
> > >  	if (!buf)
> > >  		return -ENOMEM;
> > >  
> > 
> > Here it's probably best to just remove sizeof(char) completely, as it's
> > 1 by definition.
> 
> I would not do so, if you ever change buf to something else it would break,
> having a sizeof(*buf) here is harmless and a known pattern.

Fair enough, it's not code I maintain.

Paolo
