Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239D74A5C51;
	Tue, 15 Sep 2026 12:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789473891; cv=none; b=qepr/IOg715ZFJWDvn/LfBR2ItyRZzbjFN9HfXwgBkCrr+D40Nbjo+QfWSSd4WwAhHlH5RaZ21Ak8r7inC9EvV9ZVoCXAHFeXNFquGaoTCt3vpXGg3aOBUfMBA8fpooeEfr7xfmp0AagJ7ZsGBCUSTdgrQe7OgSYYqSls7JGOMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789473891; c=relaxed/simple;
	bh=JAT+dPINnJ0baLSnWeyqna2pT2L+zf+r0Hb38LXbJr4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bztmEGI6whSR6GQRYvO+2vHLhzW1Yycbj0+HS/IoVleQwPnD79K/XZkXoYdYT2x74taGQ/+EZKOFWrj+eZcc7l4gEXQs46WMfUUWNIeki0/2OCLNLvCot14ALyA7ZQvmC1zz4RqQuHjWxi7q8Guw5zbe8mLpLSJJA8bDJIBwL4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mh0aJRjv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mh0aJRjv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D92CF1F00893;
	Tue, 15 Sep 2026 12:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789473889;
	bh=JAT+dPINnJ0baLSnWeyqna2pT2L+zf+r0Hb38LXbJr4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Mh0aJRjvpgxlZiLKhSATPqRfUaES+f2XTT49Q88vDM46+M2joHhrL5IXTe47rLwKc
	 lQ8SWuZa+L36m8Iss1J2WPRz0FGDuI7oSB9RhNnd6Q/OBlecSo2ec3ESUds1YiK9AY
	 yE5zSTou8yCIYMwaO7fw3TkKtVt9q88AVkigmJ0j7/I1yD7epQKS1vU3wqqB1ahaXX
	 LNYP3gTZ6O2PbkoUguLy6zmGopGbgX6RXuAS1J3tZlp1M2JrhXEo7fKehrQrDDD3RI
	 cFHwW76z9ATTIL4qO2fc49BAVBC61Nonh5r1ZU9cD24BOO9dRalQfLo+8prJsERH0V
	 r769lDt95U/fA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 27/50] drm/amdkfd: stop collecting CRIU dma-buf
 descriptors for a final install
Reply-To: sashiko-reviews@lists.linux.dev
To: "Linus Torvalds" <torvalds@linux-foundation.org>, "Christian Brauner" <brauner@kernel.org>
Cc: =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, linux-parisc@vger.kernel.org, "Jann
 Horn" <jannh@google.com>, linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org, bpf@vger.kernel.org, linux-csky@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-sh@vger.kernel.org, linux-hexagon@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, linux-snps-arc@lists.infradead.org, io-uring@vger.kernel.org, linux-gpio@vger.kernel.org, sparclinux@vger.kernel.org, linux-mips@vger.kernel.org, "Eugenio
 Perez" <eperezma@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Oleg
 Nesterov" <oleg@redhat.com>, linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, linux-um@lists.infradead.org, "Peter
 Zijlstra" <peterz@infradead.org>, "Jan Kara" <jack@suse.cz>, kexec@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-openrisc@vger.kernel.org, "David
 Airlie" <airlied@redhat.com>, "Ingo Molnar" <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, virtualization@lists.linux.dev, linux-hyperv@vger.kernel.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, "Jens Axboe" <axboe@kernel.dk>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-27-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-27-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:04:47 +0000
Message-Id: <20260915120447.D92CF1F00893@smtp.kernel.org>
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
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D27

