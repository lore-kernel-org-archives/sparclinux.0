From: David Miller <davem@davemloft.net>
Date: Tue, 03 Aug 2010 13:06:50 +0000
Subject: Re: kgdb/sunhv patch
Message-Id: <20100803.060650.22046866.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100803.003508.35833306.davem@davemloft.net>
In-Reply-To: <20100803.003508.35833306.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jason Wessel <jason.wessel@windriver.com>
Date: Tue, 03 Aug 2010 06:58:24 -0500

> I am not exactly sure how the large Sun systems are hooked up at our lab
> because I have never actually seen one in person.  My understand was
> that it was hook up something like this:
> 
> Developer pc --->  RS232 Terminal Server ---> Big Sun System HV --->
> Linux Guest

You can access the hypervisor console over the RS232 port, but most
of the time people use the ethernet port to access the system
console.
