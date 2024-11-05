Received: from sonic311-13.consmr.mail.bf2.yahoo.com (sonic311-13.consmr.mail.bf2.yahoo.com [74.6.131.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B3F1D3593
	for <sparclinux@vger.kernel.org>; Tue,  5 Nov 2024 11:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.131.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730807413; cv=none; b=cf3wW8Kef054IxYHLkvzEv2rtiMr562B9DhDA/g14L45bMle8jMak+SoXULHVr2x8ueSj8SOCzKjn+H6dfBsW8jnQZHZek/4BAeYDqiG32e7zPRbiokKk5QLVOkolZynChpFKRk2nG79wFh1gv68BwZjXUgl8pLBXLBEQNaDYhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730807413; c=relaxed/simple;
	bh=tS52rCBrcpWKiTeTm9uSHpHse+DERy5VYTWONFcwv6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zx3apsage0926ctRIm+0UELgdEDmv975ZJxni3oB8zhwWmx8Z9e+7rQXhUrVfp6tiBgqBgmQeFNAkxAwfCUoeHJ1ly48YLUiolzvBWGUx6Sbb8uZrMzZ/1uO7zq0FPKTzGW/eZPp2fvqcg7np73uS8IOKKB+WWaP6w0casPUYt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=sP0WG0k/; arc=none smtp.client-ip=74.6.131.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="sP0WG0k/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1730807410; bh=bNr+bsCtJR4SIgIfMdfvQHVugZNrzCt1K5Rqs3mhcTo=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=sP0WG0k/7nqTMGQalF0han+aO87y1zT5y7MUJKrZplk5m/XwJKont5X4fTAuvKb26Xsz1Cq0tY8IMcWRXSO/6gJnyzNPPwqqca7LM2iF9ycPoN6vPvBsqpK6HNa3EooSs5PR7XfIqf1JY25g5g6JW3zLmSFxhC8oP7KMTdLZX0wDd1MjAg8At3G5DST0c/nU2Q086muqZfI0gvA8l8I0YYYu7YAMEh5ZJpFQiZamSKkPU5rKzNj9CnC32ahRNCxGRrZIaG/1RvwqNqLXUylGCYuPotzzhUbQb25TiMc9bJk/DqIMWottExyUx6tJdudRktxdHrwrocDgkq8UgKctXA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1730807410; bh=nqEB2++ITuUveKJ0SMDcmpfmD7kZcp7S5rNg/GLCTwy=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=pFqLGWOtQq2sboJVbTHaCTSD+pumckxhQ1Z/bzS2eANS8/sgPCq5lnGnP/9jLvzZiDWsTaLwTeKVsleLkKYZuhDd/mFVKL8a+jut4Ia46/oQAk7GY1qdKpY2ZrIqBMOdldY9aPXw1u6kJDlDrDmgHl5+VbCnXCXXlCvsJ7WIKWzszTOynVFbH0F3iqKRPl5EhT8HxpdZFyibIW00thcfe/3HBSXO1JUg/l6XPV4zGHGYt/MPxhPSBlZkBGW2Rmw8L4x8OzGVFx8hMvF3mpQTyANHrYSs4Sm5db8kkbck4KolNE2yvaE5ipetzAJEyU7ZqVgQp63HDPzT05HNs71Faw==
X-YMail-OSG: .4bp9vYVM1mBG4ZRlN5fnnxXbf6lwfm.gADtuzMr38atsW58evNmxNvnJ5pDHCY
 RhwO6lYUL338upam1tP9LbW49ET0GiCXuhKVyiUMCygAXzShGIXEyutAY7u1XT0alEJV1itGNDrn
 Lwnlf8HJrbxC4ekUuR36UIntptC8WDH7aahsqayn_XUVQyyNIVvWqPbKBcB0WYHucI5j6rSy64_3
 vLZljeGzVFZayQ5.xPzlcZh3bmaZIb3qK6zFY2gZC.MpxM.Lod5gtrzHRyTrQW5R2tLlGfJktcI_
 YD2BopmWC9Dk7GVpirFhsVnIS_xGM.FnhGCTGbkwGli0IzGLhNoQ3fp1cPb6EhkjWBPi71tMMxbJ
 goEYmPMMWL0wx887jDMxDj5eh4DcO0rh7iWewMjjrh_6IX5bGsvHeQsJp3Ken_1zQjyGS33.c7ma
 lIAujE96T3XH0f66qSjWP9Ju0IjCSVMavMOKFnJtB2S9C0_UEklfwMElJDjrE31VYUzdLclsWXIT
 SjHWmn79Phxu3ne41XiznQT_4OOO6rQo_Oyfhv5HybnPfjEp42AuxrXCu1B_a3cxI1_zFGgvouFZ
 DYCi9aiUMqqaZLj9DiTzD9enir6.2oe2GRch8o7JV5oX.XzsiMdgZHxODsM8_tegj0uPQEwQ7EkP
 IedJNR4YZp7dzVTCbTBInsHqI5gqA4zqvN4la.mWv2ScEHyJCrUkhPW9TKwOClWcD9QBY64.IZ4Z
 5x.6hji7GlorfXILzzDSKkCiZDTf__SZEjz5OOGyoQbh4PoyYdOyglX.B4VHsg38BS3HpSt27QfH
 sngZEyaWBuEB7D6yD99pnS_p08_clg4DiIV1PsPZ4KSa0j3BkoY9mhLK3Ame0Zde_drEYhwfmVPg
 yJa6hXtVuQvEwz3gG9XE7BYUsnkpZuyF7XG_.HptPGhMcSToSOK43RnTFAXyIEvHf6cYsiv_ZJSe
 Nl7.4F9Kj6WVcX_DAbLQChL1H_L_A77T2R.S6ZlvNmuYxrHg6bwqfcvxBRci7_Gmr1wywbmxHDCb
 NJtF2x3tFJEYCLbrNkzM5KODw.ONuxz6wD6x.85xZy9JAaP4MwmaiSwOJKR.tDXQ988E8JIHk6Fg
 KtpKHfoh6yH8YbX8zB6DjgOTWh320h7SGFexb2QSg9vjAqNHTfrKFjb999IQ1Gtz7AQHMl5VOqpm
 JEosbQxLkyv0NLMBtfgtzBM5ubPkKGrIx9RplLiZu6Z8MioUqGLPIQ0zujqFSyTztaf5.Xh2xotJ
 PbslYhg1rb53KO7KheaE3ae8Ot6th3EY.lMBcemuoaRG0IGiokyZqUAqXuUW1l7mrDQZyGFmZRSu
 bTRFmF8BHw6RgX.lJbILMeNpd2cqm2Rdmc6o.SF_Y_QKb8Sa7SIxL.Kt3opEvxVkr1XGK5fJ4KzF
 UaWKFhzw6_wcrXG8nHSsqGsbjCM_tJ9F5mB6_EAzxJ5pnL0gfnk4MkdrEIXh.lzILIx8gNch8wNr
 m7dc80m6Mpj8UD7mIFu.VOUsEu9KK_YHRghLZ9l.WfTO5kxpQs5gGeUCvmT6xeI7QqJPAW8b36vp
 v6vw4fuje30xvvsSoZf_wWgljI3LrJlbzROq0Ns02xGxvtUj9Nx8afUgkcILmKj63E5ptzSyEuKB
 Is02WRBY.iG3.s9LbYEOeGPV8i9PwmiyCJEgXLi76s3yH6Xg_sA58RrWwH8UWj.kZM0U4IDHmxnA
 aXbocrW7MItD6bP9rUNNHGIiRVQIx7CyUZuJ0aa5dqiEJRIPp8i5KU5oUVUaVSf2FQA1aHeLLucr
 oO5oCdQeEcLjkc0cATSqIimpfOjv_rCTYWprzXIqooKh3S..PbqyGTdrQywGBvKVe6LhPOv1kT32
 _SVz2mDffSYnQt_kJ4jimoqPwXkj.PMbqXPvWl.7OLz_NAU99ee8QIDBWXiUnG2Dc5ppxur0VZYK
 VT3N4Sl0HcXmFL95XZac_Ts2Mkg_RsTh73WrWwwFRLnzd2SfneBzGhK5ClUcYzuqD9JhM9wd.Rvw
 FxN2HDZ4yF3gWAelndaTlDG0Qu.j.0Ze4qELnPhNc2CVfHakP73YFsv4awK6poCbVWAntP4695ml
 yYEY.AHR1Yo80jk6rEl6srik2uFy1n_CMnlC2IriRMiP80Y_gZ6tk_eWsPdsNoRaZ_RLP99n89q1
 kzTvSGnpVzUyJ6Vd3t9JED6AFJMIoV.aUwlv.7q2Rx9bAodiM_rlaNWvTUyM8_qjpYSmhCXMfy_q
 MW1V6GIBFhJ9GZcP6NzcwPD6kQwFlDAHtsrB2dJlMOG._BQwsJ3K_ptCzzJ6_AclaQts-
X-Sonic-MF: <dullfire@yahoo.com>
X-Sonic-ID: 393d9c79-1674-40ac-9170-95035d8fe9f1
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.bf2.yahoo.com with HTTP; Tue, 5 Nov 2024 11:50:10 +0000
Received: by hermes--production-ne1-bfc75c9cd-n46s2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 25849c82f1c1524deb6cfb87a0930b74;
          Tue, 05 Nov 2024 11:40:02 +0000 (UTC)
Message-ID: <02ec93d6-3cf6-410d-a887-1a625fb7be82@yahoo.com>
Date: Tue, 5 Nov 2024 05:24:42 -0600
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel panic with niu module
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: davem@davemloft.net, sparclinux@vger.kernel.org, netdev@vger.kernel.org,
 linux-pci@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
References: <20241104234412.GA1446170@bhelgaas>
From: Dullfire <dullfire@yahoo.com>
In-Reply-To: <20241104234412.GA1446170@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22806 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 11/4/24 17:44, Bjorn Helgaas wrote:
> [+cc Thomas, author of 7d5ec3d36123 ("PCI/MSI: Mask all unused MSI-X
> entries")]
> 
> On Mon, Nov 04, 2024 at 05:34:42AM -0600, Dullfire wrote:
>> I have also bisected the kernel, and determined that  upstream commit
>> 7d5ec3d3612396dc6d4b76366d20ab9fc06f399f revealed this issue. This commit
>> adds read to the mask status before any write to PCI_MSIX_ENTRY_DATA, thus
>> provoking the issue.
> 
> 7d5ec3d36123 ("PCI/MSI: Mask all unused MSI-X entries") appeared in
> v5.14 in 2021.  Surely other drivers use MSI-X and would have been
> tested on sparcv9 since then?  Just based on the age of 7d5ec3d36123,
> I would guess some kind of niu issue.  But Thomas will know much more.

Yeah, I wasn't very clear: I believe this problem is specific to the niu
module. My suspicion is hardware errata and/or an issue in the builtin
hypervisor.

My T5240 has several other PCIe devices, none of which exhibit this issue.
I will have to check later if any use MSIX.

Speaking of test cases: It is worth pointing out that any write to ENTRY_DATA
appears to be sufficient to allow subsequent reads to that MSIX table entry
to work. Notably, booting into a pre 7d5ec3d36123 kernel, and then rebooting
into a newer kernel will succeed, because the registers were written to under
the old kernel. I had to power off the unit to reproduce the issue if a
kernel successfully initialized the device.


Regards,
Jonathan Currier

