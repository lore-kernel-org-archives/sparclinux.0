Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7BD3D9025;
	Fri, 31 Jul 2026 08:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785486777; cv=none; b=hc9URyilm6AEg7M576xZfe7sF6KpWI0Yrk2OAUY4mg3d8E0+/dbkqnzZzv1GkwrhGMPHEGcpyWMul0tPPCdauSHWlq3dO0ylHxqEA4O3clicalSXA3z6DdCIwixfkn2+u9/r2VxRZJUXFTpoonj/BjLGNZXU9CDCRAa7ZUndjhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785486777; c=relaxed/simple;
	bh=xmeg5KGCnhLymi1rNgz1SskROZWtuHVg3LNINYsfs2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o+0FrKBpmlA47FWSdnnFg7YO2FpyhyvHUl/hjWr+KpG7Z+VvvUOSdYCd4hsyvW0zwkY5y0MgY6UFlUcGH+fg+xvOj01iAqE8sonmjK0mWMp7vXnGnKLma/9HZtgyFb4uLX9ajoOh0Q7Lwkh1noX8RwMDXXxXftvO18136joLLrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f3W1sQHo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f3W1sQHo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4C711F000E9;
	Fri, 31 Jul 2026 08:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785486775;
	bh=whZkSDZzinV76P9Kac70oDBqaOjRZ55+97i0cqwok4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=f3W1sQHophHusyahID4Nsgl6JjcohUaDFi0oD/FINNDvEqzFOR4PcpN8vgLYHXwjB
	 ZcAtX3HJepAp+bNaxbvqQmZDgs6Zu1OougN7sscwLksR+yc9u+owHWYZTvFHl0GI7D
	 6LoUzkRGE4BoikcmrJRpawxJzEiFsRzof9q16MBQ=
Date: Fri, 31 Jul 2026 10:32:40 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: sparclinux@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Joshua Rogers <linux@joshua.hu>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, stable <stable@kernel.org>
Subject: Re: [PATCH 1/2] tty: vcc: zero-initialize control packet in
 vcc_send_ctl()
Message-ID: <2026073155-leverage-rentable-fbbd@gregkh>
References: <20260731-aisle-tty-vcc-v1-0-962e18beb8a8@linuxfoundation.org>
 <20260731-aisle-tty-vcc-v1-1-962e18beb8a8@linuxfoundation.org>
 <42534bff-4aed-497d-bb9c-e413b92493cb@kernel.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42534bff-4aed-497d-bb9c-e413b92493cb@kernel.org>

On Fri, Jul 31, 2026 at 10:29:14AM +0200, Jiri Slaby wrote:
> On 31. 07. 26, 10:15, Greg Kroah-Hartman wrote:
> > From: Joshua Rogers <linux@joshua.hu>
> > 
> > The stack-allocated struct vio_vcc pkt was partially initialized,
> > leaving the tag.stype_env field uninitialized before being sent via
> > ldc_write(), potentially leaking kernel stack data to the LDC peer.
> > 
> > Assisted-by: AISLE:Snapshot
> > Cc: stable <stable@kernel.org>
> > Signed-off-by: Joshua Rogers <linux@joshua.hu>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >   drivers/tty/vcc.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/tty/vcc.c b/drivers/tty/vcc.c
> > index 27a55465bf5e..3947bd2b75ac 100644
> > --- a/drivers/tty/vcc.c
> > +++ b/drivers/tty/vcc.c
> > @@ -492,7 +492,7 @@ static ssize_t domain_show(struct device *dev,
> >   static int vcc_send_ctl(struct vcc_port *port, int ctl)
> >   {
> > -	struct vio_vcc pkt;
> > +	struct vio_vcc pkt = {};
> 
> Note this needs not initialize holes.

Does it?  I keep forgetting this if it's really true or not.  I think
we've been through this in the past but I can't find the archives.

> I believe there are none here, but memset() is usually
> preferred/safer.

Last I remember, a long time ago, the compiler would just use memset()
for this, and hit the holes.  Or is that a compiler-specific issue?

Yes, it's more obvious, and I'll be glad to change it, but figuring this
out for real would be great :)

thanks,

greg k-h
