Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C161149AA55;
	Tue, 15 Sep 2026 12:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789474717; cv=none; b=WMpmhLN/ydOYz9gCxdOkNZrKLdGMaj3L58M0LCqXm5MNlkKA0NMcoJJZN4AQGsk7O//o6BPfUp1rp1Mw/pB5nvGJLITHphAB/IYvVbmoLNZE69lVMBLplD6o+vFBW0azsPh2sof/hcc0E8F8cyvKTtR1b2N3T/YFzcf3hyfC8cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789474717; c=relaxed/simple;
	bh=vrVAobJMjM7S9OZZMwIDwvr8ty2bA0kqwagLpHQp40w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SnY2bEJpDEBYXEUAY0RJJ4jUaqi5gyH1ZPJoHfdIliFSZ3KEJJG23l6H18pYqJ4q+l2v6P6wUJ6r8gfglBW8H5i/fr1mp4vFvde0YklqXRCusAomyEjvYe8jrlSPB/QOzbDh+ZG0i7rBKArKaUhMosV+4eG8PayzBysYV5Zk9NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ea1sJwsB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ea1sJwsB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E6111F00898;
	Tue, 15 Sep 2026 12:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789474716;
	bh=vrVAobJMjM7S9OZZMwIDwvr8ty2bA0kqwagLpHQp40w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ea1sJwsBr/Nvel740b29/2lnm8kv13L85FditgVsIEu95cKYPQZU0Zm86Po1jnZNR
	 WHN070goKjNpVo1FRyPViEa8NGr0QNUX2ucQBNO5lGEpXDGQD7U7BclSRhluMnxtKP
	 ATnOY9YQY/9J5OJE6jroQgQS5sfBOnMZtK6e3d1b5IYszHnQqLJX4JE1tZ1dgWaKGz
	 MVf3djXQJIyElXt0yrKwDYp8btcu88OnDKD8ru7wqrjSAcI7zj25kTBGPYQCXOGFwa
	 RfYXn1Lwzeg0QAuqyZ/UnU7T5x+37hRI9c8kwg/0XtOV9Mo2i3dXkFawFgls2HqTB0
	 kguWCX48YbslQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 45/50] accel/habanalabs: stop putting the
 dma-buf descriptor back on failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Linus Torvalds" <torvalds@linux-foundation.org>, "Christian Brauner" <brauner@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-gpio@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-snps-arc@lists.infradead.org, "Oleg
 Nesterov" <oleg@redhat.com>, "Peter Zijlstra" <peterz@infradead.org>, "Ingo
 Molnar" <mingo@redhat.com>, linux-alpha@vger.kernel.org, "Alexander Viro" <viro@zeniv.linux.org.uk>, virtualization@lists.linux.dev, linux-mips@vger.kernel.org, kexec@lists.infradead.org, bpf@vger.kernel.org, linux-arm-msm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, "Jan
 Kara" <jack@suse.cz>, linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org, "David
 Airlie" <airlied@redhat.com>, linux-um@lists.infradead.org, linux-csky@vger.kernel.org, linux-parisc@vger.kernel.org, "Jens
 Axboe" <axboe@kernel.dk>, =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxl?=
 =?utf-8?b?KQ==?= <brauner@kernel.org>, linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org, linux-hexagon@vger.kernel.org, io-uring@vger.kernel.org, linux-m68k@lists.linux-m68k.org, "Eugenio
 Perez" <eperezma@redhat.com>, "Jann Horn" <jannh@google.com>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-45-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-45-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:18:34 +0000
Message-Id: <20260915121834.8E6111F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>

> Rely on the fd exit path machinery.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-work-fd-re=
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D45

