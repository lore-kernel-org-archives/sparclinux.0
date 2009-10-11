From: kristoffer@gaisler.com
Date: Sun, 11 Oct 2009 09:22:20 +0000
Subject: Re: page_to_phys
Message-Id: <20091011052220.5izspnz2ybk0kckk@webmail.bluegenesis.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4ACF4266.6000702@gaisler.com>
In-Reply-To: <4ACF4266.6000702@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org



Quoting David Miller <davem@davemloft.net>:

>
> Sparc 32-bit doesn't offset the mem_map at phys_base. 
>
> What is offset by phys_base is what gets mapped at PAGE_OFFSET
> virtually. 
>

Thanks for the clarification. Got temporarily confused. :-)

Best regards,
Kristoffer Glembo


