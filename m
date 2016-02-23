From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Tue, 23 Feb 2016 23:59:46 +0000
Subject: Re: Invalid sk_policy[] access
Message-Id: <20160223235946.GE4941@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20160223.152045.440181358695767083.davem@davemloft.net>
 <20160223202901.GC4941@oracle.com>
 <alpine.LRH.2.20.1602232250000.30129@math.ut.ee>
 <20160223.175901.15624631458340642.davem@davemloft.net>
In-Reply-To: <20160223.175901.15624631458340642.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: mroos@linux.ee, sparclinux@vger.kernel.org, edumazet@google.com, netdev@vger.kernel.org

> > Since there are no config-dependent difference in the struct, maybe it's 
> > a compiler version difference for padding/optimization instead?
> 
> Changing the layout of a structure would break ABI, so unlikely.
> 
> I've never used crash, so I have no idea where it gets it's
> information from nor how it interprets it.

fwiw, I applied the exact same printk to the T5, namely,

                printk(KERN_INFO "sizeof sock %ld \n"
                        "sizeof request_sock %ld\n"
                        "sizeof inet_request_sock %ld\n"
                        "offsetof sk_policy 1 %ld\n",
                        sizeof (struct sock), sizeof (struct request_sock),
                        sizeof (struct inet_request_sock),
                        offsetof(struct sock, sk_policy[1]));

and got this:

   sizeof sock 1216 
   sizeof request_sock 312
   sizeof inet_request_sock 328
   offsetof sk_policy 1 520

So it's good to know that crash does not lie.

But then it's odd that the struct sizes (esp of things like 
request_sock, which are not config dependant) are not the same.

--Sowmini

