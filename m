Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E654AA1E6;
	Tue, 15 Sep 2026 12:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789474192; cv=none; b=mE4wQx0qVsZ6wJX2Iz6o1SEKnbFRFHURzCHb2e3Fpefw3Xe/a3YbgBFSqNVix3dWF2FNuE2o3sxpmsl6GU9P2IDq29HpjzSiddJvAn44XU66waKYNjTZzg7wMvg5FdPyEXQi2cwnsf7ivJ1wMuFjNIzz6la4822OhQtgTK/ZWc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789474192; c=relaxed/simple;
	bh=zv1rNZvSCHkzISCnzIgvhR1XdclekSPPoj8rLv8Qezg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LHrItDUbBnls/uXjHrKCPMzP7U0R3qT1+XmJnse6Uny2lK01EE6PVnNl0eO7Br02+ed5d68G3aogyFXRouw65A/SXsiMNZ79PqA5wAMCa1xOctyNeJrceXszZtDWRarlxii6PgDPbrAUm9dGlPng/FSny81fBKMQeh+AhzjE9RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4ZZV63E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4ZZV63E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 464481F000FF;
	Tue, 15 Sep 2026 12:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789474190;
	bh=zv1rNZvSCHkzISCnzIgvhR1XdclekSPPoj8rLv8Qezg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a4ZZV63EloWFTnOUlHK58XwOK2rkeCsu03ufhBV72Tiipl5qWiGg8pKw75jRnalat
	 Px+Ej4QbTLpchvWen5UHVg+abfR3qMIoHWKRq5zOfC+6fvUdhpGBml50Plsl14BxoA
	 MD9L1UkPG2s8tttZuNhCrGp0Ac838MyFzPadcw7MIZBEqZ9CQQXdlYMZFCITTIwQVR
	 e8ZVbA+QeVGcVPqWoOLbEKnwhY2HpmkZP6Db2SJHGUaetI9dgl3FBXgJQQpNHkGFqv
	 7oyl/HjPvr3DAOtUTzbk2i14RAaCiMZAvTqJbij4737kik3jJY1RQy1e4vJFFsF6gN
	 uDBgNLmQTLN+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 32/50] liveupdate: install the session
 descriptors when the ioctl returns
Reply-To: sashiko-reviews@lists.linux.dev
To: "Linus Torvalds" <torvalds@linux-foundation.org>, "Christian Brauner" <brauner@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Jan Kara" <jack@suse.cz>, linux-gpio@vger.kernel.org, "Oleg
 Nesterov" <oleg@redhat.com>, io-uring@vger.kernel.org, bpf@vger.kernel.org, linux-openrisc@vger.kernel.org, kexec@lists.infradead.org, "Eugenio
 Perez" <eperezma@redhat.com>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Ingo
 Molnar" <mingo@redhat.com>, "Peter Zijlstra" <peterz@infradead.org>, "Jann
 Horn" <jannh@google.com>, linux-hexagon@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org, linux-mips@vger.kernel.org, linux-um@lists.infradead.org, kvm@vger.kernel.org, "Jens
 Axboe" <axboe@kernel.dk>, virtualization@lists.linux.dev, linux-snps-arc@lists.infradead.org, linux-fsdevel@vger.kernel.org, "David
 Airlie" <airlied@redhat.com>, =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRh?=
 =?utf-8?b?YmxlKQ==?= <brauner@kernel.org>, linux-parisc@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-sh@vger.kernel.org, linux-csky@vger.kernel.org, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-32-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-32-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:09:48 +0000
Message-Id: <20260915120949.464481F000FF@smtp.kernel.org>
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
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D32

