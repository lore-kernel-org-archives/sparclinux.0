From: David Miller <davem@davemloft.net>
Date: Fri, 02 Jun 2006 22:19:10 +0000
Subject: Re: [PATCH]: Fix D-cache corruption in mremap()
Message-Id: <20060602.151910.95059746.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20060601.175258.41634623.davem@davemloft.net>
In-Reply-To: <20060601.175258.41634623.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Daniel Smolik <marvin@mydatex.cz>
Date: Fri, 02 Jun 2006 22:18:29 +0200

> May be OK on my E250 ? mmremap stress program never returns is it ok ?
> Problem with dselect is solved. In wich version of kernel will be 
> patch included ?

The program just runs forever until it triggers the bug.
If it runs fine for more than a few seconds you are ok.

Thank you very much for testing.

I plan to put this into 2.6.17 and give it to the 2.6.16-stable folks
as well.  If Chris W. or Greg KH are still doing 2.6.15-stable
releases I'll ask them to toss it into there too.

I'll try to take care of that over the weekend.
