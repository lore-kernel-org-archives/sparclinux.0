From: David Miller <davem@davemloft.net>
Date: Wed, 20 Sep 2017 17:01:10 +0000
Subject: Re: [PATCH] Expose some h/w info from ILOM to userspace via sysfs
Message-Id: <20170920.100110.458369833585663983.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <baf0b81a-0265-ed20-52c8-e5c558f62c47@oracle.com>
In-Reply-To: <baf0b81a-0265-ed20-52c8-e5c558f62c47@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Eric Saint Etienne <eric.saint.etienne@oracle.com>
Date: Wed, 20 Sep 2017 17:40:02 +0100

> 
>> And if what the ILOM is reporting differs from what other elements
>> in the system advertise, wouldn't you be able to diagnose that?
> It's a good idea and definitely something that could be added in the
> future.

I'm saying you should export the whole ILOM tree, just as we export
the whole mdesc tree.

So, please do it properly from the start.

You may have to set permissions appropriately for sensitive values,
but that's it.


