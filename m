Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A403C65FD;
	Tue, 15 Sep 2026 12:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789474393; cv=none; b=MFPaSUaOUstIdoqpLMOASRd1f4gA7e60mUZ+iJIShvLyeVWiTCs2F5SUEgclmbxjyegBqZGSv2+9emGD4SD7OAurqh23LR/W82jzYPve3t7YN4XwQtyYzyqI2OnmHFXixfTd/S27fSPrVpLln/6Xc8X1+YrTU7BuCT8pmGCVoGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789474393; c=relaxed/simple;
	bh=rcP1Zt+r+c8i7P9HMLnfG+KSwnTlxlPDfufoMKFt0yM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QvUZtmumZ+YiDJScMHMKPG291kcRlEOLAvX3IDyooh1JgopIEicom+ip84wwgd9lY08NQdO4iTQOQMxq8a/VieVrg7/kh4v3PkdMCs56qt19zMOkyY76GB31YwEp8+p/P8E4KDrM/+xQcUluc3K0cgz2n2NUjaNge3+pYNZun5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxoLtCbZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxoLtCbZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CCF61F000FF;
	Tue, 15 Sep 2026 12:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789474391;
	bh=rcP1Zt+r+c8i7P9HMLnfG+KSwnTlxlPDfufoMKFt0yM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mxoLtCbZ5g8NJT38V2nXx3kQMXq8zz7wa261boot03y/1mmOb8uEpnb4HgvVzXqbE
	 Lc+BLr2MEwB+7zjlCcD9Q9qeYqKVACCOsKFW9yMVpHmTXMqtHVkiNOOQlElz6DH2cL
	 qfBphOZ3delbUDrFqm1dV52+sHB7JppWyVGvQVAhcP+Vcr7mTyrRaVGoKVuRlWxgrA
	 a0ZQjTcB9Fxaqpd6c2a/Z1vb/mAmnfz0/bCd8zDO3h3sznLEIo6QHFgrENGMHDk9qf
	 flDXJ4YX6mmlM4kAG/dg8PRmGwgcbH40eS5i4n9wiRd9k9l8mEd5AlXPVBescbcVDo
	 rqQ5leD9k9+dQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 36/50] nitro_enclaves: install the enclave
 descriptor when the ioctl returns
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>, "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: linux-hexagon@vger.kernel.org, io-uring@vger.kernel.org, linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org,
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, "Oleg
 Nesterov" <oleg@redhat.com>, linux-fsdevel@vger.kernel.org, linux-openrisc@vger.kernel.org, "Jens
 Axboe" <axboe@kernel.dk>, linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, "David
 Airlie" <airlied@redhat.com>, "Jann Horn" <jannh@google.com>, linux-gpio@vger.kernel.org, sparclinux@vger.kernel.org, "Jan
 Kara" <jack@suse.cz>, "Eugenio Perez" <eperezma@redhat.com>, linux-alpha@vger.kernel.org, "Peter
 Zijlstra" <peterz@infradead.org>, linux-sh@vger.kernel.org, linux-parisc@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org, "Ingo
 Molnar" <mingo@redhat.com>, linux-um@lists.infradead.org, "Michael S.
 Tsirkin" <mst@redhat.com>, "Alexander Viro" <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, bpf@vger.kernel.org, linux-arm-msm@vger.kernel.org, virtualization@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-snps-arc@lists.infradead.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-36-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-36-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:13:09 +0000
Message-Id: <20260915121309.7CCF61F000FF@smtp.kernel.org>
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
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D36

