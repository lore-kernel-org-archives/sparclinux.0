Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5753DB303;
	Fri, 31 Jul 2026 12:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785499368; cv=none; b=qzJJeWtWn3aO6yOwqooCzg57B5f1mZXTOT4DLMa5iaCldYed2W8xi+NG/YSvlQtgZ9POr6xpOl0Io+SzhH59+rJi3B+hm1IUhfxY5Uk9JsD7yLwm6xP0w9eYwxojc72BO6Gz9PQ1bM1dfSijEtGwREXddCa0c3+2a2SFp6mtjJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785499368; c=relaxed/simple;
	bh=YsoHqoCT8q75aHibkwXI4goLzTmSMzcs5r0ko7Esuhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lFQfJaI0q+J8qEaSC6+fS08wyclrLg8yhi43sXpRbyrox6t9NQl3kkf3rIZmS/ZfWWZfugfCivWxw4FhhAU0l2M1To5YsLPa3Y6RMA7NAJjUuwga26tQsGrQCec9Mil270A6OGz3JE24OvnHeB9c2Kyl6RRcYi6Dbh25/mqL470=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V1pdBJwl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V1pdBJwl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 489561F000E9;
	Fri, 31 Jul 2026 12:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785499366;
	bh=Kyh3YtlcG1QKAWFgrLpZN1IWmJAybjc0wqimqZ3K3qM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=V1pdBJwlIK+vXLamflQf+YJHknoc+xJ1fj6/P/7wg4x92ySYX6l3/cCozFX91UTLZ
	 HuwIa4gcaxOR/w8m+uL1vD6hj61diSW8DqSN3sf00/S2al1bAYQVXDrUDiYQ20WsIc
	 Votu19kNyjuzEzEKmDwGnWDX4dFiucETMc5kU0rA=
Date: Fri, 31 Jul 2026 14:02:32 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: sparclinux@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Joshua Rogers <linux@joshua.hu>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, stable <stable@kernel.org>,
	Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 1/2] tty: vcc: zero-initialize control packet in
 vcc_send_ctl()
Message-ID: <2026073124-foster-tremble-7061@gregkh>
References: <20260731-aisle-tty-vcc-v1-0-962e18beb8a8@linuxfoundation.org>
 <20260731-aisle-tty-vcc-v1-1-962e18beb8a8@linuxfoundation.org>
 <42534bff-4aed-497d-bb9c-e413b92493cb@kernel.org>
 <2026073155-leverage-rentable-fbbd@gregkh>
 <3bf1002b-4e3e-4670-a3d9-2f5b7f67beb7@kernel.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bf1002b-4e3e-4670-a3d9-2f5b7f67beb7@kernel.org>

On Fri, Jul 31, 2026 at 11:16:57AM +0200, Jiri Slaby wrote:
> On 31. 07. 26, 10:32, Greg Kroah-Hartman wrote:
> > On Fri, Jul 31, 2026 at 10:29:14AM +0200, Jiri Slaby wrote:
> > > On 31. 07. 26, 10:15, Greg Kroah-Hartman wrote:
> > > > From: Joshua Rogers <linux@joshua.hu>
> > > > 
> > > > The stack-allocated struct vio_vcc pkt was partially initialized,
> > > > leaving the tag.stype_env field uninitialized before being sent via
> > > > ldc_write(), potentially leaking kernel stack data to the LDC peer.
> > > > 
> > > > Assisted-by: AISLE:Snapshot
> > > > Cc: stable <stable@kernel.org>
> > > > Signed-off-by: Joshua Rogers <linux@joshua.hu>
> > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > ---
> > > >    drivers/tty/vcc.c | 2 +-
> > > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/tty/vcc.c b/drivers/tty/vcc.c
> > > > index 27a55465bf5e..3947bd2b75ac 100644
> > > > --- a/drivers/tty/vcc.c
> > > > +++ b/drivers/tty/vcc.c
> > > > @@ -492,7 +492,7 @@ static ssize_t domain_show(struct device *dev,
> > > >    static int vcc_send_ctl(struct vcc_port *port, int ctl)
> > > >    {
> > > > -	struct vio_vcc pkt;
> > > > +	struct vio_vcc pkt = {};
> > > 
> > > Note this needs not initialize holes.
> > 
> > Does it?  I keep forgetting this if it's really true or not.  I think
> > we've been through this in the past but I can't find the archives.
> > 
> > > I believe there are none here, but memset() is usually
> > > preferred/safer.
> > 
> > Last I remember, a long time ago, the compiler would just use memset()
> > for this, and hit the holes.  Or is that a compiler-specific issue?
> > 
> > Yes, it's more obvious, and I'll be glad to change it, but figuring this
> > out for real would be great :)
> 
> OK, so the standard (C17) does not guarantee zeroing.
> 
> What I found though:
> 
> * both clang and gcc zero the full struct for "{}". There was a bug in gcc <
> 8 where it did not.
> 
> * this is not true for designated initializer, cf. ce50039be49e ("net:
> sched: act_ife: initialize struct tc_ife to fix KMSAN kernel-infoleak")).

Ok, as our compiler is newer than these versions, and this isn't a
designated initializer, we should be ok.

> 
> Adding Kees who is the author of:
> ====
> Memory initialization
> ---------------------
> 
> Memory copied to userspace must always be fully initialized. If not
> explicitly memset(), this will require changes to the compiler to make
> sure structure holes are cleared.
> ====
> 
> He might aware of more bugs.
> 
> 
> 
> FWIW, {} here should be safe for two reasons:
> * not a designated initializer
> * no holes (IMO)

Great, I'll keep this as-is.  Now if only anyone can tell me if this
code is even used anymore :)

thanks,

greg k-h
