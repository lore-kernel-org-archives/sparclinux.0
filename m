From: "C.Newport" <crn@netunix.com>
Date: Wed, 31 Mar 2004 00:25:25 +0000
Subject: Re: Compiling sunlance as a module
Message-Id: <200403310125.25888.crn@netunix.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040330234412.GB5439@artsapartment.org>
In-Reply-To: <20040330234412.GB5439@artsapartment.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wednesday 31 March 2004 12:44 am, Art Haas wrote:
> Hi.
>
> I'm still fiddling around with my configuration for my SS20, and I found
> that compiling the sunlance.c file as a module has problems. 
[snip]
> I seek enlightenment from the list.

All supported 32bit sparc machines come with a sunlance NIC, so
why would you want this as a module ?. You are always going to
need it.

There is a slightly more obscure issue here - Not all Sun machines
have a working CD drive so the ability to boot from the network for
both installations and troubleshooting is highly desireable. 
Booting from a device which needs a module is not a good idea.

  

