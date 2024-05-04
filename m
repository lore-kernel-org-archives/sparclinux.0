Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E227E225D0;
	Sat,  4 May 2024 16:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714838544; cv=none; b=p1FUgLFjsU8M/KJBiieD+Wpk3u/hZ9Zr9XlFkkfRZ0XUYj2Mb/hiyUckZ3089vGTWB0NS7eNowoGiaeJR4wdUKcNF7FffzWVTif6OeD0DgtpnBp6h65wQCPC1XcFXx8a+1Opd9uTYwbjRoP/t8t1tVLb3r7G8hQrn/0hXjkuyzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714838544; c=relaxed/simple;
	bh=l7/qBYhv4Nz9jrr8QvXGoWwXYXcm+LgU7yb+s1r64Bw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RQTGm2qtvd5uVsI4mYtITrYcZe1QIbbjnKfEnFcDZH0BSdzYpYN8FVIuoi/xTyowNWi1QyYnKvJZOkaunBgM4P+HRKUuS8Oz+FNsfEIJxKtsy0b11FuAgXQFwfmADmitKMGufUSbVMgWdidAUsVPMANCbhCpBWHGjFVD+yaXGkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2gGDGeCa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2gGDGeCa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2895CC4AF14;
	Sat,  4 May 2024 16:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714838543;
	bh=l7/qBYhv4Nz9jrr8QvXGoWwXYXcm+LgU7yb+s1r64Bw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2gGDGeCaVqyP2Oh2hdh3p0Zvc19udosCcLAX3iyJTslqHZmBZWaDpf85AoCdyUKWW
	 eiXIDiCBuMO+KQjL7dx9ql1vU77tsVgdBUTOUoCiKGCojSa7/05pDw0HnMAvfFKDZU
	 ubYtJ3lDX+LGfAn9VRtAbZKTz03yG1eRNPtKiYjk=
Date: Sat, 4 May 2024 18:02:20 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Shresth Prasad <shresthprasad7@gmail.com>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	davem@davemloft.net, jirislaby@kernel.org,
	sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, javier.carrasco.cruz@gmail.com,
	skhan@linuxfoundation.org, Julia Lawall <julia.lawall@inria.fr>
Subject: Re: [PATCH v2][next] tty: sunsu: Simplify device_node cleanup by
 using __free
Message-ID: <2024050402-eraser-stimulate-3908@gregkh>
References: <20240501084110.4165-2-shresthprasad7@gmail.com>
 <f1707254-ec32-4884-275a-c3c85b48d7d5@linux.intel.com>
 <CAE8VWiJy-2x6sKCAmN69Uq9Kf1cTRnaJezOoLDyZ0SbgPWuHAQ@mail.gmail.com>
 <2024050357-shading-fedora-2d4f@gregkh>
 <CAE8VWi+-HVuGo-ojGPwKubpLweBmJ4-L097nh03QkezcsciorA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE8VWi+-HVuGo-ojGPwKubpLweBmJ4-L097nh03QkezcsciorA@mail.gmail.com>

On Fri, May 03, 2024 at 02:31:22PM +0530, Shresth Prasad wrote:
> On Fri, May 3, 2024 at 11:04 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, May 02, 2024 at 10:21:16PM +0530, Shresth Prasad wrote:
> > > On Thu, May 2, 2024 at 9:35 PM Ilpo Järvinen
> > > <ilpo.jarvinen@linux.intel.com> wrote:
> > > >
> > > > On Wed, 1 May 2024, Shresth Prasad wrote:
> > > >
> > > > > Add `__free` function attribute to `ap` and `match` pointer
> > > > > initialisations which ensure that the pointers are freed as soon as they
> > > > > go out of scope, thus removing the need to manually free them using
> > > > > `of_node_put`.
> > > > >
> > > > > This also removes the need for the `goto` statement and the `rc`
> > > > > variable.
> > > > >
> > > > > Tested using a qemu x86_64 virtual machine.
> > > >
> > > > Eh, how can you test this with an x86_64 VM ???
> > > >
> > > > config SERIAL_SUNSU
> > > >         tristate "Sun SU serial support"
> > > >         depends on SPARC && PCI
> > > >
> > >
> > > By that, I mean that I compiled the kernel and ran the produced bzImage
> > > on a x86_64 qemu machine.
> >
> > But you didn't include the driver you were testing :(
> >
> > > I unfortunately don't have the hardware to test it on, but I don't
> > > think the change is complex enough to require testing on real hardware
> > > (unless I'm assuming incorrectly).
> >
> > That's why I asked if you had tested this or not...
> >
> 
> Really sorry about that, I thought compiling and booting would qualify
> as testing. What should I be doing then?

Compiling and booting the code you change would be a good start :)

thanks,

greg k-h
