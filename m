Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F033F86E7;
	Fri, 15 May 2026 15:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778859347; cv=none; b=aTwmp5HLiR6ocUEc5JZqZ5yb/ypmRWT6kvs8zn4MNSaNmzy8a/Dqc0C2MxjH9Z0n1LvSDd095uHPNZ3qFIkY9zJ/6RGHj+OnpIhPQz28+Cgj4xwN+4j7E51IF4IlvOw42DfkRfRyeokH8E6uoHnjyJtN0d/U3Q86jW6Z0Bzf86g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778859347; c=relaxed/simple;
	bh=9VmW/xr1YBf+AG43drrsh9q6V8WW2V8pY8B8arP8K2U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hUmttsXmAnlf7EJxuif/CGtTYH/vsHkeWrOtp2fB0SRZ8UI2u+Grc9cFbsL0b68f+TMBaKFmSKcfgaad32JYmMrb4D9bQdBKzsECfeyUYqYk3m2vzHG7xkGvXmxqbS2bKEsbCr64v+kqq8xRZoxIEtn28cLUBIo1sks8drMjyTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VjJPZhp6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VjJPZhp6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A1A8C2BCB0;
	Fri, 15 May 2026 15:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778859346;
	bh=9VmW/xr1YBf+AG43drrsh9q6V8WW2V8pY8B8arP8K2U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=VjJPZhp6yF2hiF0vYz8FT1bA4Urs+04pW15Ha1kcNlR38fzSiW/Ap4yBbCH8Ewoxq
	 0KpAkxMW3qPlDFllL58v9aVOUaIGcJZXKiY0wSKMopB+fNhy2eX2dc/DMX5gBy9TWU
	 50UIGUOQAEIAiR1h/VQXgH+oD8ynpIVrjyvxYyLzEFUsctXddm44Pp/DEJjZDpwQhR
	 lLTPvBgfSM3zb3GMOIZ/lWiwcIf//vXLVaQVdU3HPi8+a2oAbRpZ4cd+rJRTvS1y3r
	 0TKpO8ypLNGmv8p1mdqOd7m+8aCGVihkkfx9NYqHIHSIFwbMjjgudozBZqKOwkQYGn
	 J0BFXvBIwO12Q==
From: Thomas Gleixner <tglx@kernel.org>
To: Tony Rodriguez <unixpro1970@gmail.com>
Cc: Linux kernel regressions list <regressions@lists.linux.dev>, LKML
 <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org, John Paul
 Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Thorsten Leemhuis
 <regressions@leemhuis.info>, Linus Torvalds
 <torvalds@linux-foundation.org>
Subject: Re: the stuttering regression in 7.0: should I have done something
 different
In-Reply-To: <0669f754-a313-4aa3-9923-0c374d49feb3@gmail.com>
References: <ffb44522-f01c-4be3-849d-27dc17fbca7f@leemhuis.info>
 <D5D19776-C809-4284-9417-F9A860877B98@gmail.com>
 <1c165caf-36b4-4673-97fd-ed86bef17b88@leemhuis.info>
 <3332123b-9e11-4895-9ab3-1707fba5815c@gmail.com> <871pfj9cmj.ffs@tglx>
 <a7a0d78b-435e-43c8-b436-5e7f4dd39dee@gmail.com>
 <088e6cfa-0167-4748-af6c-458ade2f303a@gmail.com> <878q9p82je.ffs@tglx>
 <64f465ca-6117-4375-9c4b-af771b8205fd@gmail.com> <87tssb6olo.ffs@tglx>
 <e45438e7-8501-4c10-95ee-07f118de8a51@gmail.com> <87qznez3tf.ffs@tglx>
 <0669f754-a313-4aa3-9923-0c374d49feb3@gmail.com>
Date: Fri, 15 May 2026 17:35:43 +0200
Message-ID: <871pfcznw0.ffs@tglx>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Tony!

On Thu, May 14 2026 at 21:47, Tony Rodriguez wrote:
> I=E2=80=99ve completed validation with the v7.0.7 release and v7.1=E2=80=
=91rc3 on both=20
> S7=E2=80=912 and T7=E2=80=911 systems. Everything looks good.

Cool!

> Thank you again for the debugging guidance and for the feedback on my=20
> original patch addressing the timer starvation issue. It was a pleasure=20
> contributing to the resolution.

Thank you for going through the hassle of chasing it down and providing
the debug data to analyze it.

I'm still puzzled how this went unnoticed for almost two decades:

   112f48716d9f ("[SPARC64]: Add clocksource/clockevents support.")

> PS: I agree that the second patch we discussed isn=E2=80=99t needed=E2=80=
=94the systems=20
> run correctly without it. The following patch alone is sufficient:

I assume this patch will surface on a mailing list with a lengthy change
log full of details and find it's way into the sparc tree through the
usual channels.

Thanks,

        tglx
