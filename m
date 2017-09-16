From: David Miller <davem@davemloft.net>
Date: Sat, 16 Sep 2017 06:08:38 +0000
Subject: Re: [PATCH] Expose some h/w info from ILOM to userspace via sysfs
Message-Id: <20170915.230838.1519702385714790065.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <baf0b81a-0265-ed20-52c8-e5c558f62c47@oracle.com>
In-Reply-To: <baf0b81a-0265-ed20-52c8-e5c558f62c47@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Eric Saint Etienne <eric.saint.etienne@oracle.com>
Date: Sat, 16 Sep 2017 05:42:41 +0100

> To get a snapshot as complete as possible of what the system is
> composed of,
> this commit adds the ability to retrieve a set of hardware details
> that are only
> available to the ILOM and export them via sysfs to userspace programs
> and
> utilities. Not all the ILOM properties are exposed, only a subset
> useful to
> system utilities.

Again, patch is whitespace damaged, and a model like /dev/mdesc
is better for this.
