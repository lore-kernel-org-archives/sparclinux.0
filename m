Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8E04A9D4D;
	Tue, 15 Sep 2026 11:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789473248; cv=none; b=CZpZhMt72gSR+bWtaxghE7o3rP/L3fpVOLc5ydKGzY5XJgmx1r2aLMTbsIf02V3yQpIkbSe/HhUI9k31IFOX4JulEfdb+3uHjrjgGHd6knXh6bZiESDMRK7z7L+spxqxzGSSrn1gWNk7ihxq9XKOK0cSW2HYf3NKskx51gP+aRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789473248; c=relaxed/simple;
	bh=AG30xjDiMKCtDyqoUWBdTqe2A6YC7BdfmCSY6YO8TME=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=l2QSUYSF17+lhmXIk3R583PfvO4uYhGziXMrcUdf3K2r3op6OT/N71OZO0jiD0Xx8rtth8+bXMj0mXCfFQbGUNg4Qt2xira1EGen6h5MyYLq8u89194Uqrc0PlvMTsd5cfwYE+6hFYS1s3qR6MeOyy+TLAsBOJ934Et07U5+SWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxGdVbxm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxGdVbxm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F0B31F00893;
	Tue, 15 Sep 2026 11:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789473246;
	bh=AG30xjDiMKCtDyqoUWBdTqe2A6YC7BdfmCSY6YO8TME=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jxGdVbxmN8Kp7YM+vv1k+Lwtl83KHaJbgpKLbkY5B9ndglNTkZCcuaHvygk/C/p23
	 gtc5IvLgRXflsaT/JbeYSUg8MT7dnkGaEESjkiYYG1vk2eMg5A4bJo85Hl9wv/nzeS
	 eGLkK/gZnGZt5sYUblxipqPSDfZOU6WkQWeqEOXj7sSr5LV4NAo/AueirSWL/XnsKl
	 hRst8P2ASZag12PNEDM5uHg4yR4m5hctoI8grNV4iMcvJNyl1ZXEvQ3SkS6D43rgW5
	 SD5U4o/63gzEV7FOsh2ZQJJdmW/ba916cBMFpTju6k1xEUWXrbdXF1KZviyBg5srWx
	 +dlhemDHcpIKQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 12/50] nios2: commit fds on syscall exit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>, "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: linux-arm-msm@vger.kernel.org, linux-um@lists.infradead.org, linux-hexagon@vger.kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, virtualization@lists.linux.dev, "Jens
 Axboe" <axboe@kernel.dk>, linux-hyperv@vger.kernel.org, io-uring@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, linux-arm-kernel@lists.infradead.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, linux-csky@vger.kernel.org, sparclinux@vger.kernel.org,
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, linux-gpio@vger.kernel.org, "Ingo
 Molnar" <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-m68k@lists.linux-m68k.org, "David
 Airlie" <airlied@redhat.com>, dri-devel@lists.freedesktop.org, "Eugenio
 Perez" <eperezma@redhat.com>, bpf@vger.kernel.org, linux-snps-arc@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, linux-alpha@vger.kernel.org, linux-fsdevel@vger.kernel.org, "Jan
 Kara" <jack@suse.cz>, "Peter Zijlstra" <peterz@infradead.org>, kexec@lists.infradead.org, "Jann
 Horn" <jannh@google.com>, linux-openrisc@vger.kernel.org, "Oleg Nesterov" <oleg@redhat.com>, kvm@vger.kernel.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-12-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-12-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 11:54:04 +0000
Message-Id: <20260915115405.0F0B31F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>

> Add TIF_FD_SLOTS and test it once the untraced system call has had
> its return code translated into the r2 and r7 pair userspace sees.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-work-fd-re=
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D12

