From: David Miller <davem@davemloft.net>
Date: Sat, 16 Sep 2017 06:08:10 +0000
Subject: Re: [PATCH] sparc64: Expose mdesc to sysfs
Message-Id: <20170915.230810.408726316514348025.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
In-Reply-To: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Eric Saint Etienne <eric.saint.etienne@oracle.com>
Date: Sat, 16 Sep 2017 05:36:03 +0100

> To get a snapshot as complete as possible of what the system is
> composed of,
> this commit adds the ability to browse machine description from sysfs.
> 
> This commit eases porting of user-space utilities that exist on other
> architectures
> like lshw for instance.
> 
> Whenever the HV changes machine description content, sysfs will be
> autopmatically
> re-populated. This is done almost atomically by swapping the old mdesc
> sysfs folder
> with the new one. While the tree under the new folder is being
> created, reading from
> /sys/firmware/mdesc will return EAGAIN. That way userspace programs
> will not see
> stale content in /sys/firmware/mdesc
> 
> Signed-off-by: Eric Saint Etienne <eric.saint.etienne@oracle.com>
> Reviewed-by: Dave Aldridge <david.j.aldridge@oracle.com>

Please explain why /dev/mdesc could not be extended to do what you
need, such as sending an event to userspace.

There is absolutely no reason to present a formatted version of
mdesc under sysfs.

That is entirely a userspace problem, where the userspace component
grabs the mdesc via /dev/mdesc and does whatever it wants to do
with that image.

Your patch was also whitespace damaged by your email client.

Thank you.
