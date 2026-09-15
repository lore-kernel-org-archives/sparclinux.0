Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1666D3BFAC0;
	Tue, 15 Sep 2026 12:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789474441; cv=none; b=dogB4jYghMKo3wyaOTMJ5iEg7r+pTFah/cPbbdYCf5eTPMsWVRgvL4Pm2r/bHRlIYsIBVtc295Q5PvUlGHEf02qZ4lTru69JVT6aS2WidXIA2OICPWcz7nFyiuECHcBYr+oCKtSIbOPlmsRMf5zmpaNrT9GZF3yJNik2HIKLBWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789474441; c=relaxed/simple;
	bh=N/qDC8w+78iGOR02PfeQ9lasCpgoFwlOJHnQ1mx3Dgc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JzwiVcHe/r1UG+g3cNzysJSYGD5+F5CIwztxHOlOqD782vCgoV2o3CfjsVUGkziHiPLprGuJFidZjAvVXWmmlS9HZzkhwElEmHTykW3Y0g1bn3aWdla+DbJ016NWfu53nuA1L6tyC6uT2HZYOrnnF37rJD2Di9bfIHvAIA6ybos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CvwdtYpl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CvwdtYpl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C2741F000FF;
	Tue, 15 Sep 2026 12:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789474439;
	bh=N/qDC8w+78iGOR02PfeQ9lasCpgoFwlOJHnQ1mx3Dgc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CvwdtYplEMqh0mXb9UtTtEzUPZjlErl5BgHWZ3BUuzKN64/50zHMmE8tVi+y1B3X3
	 tAYkfuPSB1IfE0nhCXR7lcqXNSl51VqpY+L+oymG9YPh17XOrUi8G3/Aa+dnQeYFRj
	 NcQX+8avtvTCjCij+9TYtbgkkb7afe60hNSTSaGvh1L3t7pyiz8fuqxatGkMKmaKvM
	 8XOgUv1cgX6wWpD+3GvwOhIJtw3OnoMVeiRhGh4LZXzdsV358kdYIG5GabAq3BtAXs
	 I7hVAiVBYRClyrA05Lt47fHM9pl9LGtyPE+6dxCTPgbrcsy0AbO5y7C+JwxLWRY8kE
	 FeK/23S/8IuyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 35/50] ALSA: compress: install the task
 descriptors when the ioctl returns
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>, "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: linux-parisc@vger.kernel.org, =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFt?=
 =?utf-8?b?dXRhYmxlKQ==?= <brauner@kernel.org>, linux-arm-msm@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org, linux-mips@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, kvm@vger.kernel.org, io-uring@vger.kernel.org, kexec@lists.infradead.org, linux-m68k@lists.linux-m68k.org, linux-hexagon@vger.kernel.org, linux-alpha@vger.kernel.org, "Ingo
 Molnar" <mingo@redhat.com>, linux-openrisc@vger.kernel.org, "Oleg Nesterov" <oleg@redhat.com>, "Jens
 Axboe" <axboe@kernel.dk>, linux-gpio@vger.kernel.org, "Jann Horn" <jannh@google.com>, linux-um@lists.infradead.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>, linux-snps-arc@lists.infradead.org, linux-csky@vger.kernel.org, "David
 Airlie" <airlied@redhat.com>, sparclinux@vger.kernel.org, linux-sh@vger.kernel.org, "Peter
 Zijlstra" <peterz@infradead.org>, linux-kernel@vger.kernel.org, "Eugenio
 Perez" <eperezma@redhat.com>, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-35-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-35-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:13:57 +0000
Message-Id: <20260915121358.1C2741F000FF@smtp.kernel.org>
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
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D35

