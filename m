Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3E64A843F;
	Tue, 15 Sep 2026 12:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789474578; cv=none; b=G1D5ynBUvR4T5tLltRev/zplB+aTf65nAO+PCOJ6aaBWRTe70enlNgxwL626qn7FanLcuMqLFSqrYaa5SW5m+xHS/LsGUgzuttJiTmOA5PHAeTk9MrLZhWsP6qIXY5QX18n05wt9532lmgnIl2Nr/d6VVXaIKpsfnDaLaLlpQ3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789474578; c=relaxed/simple;
	bh=NXoYVTwqvD2Mc3uJ8C8rBTgBxVVEvgW7tv7MPPRhfTM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DWr+hFaEKF7hzyn33RpEzsRMP5E5LlufTXsRCjM0V1tvAnCcN24WIxsoipXcD7cptMEVL2KMb3wjMzlkNPPbktuRFm83EFdiOC1QsYp8FY6eyqJYnHplZ8P9OayDM14WcWYpM1cdiAn4G17pmewKniDx0KBm+5rZLWoY9jRqwKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNterPT/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNterPT/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A99711F00893;
	Tue, 15 Sep 2026 12:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789474576;
	bh=NXoYVTwqvD2Mc3uJ8C8rBTgBxVVEvgW7tv7MPPRhfTM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CNterPT/ZD51jedu2KNQ9rOU/4D4o9j+Aviy118d7ID4ZpJ7DN5B0QTVxpbOLDEcp
	 WjkOW+IygybTEM7hIhEUp9B9F8q2tKZJbdjojW7c1kYBcsALaPVXdNvNpseaoF6sxz
	 d08hoYd15gcHpNwA06y/3FcZ6xOwqFvsocjr/EGRM5cC9tuus0kDJdaqEQg3Qm4M18
	 ZeSXiq47TwxgervFWeMWsQkRc5DykbFskWfeoeMxtxMfVCAG1jD+nF5Voy10SVLA4z
	 9vITY1nHgUqKUhmEPiCFbTS/22e9+k7WoslJgfuFNfW4pirOY8jtykHYXqI9jsapd+
	 +JW1ZdYPtifnA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 41/50] KVM: guest_memfd: stop putting the
 descriptor back on failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>, "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, sparclinux@vger.kernel.org, "Jan
 Kara" <jack@suse.cz>, "Jens Axboe" <axboe@kernel.dk>, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-gpio@vger.kernel.org,
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, "Jann
 Horn" <jannh@google.com>, linux-sh@vger.kernel.org, "David Airlie" <airlied@redhat.com>, "Michael
 S. Tsirkin" <mst@redhat.com>, linux-csky@vger.kernel.org, linux-parisc@vger.kernel.org, bpf@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-hexagon@vger.kernel.org, "Eugenio
 Perez" <eperezma@redhat.com>, "Ingo Molnar" <mingo@redhat.com>, "Peter
 Zijlstra" <peterz@infradead.org>, dri-devel@lists.freedesktop.org, kvm@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-um@lists.infradead.org, linux-mm@kvack.org, virtualization@lists.linux.dev, kexec@lists.infradead.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, linux-hyperv@vger.kernel.org, "Oleg
 Nesterov" <oleg@redhat.com>, linux-openrisc@vger.kernel.org, io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-41-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-41-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:16:14 +0000
Message-Id: <20260915121614.A99711F00893@smtp.kernel.org>
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
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D41

