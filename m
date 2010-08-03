From: Jason Wessel <jason.wessel@windriver.com>
Date: Tue, 03 Aug 2010 11:58:24 +0000
Subject: Re: kgdb/sunhv patch
Message-Id: <4C580460.3080805@windriver.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20100803.003508.35833306.davem@davemloft.net>
In-Reply-To: <20100803.003508.35833306.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 08/03/2010 02:35 AM, David Miller wrote:
> This change makes no sense.
>
> The hypervisor console is never hooked up to a real "UART" where
> a kgdb client could be sitting at the other end.
>
> Rather, it's always just a path for characters to and from the
> hypervisor console device which is a virtual device in the guest
> system.
>   
I will most certainly drop the patch per your request.

I am not exactly sure how the large Sun systems are hooked up at our lab
because I have never actually seen one in person.  My understand was
that it was hook up something like this:

Developer pc --->  RS232 Terminal Server ---> Big Sun System HV --->
Linux Guest

After using the console polling driver we were able to debug the guest
Linux.   It was also using an alternate escape sequence (not sysrq) so
as not to send an interrupt to the hypervisor.   In this case you don't
actually need a uart but just an interface down to the guest kernel.  
It is my understanding you can also now use kdb with this interace.

Jason.


