Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE93C47D462;
	Tue, 15 Sep 2026 12:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789474287; cv=none; b=BLZqTPVEDVHeoBf6OLYPrUGFGlf02KNkpP9RpwW+PI0KKAluDnKQutlQ82D9XSl5mnMp7qQBzgiB+81CAzvR36W4GUrI85fwHfzimS2NunYJS8PKbA6VTfD0GWOdqEuBPhDjqClEo/ATnIrRuVi9HjnGSDgEZ7C1Oh/YMn0XXgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789474287; c=relaxed/simple;
	bh=sOVPYbcZwP0qO0v/wyl6IpYJ7aj9qJBJUvOIh/HcLZU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g9ImETd1+2AW4qfEXZuVNy9YU3wBLpu8qCLka6Zy4uhmvEw9uCmDbAL+3WkqIhz2RPxOPEe6l+zOUVbsACBdl+xXxGWH17qfM3Yai0EyPc27n+lYsI48uvd/0Ji2uVbHU7Co5gh0VAuHg+zzxofVqnp8+PYkZDyd1SyFKDNl/ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RmyX0EJ1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RmyX0EJ1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5D341F00893;
	Tue, 15 Sep 2026 12:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789474285;
	bh=sOVPYbcZwP0qO0v/wyl6IpYJ7aj9qJBJUvOIh/HcLZU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RmyX0EJ1B0zOgT5ioEXRLk+o4F4Y5EudQ2MyBappoNbd4lClHN+PysLRe+lqvPVp5
	 tBwJMbqCeZEv7naOUmB5POnQKn+dbX0K1SIPTGnovxWaK3d1hrbCQzt+QTOIjSS0jv
	 ozOLD3b4lQSvA/CU30dXodluwPZzgV+Ca6K7iJVN6Vk+KD4JQXyjNYe7jK3mYcGLUH
	 4XnCIyui6X4vRwCLNy4FaV+3AmDMv+qiX7nSh5emNDsXdPMr643qZCL0VouKa3ayzv
	 pThUPgyUG/CP/C8WVCikSGDKsjSd8zkAPHVNK+58jF+szrJfKJpZ9+ygivmoI9WEAz
	 pHHOzSGPpXmoQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 29/50] drm/virtio: install the out-fence
 descriptor when the ioctl returns
Reply-To: sashiko-reviews@lists.linux.dev
To: "Linus Torvalds" <torvalds@linux-foundation.org>, "Christian Brauner" <brauner@kernel.org>
Cc: kvm@vger.kernel.org, "Jan Kara" <jack@suse.cz>, linux-csky@vger.kernel.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, dri-devel@lists.freedesktop.org, "Jann
 Horn" <jannh@google.com>, linux-parisc@vger.kernel.org, linux-snps-arc@lists.infradead.org, "Ingo
 Molnar" <mingo@redhat.com>, linux-mips@vger.kernel.org, linux-alpha@vger.kernel.org, linux-um@lists.infradead.org, linux-arm-msm@vger.kernel.org, virtualization@lists.linux.dev, io-uring@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, "Jens Axboe" <axboe@kernel.dk>, linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org, "David
 Airlie" <airlied@redhat.com>, "Peter Zijlstra" <peterz@infradead.org>, linux-hexagon@vger.kernel.org, linux-sh@vger.kernel.org, linux-openrisc@vger.kernel.org, linux-fsdevel@vger.kernel.org, sparclinux@vger.kernel.org, bpf@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, "Eugenio
 Perez" <eperezma@redhat.com>, kexec@lists.infradead.org, linux-gpio@vger.kernel.org, linux-m68k@lists.linux-m68k.org, "Oleg
 Nesterov" <oleg@redhat.com>, =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRh?=
 =?utf-8?b?YmxlKQ==?= <brauner@kernel.org>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-29-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-29-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:11:23 +0000
Message-Id: <20260915121123.B5D341F00893@smtp.kernel.org>
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
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D29

