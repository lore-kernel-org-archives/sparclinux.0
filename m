From: David Miller <davem@davemloft.net>
Date: Tue, 27 Dec 2011 22:28:21 +0000
Subject: Re: [PATCH 1/1] apbuart: fix section mismatch warning
Message-Id: <20111227.172821.1725120373383509250.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20111227212253.GA8161@merkur.ravnborg.org>
In-Reply-To: <20111227212253.GA8161@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 27 Dec 2011 23:20:46 +0100

> In the places I found the of_device_id() was passed to for
> example of_platform_bus_probe() which was only called at __init time.
> And the function did not save the argument.
> 
> So at least some call sites are OK.

Ok, good to know.
