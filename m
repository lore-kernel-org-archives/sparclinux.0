Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DF63BFAC0;
	Tue, 15 Sep 2026 12:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789473743; cv=none; b=OLDXon3UDT/wLfRKYwOpUib94ELcq1gpCrOMZ0krlTtgJovkPUMlP3CR9y+QGF/kVW/yU5sRCqPGOonTO7rE36L7Hd81xdVgbcPsc5CV7A+ObaUSVjpKYt7FCJaBnt5IuZhbjCj8AkP9Ry4FC71rgA2V+6669aOkEbcRUnKU9tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789473743; c=relaxed/simple;
	bh=qcYOVYEeSBwNAHSV3oGOxIoOYP16KGnVjnu+hbqVsEY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eU0S6EVuTSiM1Ola574niElIIw8R2dSRZG2UUFsC2eS8wpfybdmidOPThG7k60b08rcZLvy2MCZETu+rpGeTfKfQChErbFq4Ov3evgrCzz/zhZvO8pWkFTLSDAqSzWKnZbk2VCOmzEVCgCBMQZN+pTlpGNNAv5bLZlIJmPAAe+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/BEG6N0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/BEG6N0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B2CE1F000FF;
	Tue, 15 Sep 2026 12:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789473742;
	bh=qcYOVYEeSBwNAHSV3oGOxIoOYP16KGnVjnu+hbqVsEY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f/BEG6N0RGxUq5W/HXCadDNiWy6mZwl9CV9CowG89trZuBhbvX/vWsAwHcKt0jPgW
	 SJ2ml9rORw02KpW+BBtA/RAwgHeaOMkDEM/bw2FOM3cvOGpK4o5aTZomhO8RUcQ5S/
	 HUGzy85d+v2Rl885i1mtVPRNCYfGq7VMLkzir6Qo74z8OfaWUxRKM2kqLaxvoO35hD
	 g2OjURXxrNOf5LxE5EULxkvtM4dwb4/ru0HDhvJo0tuYkl76FUzGi2h5pCD/fdlSaR
	 IpwMuTLI+Jg1YfgtVCyH+xGpSt50Q2kgFNlZVyEcwXh9ZMIlgJii4H6dAqtEZuqtWP
	 6++8DIfAg5DTg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 20/50] file: warn when the descriptor table is
 unshared with slots
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>, "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-csky@vger.kernel.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, dri-devel@lists.freedesktop.org, "Jan Kara" <jack@suse.cz>, "Jens
 Axboe" <axboe@kernel.dk>, "Michael S. Tsirkin" <mst@redhat.com>, "Jann Horn" <jannh@google.com>, kexec@lists.infradead.org, "Eugenio
 Perez" <eperezma@redhat.com>, linux-mm@kvack.org, linux-hyperv@vger.kernel.org, linux-mips@vger.kernel.org, linux-hexagon@vger.kernel.org, "Peter
 Zijlstra" <peterz@infradead.org>, virtualization@lists.linux.dev, linux-snps-arc@lists.infradead.org, sparclinux@vger.kernel.org, linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, io-uring@vger.kernel.org, "Oleg
 Nesterov" <oleg@redhat.com>, linux-parisc@vger.kernel.org, kvm@vger.kernel.org, linux-sh@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, "Ingo
 Molnar" <mingo@redhat.com>, linux-openrisc@vger.kernel.org, linux-um@lists.infradead.org, "David
 Airlie" <airlied@redhat.com>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-20-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-20-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:02:19 +0000
Message-Id: <20260915120220.2B2CE1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>

> If the fdtable is unshared or the task exits we can't install
> reservations. The reserved fd isn't reserved anymore. execve() would
> leak the reservation into the child.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-work-fd-re=
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D20

