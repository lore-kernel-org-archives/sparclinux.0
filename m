From: "David S. Miller" <davem@redhat.com>
Date: Sat, 21 Feb 2004 03:37:28 +0000
Subject: Re: using perfctr to determine cache miss rate
Message-Id: <20040220193728.1a189b35.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <87u11l6rp8.fsf@uga.edu>
In-Reply-To: <87u11l6rp8.fsf@uga.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, 20 Feb 2004 22:23:47 -0500
Ed L Cashin <ecashin@uga.edu> wrote:

> Is there a way to measure the number of memory accesses (both reads
> and writes) that are not hitting in any cache?  It appears not to be
> possible, since only two events can be observed at once, and the
> events are quite specific (e.g. observing dcache write hits makes
> dcache read hits unobservable).

That's right, this is one of the limitations, since you only sample
two events there are certain things you can't sample in one go.
You could run multiple times, sampling different events each time,
but the results won't be so accurate.
