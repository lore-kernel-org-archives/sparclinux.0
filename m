Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10716390C9E;
	Tue, 15 Sep 2026 12:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789474863; cv=none; b=lfBvNSLvqg1A7a1zmU2sISv+n6KRb21kMcWHYs+zVhQ5Z/hFog0AHOHLkuKLvI6huSv3xLxH6uxnlJdHj8/wk0/PbUruj5ZtXd2sL5Ellel3eb4UUM27oaRK/kKC8OjBz/cQoeYPRu+wMOeo0l5MKQT1uyx5uFRInjWdtcWjOT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789474863; c=relaxed/simple;
	bh=vonrQofTMqh1TZ5f0j9SBLxkepNFIrQaGLKCiSWoy/A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g3dw9vwb4GBGQUmvrFzNC7MX+YdGvRGVNpotyvV99izrx/lIy7rCJXyfbFJmaHgPLcH1JTSC7uPN144KYhzsO62VqWXzsONIXQCWcTGIFcMrPtkBv4dpa0QGHtDjA7/mfL+ohwmTipLbYXm4k2xVy7YX8HRgSSHbP9cemXvbYec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/LXiHVz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/LXiHVz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDCFD1F00893;
	Tue, 15 Sep 2026 12:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789474861;
	bh=vonrQofTMqh1TZ5f0j9SBLxkepNFIrQaGLKCiSWoy/A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A/LXiHVzihnaMdFTMhS3rVKx/wDAkjfj2gDEj8DTAYNjfOe6DG+9Ca/cCtFyPhPE8
	 y77qZBSfSC9sS4k/RUcIcuvRnjcCwtLvS7YSZE1xN5GAlkblWsWACrRhYCN5wIFKor
	 zT8EpjnA5d63Lul165thqtWkMhkC99tbZwqRFOqKxO0tRQPj3pAlGire6kQh45O8b2
	 eS2NZ8W+DwDtB+jiWr5CwIe6sK7rjGmOKgcSbUdZiQO/XTHrxK9zTNOllt/wu/a1To
	 v55MzO0WPliGPDb7kJyu1DDpQ4ZeGJMNQLBjGR50wccFbjBl7QsDZheHlcTEqD3nHg
	 F55P5vgYAJ68w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 48/50] misc: fastrpc: install the dma-buf
 descriptor when the ioctl returns
Reply-To: sashiko-reviews@lists.linux.dev
To: "Linus Torvalds" <torvalds@linux-foundation.org>, "Christian Brauner" <brauner@kernel.org>
Cc: =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, sparclinux@vger.kernel.org, linux-csky@vger.kernel.org, linux-sh@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, "Oleg
 Nesterov" <oleg@redhat.com>, linux-alpha@vger.kernel.org, io-uring@vger.kernel.org, bpf@vger.kernel.org, "Peter
 Zijlstra" <peterz@infradead.org>, linux-um@lists.infradead.org, linux-snps-arc@lists.infradead.org, kvm@vger.kernel.org, dri-devel@lists.freedesktop.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Jan Kara" <jack@suse.cz>, linux-hexagon@vger.kernel.org, "Jens
 Axboe" <axboe@kernel.dk>, "Eugenio Perez" <eperezma@redhat.com>, "Ingo
 Molnar" <mingo@redhat.com>, linux-mm@kvack.org, linux-gpio@vger.kernel.org, linux-mips@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-openrisc@vger.kernel.org, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org, linux-m68k@lists.linux-m68k.org, virtualization@lists.linux.dev, "Jann
 Horn" <jannh@google.com>, "Alexander Viro" <viro@zeniv.linux.org.uk>, "David
 Airlie" <airlied@redhat.com>, linux-fsdevel@vger.kernel.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-48-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-48-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:20:59 +0000
Message-Id: <20260915122059.CDCFD1F00893@smtp.kernel.org>
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
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D48

