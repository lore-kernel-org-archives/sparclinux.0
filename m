Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C913B2FC0;
	Tue, 15 Sep 2026 12:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789474334; cv=none; b=IqDapYj+bc8yI/Yg7QI4mPK58hSOIV2nPdYIxMWExTqthbhL8V1sp/x5ymt6OoEaHBweJthPG8z5ETeiJEjzKcQWizPG+GOUAttDjaj6OESF3aX4YHGLtOpTUvQE9PhwpTtjtLYhpRUvLnIVHXPxUPHA76tKYDgmUuSJ+1R3HgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789474334; c=relaxed/simple;
	bh=dTvFOp6vSGe4AZsCgKO980b0BeYwtUxBQL5x62d5jw8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KSjkVtJ25ClHzafuRGNnQw2M1/6mDeDC1Fh2VIrkXR6+QS6ad60DmnUwCLUN/2KbWPjsvyuOSWxmYcfjSrL1H4R91njSzmEofm8Nu5Lo7F88j/xMT2FaarmiW8hm8LScYUQ1rFHHj6U0DIb1cadw8Wpxue4klAEPZAf/cr1F2oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFlkG4kl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFlkG4kl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7195B1F000FF;
	Tue, 15 Sep 2026 12:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789474333;
	bh=dTvFOp6vSGe4AZsCgKO980b0BeYwtUxBQL5x62d5jw8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EFlkG4klTh9q0ksv7M1hSJKTTDQQe7H5iyO2zHATvBU+UXti67y8RU1/odOq/zhGR
	 VYQ/UthUrZvWy+XndwZ77DKsyT/9Ri6pFxYRhTSWuJI+DH+4yLpyuhu8mAIrHMk8t/
	 6kDv1q8AwhLZ6F1rb+P8f3KP0PwnSljmvJWSc46nWvAQt32cRvhQ+HBCxLIdV4HK1y
	 DBbf6pk3x8FN6xy4faUytIL4oO+ojk8F8MkK5f1LgG4gC4ZmwrIhyHU1W79T6CKby7
	 mQNMHJsClSUixl8DuKxj7EGI22mNfTcwiHmk42y9GBCpJ9M/rUqbu9RbXfhHzUFMg4
	 vNY+QKqLhGlQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 38/50] perf: stop putting the event descriptor
 back on failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Linus Torvalds" <torvalds@linux-foundation.org>, "Christian Brauner" <brauner@kernel.org>
Cc: "Eugenio Perez" <eperezma@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Peter
 Zijlstra" <peterz@infradead.org>, kexec@lists.infradead.org, linux-um@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-snps-arc@lists.infradead.org, io-uring@vger.kernel.org, linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, "David
 Airlie" <airlied@redhat.com>, "Ingo Molnar" <mingo@redhat.com>, linux-arm-kernel@lists.infradead.org, linux-m68k@lists.linux-m68k.org, linux-hyperv@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mips@vger.kernel.org, linux-gpio@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-alpha@vger.kernel.org, "Oleg
 Nesterov" <oleg@redhat.com>, kvm@vger.kernel.org, bpf@vger.kernel.org, "Jens
 Axboe" <axboe@kernel.dk>, linux-hexagon@vger.kernel.org, linux-mm@kvack.org, virtualization@lists.linux.dev, "Jann
 Horn" <jannh@google.com>, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linux-sh@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-csky@vger.kernel.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-38-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-38-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:12:11 +0000
Message-Id: <20260915121211.7195B1F000FF@smtp.kernel.org>
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
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D38

