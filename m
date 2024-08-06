Received: from mail-4027.protonmail.ch (mail-4027.protonmail.ch [185.70.40.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5797C8F6D
	for <sparclinux@vger.kernel.org>; Tue,  6 Aug 2024 02:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722909740; cv=none; b=XKCa0rZ/anlK7DcCTbV6Ju7PoL7m5ZFeAkH8SdtmAMoGS/QHreJnJvs3jbjuiZXbt8IJEBuDOy45X+Pjm/eZDb+xNxBuSKkf/YtVNv+7E3QAZxgjG3jaZwUTrEoXtPz1rb3Kb82nH8MMdnkOjgxexM3kDr1hDSCprFMPM9keuLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722909740; c=relaxed/simple;
	bh=etTwG97BDmpG0wRgq6Sl/c7ED7dV6g9senIVyhSWI8A=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JhNqGTjj5sHu3YhaJMpaQpDrL4qT6jlYcO7T9YEApE2CTkipHUSIp7vxwLe5mx/lRAMUYpQB4ouZKKHLJraNPK3/m/nhWQxKRxVLYl/z2bUPUk6f+pAjGKPhOZuxwaA87WE381U/nM3G48vCfTqXP3wl3LTDW7GPSUyh6p90edw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=JXGfDxgh; arc=none smtp.client-ip=185.70.40.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="JXGfDxgh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1722909731; x=1723168931;
	bh=etTwG97BDmpG0wRgq6Sl/c7ED7dV6g9senIVyhSWI8A=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=JXGfDxghlO8z9gOXaWnp0G0alZS4VmAnc+BKQlngCzCXzYRlObFhwp5GOLWxCN6cJ
	 ID41FEjsXUmBNCvpfDWXdZr39/oNZvtLNvbMGHa610CEZcrwYVCwlda+tJXkSKuQ2x
	 BQY/39bQkMiMEQTCqdZMMzj7VxeAbPp6YPwoUafl/dnzEltvhAYze+309G7ov3/quX
	 y8NgdFUnhBJeCjPzZRIPaKyYUzzYrs/iAiDIQEWVKRXaoAm8cwIAeGKl6Lf2pSDELX
	 AaYkG2XSGudJyaYfd0xFSGuaL+mlCm3V3zto05KIvQBlSRFTTfwhxgR/+su/YpDIWm
	 xMAoJY7MEGvRg==
Date: Tue, 06 Aug 2024 02:02:05 +0000
To: Thomas Gleixner <tglx@linutronix.de>
From: Koakuma <koachan@protonmail.com>
Cc: Koakuma via B4 Relay <devnull+koachan.protonmail.com@kernel.org>, "David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, Andy Lutomirski <luto@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] sparc/vdso: Add helper function for 64-bit right shift on 32-bit target
Message-ID: <w1fb5rPVjG8-NhVeqDTLxIpkRivcIPd0kDgm0bUQGGxXaVpPABsOAZ0-AHoRKL5O1M1T5MpBJqMdoQIjDh6QgzNuq4R7__RxDdVuVo4pbZA=@protonmail.com>
In-Reply-To: <87y15c5c9u.ffs@tglx>
References: <20240804-sparc-shr64-v1-1-25050968339a@protonmail.com> <871q3470nn.ffs@tglx> <Y5IejvnMTMbzucl5EK4C9ptWTnkPJlPJVKyCj1L1o2_2GPbmY5GZ55bKckWzKATaZcFF9SLCcvI4EMOhG3sifxCgEtkSdV2KDhv5jRBy9wk=@protonmail.com> <87y15c5c9u.ffs@tglx>
Feedback-ID: 6608610:user:proton
X-Pm-Message-ID: dcb32736b7faa89f63e46125b46248e62104a25c
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thomas Gleixner <tglx@linutronix.de> wrote:
> I think so as sparc is having it's own VDSO implementation and does not
> use the generic one.

Understood. Lemme move the function to sparc code then.
