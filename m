From: "David S. Miller" <davem@davemloft.net>
Date: Wed, 17 May 2006 22:41:13 +0000
Subject: Re: klibc and SPARC
Message-Id: <20060517.154113.84542369.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <e4g1ho$dae$1@terminus.zytor.com>
In-Reply-To: <e4g1ho$dae$1@terminus.zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "H. Peter Anvin" <hpa@zytor.com>
Date: Wed, 17 May 2006 15:36:21 -0700

> David S. Miller wrote:
> >> Does it make sense to say that these prom configurations are only
> >> recognized by kinit if openpromfs is available (without which it will
> >> simply behave as on any other platform), or should I go through the
> >> additional trouble of supporting both methods?
> > 
> > You need to enable a particular driver either way,
> > either CONFIG_SUN_OPENPROMFS or CONFIG_SUN_OPENPROMIO.
> > 
> > The NFS configuration bits you are moving into klibc
> > are going to be expected to work even if both of those
> > config options are disabled, it's expected to always
> > be available and work.
>
> Sounds like you're saying I should force one of those drivers
> enabled, is that right?  I'm fine with that.  The other alternative
> is of course to put an ad hoc thing for this thing; that seems
> unnecessarily ugly to me but if necessary I can do that as well.
>
> If I should force one of the drivers enabled, which one should it be
> (I'm assuming CONFIG_SUN_OPENPROMFS?)

How I answer this depends upon why you're moving this out of the
kernel in the first place :-)

I can understand moving as much functionality as is reasonably
possible into userspace via klibc, but for something like this which
has weird dependencies if you move it into userspace and will
undoubtedly force the enabling of what is normally an optional
feature, I don't see moving it into userspace as being so wise.

That being said, openpromfs is the preferred thing to use if
you have to make a choice.
