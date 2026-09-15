Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A9649AA55;
	Tue, 15 Sep 2026 12:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789474039; cv=none; b=rqjeh0kx/l7PIcWlsG8ThWGclMN/+mmD8mcxXcBBBm2qw4uwTeYhE1saCUZXN2+EQJOqWtgphQqUfFHsFTAsqomtVFXgeKO5fBkoedg4bZcclhDyyda6XmcjMxu/vNTa4p6yCj0b1KQD+Gxi31tGXGmiYzVRRDL3P8UCKhhyutM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789474039; c=relaxed/simple;
	bh=9Lg/vD+u14ITJU8+go78ZuhkRlXcBzG+UGmK5JLRPZA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mg1XJpOWsyoZCBbyFClp/fZ7j3H6GNulXrZ8Zxcniv5VlCVeTBnYyMpmQJQMDQP2HWhsnrjICHf4FnM19Wgz4qlYVRKNJBu/KFJaYf0assg5vM+Jwvg+H9KSIAno4DTzFf0FA640hXjYMrJ0YYGKu7AjihY+U/pW/bKnqgX8hg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TTE6T1Xf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TTE6T1Xf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15F5F1F000FF;
	Tue, 15 Sep 2026 12:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789474038;
	bh=9Lg/vD+u14ITJU8+go78ZuhkRlXcBzG+UGmK5JLRPZA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TTE6T1XfEzcNIJ8WFiySWnwQP8yJBWzCe+zXTpLvevuGzn9lG1wMo6JkmfwwL/Yd+
	 v0620B9v7rVjPwqdf+dJBvrXj/aAzuqd39yYhvfUVwF6Y68DbvQH8k6e9kkxs5lDOO
	 T8fcWkBPfS2hGnM0lvlb7z4+ZX10iJvVylZm/YCij8A1eYUDStsAMbhEWNr7ZTNW0K
	 d0wxrxeE8FTve/JAmJz66C/VfP51gl+cT2S3btyqcJ0w7YNf/OBOpnS9KLaOzdPK1Q
	 PzvyZfSsvRdUn8CutJLqPgs8jEgY3WTHPuRHCKpcfiaY7lO9YqAql9ka1D9FfKpgP7
	 bePqW74CAgyKQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 31/50] vfio: install the migration data
 descriptor when the ioctl returns
Reply-To: sashiko-reviews@lists.linux.dev
To: "Linus Torvalds" <torvalds@linux-foundation.org>, "Christian Brauner" <brauner@kernel.org>
Cc: kexec@lists.infradead.org, linux-csky@vger.kernel.org, "Jens Axboe" <axboe@kernel.dk>, dri-devel@lists.freedesktop.org, bpf@vger.kernel.org, linux-mm@kvack.org, linux-um@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-gpio@vger.kernel.org, "Peter
 Zijlstra" <peterz@infradead.org>, =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFt?=
 =?utf-8?b?dXRhYmxlKQ==?= <brauner@kernel.org>, "Ingo Molnar" <mingo@redhat.com>, linux-sh@vger.kernel.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, linux-openrisc@vger.kernel.org, "Eugenio
 Perez" <eperezma@redhat.com>, linux-hexagon@vger.kernel.org, "Oleg Nesterov" <oleg@redhat.com>, linux-snps-arc@lists.infradead.org, "David
 Airlie" <airlied@redhat.com>, linux-arm-msm@vger.kernel.org, linux-hyperv@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, linux-mips@vger.kernel.org, linux-m68k@lists.linux-m68k.org, virtualization@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, io-uring@vger.kernel.org, "Jan
 Kara" <jack@suse.cz>, "Jann Horn" <jannh@google.com>, kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org, sparclinux@vger.kernel.org, linux-alpha@vger.kernel.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-31-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-31-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:07:16 +0000
Message-Id: <20260915120717.15F5F1F000FF@smtp.kernel.org>
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
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D31

