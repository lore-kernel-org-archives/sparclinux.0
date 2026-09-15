Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4F03D6487;
	Tue, 15 Sep 2026 12:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789474882; cv=none; b=PQ47Z/OH83XVNBE7JgH4SqkXbLMTFUMvOB0CjaFmGnDWos43ZARwThFKssGk6A+1I4zQxY7kFs/GQ9LlE+PGaiiC/yuI3bKTlMv1HgBl4VScr4by1CXAVpeSbrDhUONKATxwY1tZ5gZjS160DYDVqwnqIzbD/SepqTIzW6G5uDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789474882; c=relaxed/simple;
	bh=Uc7cO5xoe1cQZMzNgyouoEulYOfR9Lrcdm/hjSDUACk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WOfWwbfAJVt7D5wIOPAeyHKCnEk9WxUUhVtjoCViYBzz5QYG1M3GqvyyjvzgvY2ak2g/RXyboVl1l/3FA2kfwLwPeMR5PAfnZfdve5So+yTNCG5iFrOqf6EFE7aovcJouU55fxd12gr0HlAj1lHoRgpOSEwC4Sso8VS7y9RH5GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RifjIpqw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RifjIpqw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 789A61F00893;
	Tue, 15 Sep 2026 12:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789474881;
	bh=Uc7cO5xoe1cQZMzNgyouoEulYOfR9Lrcdm/hjSDUACk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RifjIpqwJ9OqsSvNVf8dpgAPRIXNtpH+2TvjVYCOe9JUquNlggyFFXGJ0dnsaYmCg
	 GQ9XosyxDDx8GSMITHICVAvNL+LxNcmxvQMQP7A3d1sqIXZ9RcF7rJNLS5wAMhcPOo
	 SPow9eKiSuj2zKpRt8Cuw1b4X6SN6EeInZhqMldrk5L5hldvpE4fVZKWhOZYYZiNwJ
	 uht3jZCMYXSw+Eavv2okVbNxYC6NRCTmed+SaIPKeRXggq0abWEv5pETdDXtyZFTxL
	 +PtN1edDe9OuMct6IEevtSb0WL7MUHUyK38VC8DLpI0Q9G8uZMCxYp4zSbGdcMEgO3
	 kB54THZRs52CQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 46/50] xen/gntdev-dmabuf: stop putting the
 descriptor back on failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>, "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: linux-gpio@vger.kernel.org, bpf@vger.kernel.org, "Oleg Nesterov" <oleg@redhat.com>, "Jann
 Horn" <jannh@google.com>, linux-mm@kvack.org, linux-openrisc@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, sparclinux@vger.kernel.org, kvm@vger.kernel.org, linux-mips@vger.kernel.org, linux-alpha@vger.kernel.org, dri-devel@lists.freedesktop.org, "Peter
 Zijlstra" <peterz@infradead.org>, io-uring@vger.kernel.org, "David Airlie" <airlied@redhat.com>,
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, linux-m68k@lists.linux-m68k.org, linux-arm-kernel@lists.infradead.org, "Ingo
 Molnar" <mingo@redhat.com>, linux-um@lists.infradead.org, linux-sh@vger.kernel.org, "Jan
 Kara" <jack@suse.cz>, "Alexander Viro" <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org, "Jens
 Axboe" <axboe@kernel.dk>, linuxppc-dev@lists.ozlabs.org, linux-snps-arc@lists.infradead.org, "Eugenio
 Perez" <eperezma@redhat.com>, kexec@lists.infradead.org, linux-parisc@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-hexagon@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, linux-csky@vger.kernel.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-46-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-46-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:21:19 +0000
Message-Id: <20260915122119.789A61F00893@smtp.kernel.org>
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
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D46

