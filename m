From: David Miller <davem@davemloft.net>
Date: Wed, 20 Sep 2017 16:24:33 +0000
Subject: Re: [PATCH] Expose some h/w info from ILOM to userspace via sysfs
Message-Id: <20170920.092433.1557479460825383949.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <baf0b81a-0265-ed20-52c8-e5c558f62c47@oracle.com>
In-Reply-To: <baf0b81a-0265-ed20-52c8-e5c558f62c47@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Eric Saint Etienne <eric.saint.etienne@oracle.com>
Date: Wed, 20 Sep 2017 08:04:22 +0100

> 
>> Please give examples.
> 
> There are redundancies with what Linux has figured of the system, for
> example:

And if what the ILOM is reporting differs from what other elements
in the system advertise, wouldn't you be able to diagnose that?

So it would make sense to report this information.

It isn't the same as my other argument.
