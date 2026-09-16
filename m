Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16178404BE3;
	Wed, 16 Sep 2026 07:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789542618; cv=none; b=K38diUVL614ge1960I66gxJrCS8ArwcadhKgbWgc0JoeQK8ZZW/x56DQt3sOVKJI/t6ZoHvgvMoyKW5qhbR2UkwnnTYFEDCbCiSugUEzy/VnUcXf6ifjSPBNMh7td5Cy7FGf8n4a7jZHt83rdE+6CbDbvFTiu6BJx6yRe86OE7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789542618; c=relaxed/simple;
	bh=TbkgiRjWeQ8a0xpMBTTJK/KlAo0wUUGLv0byzFa/anY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=maegKj806eAP7zNa/awQgawtiLuCg4C//pqdq3NX71oYTywYUnxXTdiscCN7oUVZlXSRUl0dEEapa6VFvuxpBqbribxgk+7hF7AMc54dsy7oNNyoI9SZfPGWjxrOw6uk/Ms9LMwCgxpb/Glw/sUca16Q1m0lHqd67+tbWDSxkro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7SwAZ5T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7SwAZ5T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 165081F000FF;
	Wed, 16 Sep 2026 07:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789542593;
	bh=p2gx8+1v2YG2nXZ5rZ43ZGOVbgNWYwB+4lHcBSPfXX4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=K7SwAZ5TQox94KhnzDZgdWak9JeascnEJT6tgsdFitx13oH/yvHVurs3emFIQIidi
	 xcR0gIE20GLza50nMYtjBg//0e7WD22sTKu3OHciVTO0Egw6dpfNvS97BoC4LpWgvN
	 ZD0aZmUahuws0zfu0FGKie6dskhpn2wDFZH1gLvxR0Y/XLP3PDKD59Q3XEFPNj3iGd
	 l3nMpo+kKycUGKylVUc5DFObZlUBNTgMifgw32kRkszA3iFJ9ppTn7CES9cJYrH1JE
	 XD/gyr3hXov/6xjsaqqL1FGY+8ZmWmmW0Gqlh80XrHJbwZzvXyNf+hmB3sQ+DilGUR
	 S0XyD3cx8I3Gw==
Date: Wed, 16 Sep 2026 09:09:41 +0200
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jann Horn <jannh@google.com>, 
	Jan Kara <jack@suse.cz>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, Jens Axboe <axboe@kernel.dk>, 
	io-uring@vger.kernel.org, netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	bpf@vger.kernel.org, David Airlie <airlied@redhat.com>, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, kexec@lists.infradead.org, 
	linux-hyperv@vger.kernel.org
Subject: Re: [PATCH RFC POC 00/50] file: handle files on syscall exit
Message-ID: <20260916-seilbahn-heimvorteil-edelmut-bad3637b3a95@brauner>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <CAHk-=wjeamU=_RYT9cR3dZJ2N-Teo-N1+aYh7jwhrB=iWXD0cg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjeamU=_RYT9cR3dZJ2N-Teo-N1+aYh7jwhrB=iWXD0cg@mail.gmail.com>

On Tue, Sep 15, 2026 at 09:02:31AM -0700, Linus Torvalds wrote:
> On Tue, 15 Sept 2026 at 04:31, Christian Brauner <brauner@kernel.org> wrote:
> >
> > TL;DR, this lets arch code handle fd install and cleanup. fd_prepare()
> > allocates a descriptor like get_unused_fd_flags() does and records it in
> > a slot on the task. fd_stage() attaches the file to that slot and
> > returns the number.
> 
> Honestly, I am *not* a fan. At all.

I'm really glad that you don't like it! I hate it too.

To quote back from the cover letter:

> The idea in this series is old-ish and really never let go of me and so
> I wanted to at least dump it onto the list once even if it's just for
> illustrative purposes.

I think the cleanup-based solution we've added a couple of releases ago
is the better appraoch. Which is why I chose it over this.

But this install-on-the-way-out idea has been brought up quite a few
times as the "better approach". I never really believed it would work
nicely. Now we have an implementation on the list that we can point to
and we can move on from this.
