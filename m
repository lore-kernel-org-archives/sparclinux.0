Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7090D496D3F;
	Tue, 15 Sep 2026 12:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789474715; cv=none; b=EJTnUmnmYhWXgYp9Ggupjv8iru0YlDjUeJ+SBlUbtY+G6bMdR0P0WMXwl4q+vXU63MUhmjVEESEPs8I0oGQTGzGVyYRh4Yx9VHor9JI9vKEhHWYGWKnK+tvgquRRNkMzux28gVwjX5VelhURbw8YytBs2YEhmPXfwv5fOe4FW7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789474715; c=relaxed/simple;
	bh=3Nr8gcCwi6DEWSLP9EN8/l4h5yq3GfGsy2oDZDwQTVw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VxaINO0jRQhiE54RY07uMNhe4E7KN9XuSyQjiy559NzPYnntsTL1w6CuSH8AYeUuZwYT/pF/Yeni/WiloeKfpC4DKDctEKBn360MErH/IfqGI5AxKlevHxWN3DAejLeUqwMqUuBNH4pZkjywfTSSmoA0NDeLR65sO1HbCUQgVY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=al7xG3Qx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="al7xG3Qx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6100B1F00893;
	Tue, 15 Sep 2026 12:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789474714;
	bh=3Nr8gcCwi6DEWSLP9EN8/l4h5yq3GfGsy2oDZDwQTVw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=al7xG3QxpordB8FaZac1xk6QWAEGzphwDCGfy40ckeGGdeDP1tbwhbJklTqx5QQFT
	 ODvPZmGs3Rku3J2uQB3ChHYQAriES6YPKKW/TWgpaSESxWFOwioknFfQIhOZdlb/lh
	 RLkOhFE53P9jFChtaD6A2+vi4SogD6zm9+SM0eAaXOgGkYYLJJfSgO/RrU1jMf018L
	 IsZndXI06LzsoDnaEX00kNg9+CSe+xR/UDoSJpVb9b2SoGOi1j19PuVJIg9jG4HZNR
	 dl5cjIQ8g0S9+wNIlluWxOi9Rk+9A+i9qr4Dl8RqrHyi07ZG8WPpqBJZWgaHICrgtm
	 ZwEgDuMch+DXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 47/50] iio: buffer: install the buffer
 descriptor when the ioctl returns
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>, "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: "David Airlie" <airlied@redhat.com>, virtualization@lists.linux.dev, dri-devel@lists.freedesktop.org, linux-openrisc@vger.kernel.org, linux-arm-msm@vger.kernel.org, sparclinux@vger.kernel.org, linux-mips@vger.kernel.org, "Jann
 Horn" <jannh@google.com>, linux-hexagon@vger.kernel.org, bpf@vger.kernel.org, linux-gpio@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-hyperv@vger.kernel.org, kexec@lists.infradead.org, "Eugenio
 Perez" <eperezma@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, io-uring@vger.kernel.org, "Peter
 Zijlstra" <peterz@infradead.org>, "Alexander Viro" <viro@zeniv.linux.org.uk>,
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org, kvm@vger.kernel.org, "Ingo
 Molnar" <mingo@redhat.com>, linux-kernel@vger.kernel.org, "Jan Kara" <jack@suse.cz>, linux-csky@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, "Oleg
 Nesterov" <oleg@redhat.com>, "Jens Axboe" <axboe@kernel.dk>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-47-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-47-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:18:30 +0000
Message-Id: <20260915121831.6100B1F00893@smtp.kernel.org>
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
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D47

