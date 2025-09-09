Received: from libero.it (smtp-36.italiaonline.it [213.209.10.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3F2273803
	for <sparclinux@vger.kernel.org>; Tue,  9 Sep 2025 15:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.209.10.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757433020; cv=none; b=jtWlf9NUF/1VzcDUV/hxh9rl2mFRMC9T1Lm/qJY7Xv9GIrd7lnORvd6gqwSEuKjKlWqWMO80YFVGR8szf7BWaxJWTz3nQLH7F7tptuoCcvrJ2t4WLNkDm6MrTU+f3tJJzbk7WWErJfeCjZhUCuebLTu+NONLUXlZ2VLvxQMNt2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757433020; c=relaxed/simple;
	bh=RDcXHv+IHgFgES58Kp4tOGSQBkMIBIoLvKHTlN7BvTs=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=dPm5pi/Lp4xmolMMpeJm+cZlzoQIO9wvHZxSRokhzAomtaa6oYeKLFjTHiuOMwwrm4K+bbqG6tem/rF3Ult1WCJJzyF0aw8qi3wnniH8U2H0Mz+swmrkM92ewlpZtnTZJe+v68eE/B1T5oULnimGSg3bwtgBcqQ7mzAzc5TPpbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it; spf=pass smtp.mailfrom=libero.it; dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b=nPeTwEdR; arc=none smtp.client-ip=213.209.10.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=libero.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b="nPeTwEdR"
Received: from [192.168.1.36] ([151.55.182.102])
	by smtp-36.iol.local with ESMTPA
	id w0ZFuCZgSLyOXw0ZFuAFR6; Tue, 09 Sep 2025 17:47:38 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
	t=1757432858; bh=9NxrW/YgU/8CzQBhlsUJAUkqy9PbRa45pV3qWfLJFyE=;
	h=From;
	b=nPeTwEdRo4+5LTytP3vwn4XSLGvnyy9wV+xi9/zvFG6OvGj2hOrcGtruk3b9Rclgl
	 OqvaY5rsFy66zSOohbL/Ryjgr1vQGoPSbo5fZXHcw6FX0/Pjn0GdMW80/1HNi12h12
	 jZVFahOzoSbd5u/d4BCD/9XKyee3EsacR9C9J/XnwjGvOkDzG/diCgZIz52zpzpOf2
	 NJcgbIkehFqoPCXHhot/z79Y3UWuszC8HzZhrFFyA2VWTyiR0fljwGVjkSJaEPeftT
	 JiV0Zl8Urf0weTYrmkQBssIxMIWDsqxsQy+xi74vmplEdYq1uZ8SPOcCCZHU1kfX04
	 9BEt71MMS8/uQ==
X-CNFS-Analysis: v=2.4 cv=HvF2G1TS c=1 sm=1 tr=0 ts=68c04c1a cx=a_exe
 a=iX6ltAOv7qHpQETtHTMf+g==:117 a=iX6ltAOv7qHpQETtHTMf+g==:17
 a=IkcTkHD0fZMA:10 a=xNf9USuDAAAA:8 a=VQduBw7ONl7x0KOnPU0A:9 a=QEXdDO2ut3YA:10
Subject: Re: New test kernel available - please verify
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 "<debian-sparc@lists.debian.org>" <debian-sparc@lists.debian.org>
Cc: sparclinux <sparclinux@vger.kernel.org>
References: <46bbf1d2dc87a8f1cee11e835f931a2db7752044.camel@physik.fu-berlin.de>
From: Riccardo Mottola <riccardo.mottola@libero.it>
Message-ID: <674871bb-857e-e9c9-18ce-9a1d68120888@libero.it>
Date: Tue, 9 Sep 2025 17:50:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:128.0) Gecko/20100101
 Firefox/128.0 SeaMonkey/2.53.21
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <46bbf1d2dc87a8f1cee11e835f931a2db7752044.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfM9A8ZsUpPBQjNnRfvyrSGvsXvmWPtmtZhkEeBxsFC/y/SamTh7cxb9P/oRtH0wppgKNwKF4ZrFVCefQbFyI+nwP8JLX7YTcGvbPTBKdOb1ITokpBAev
 8AGhKLZoIhB7qEoawGQUcJA5GVo4Ae8MBeN8s6T2opcZiY3oJ5GHc75i8xE35MlayL3quScl5FviMxKAHzBA4TPXZ0yGiedl9E5vo3e/TDMCR9kKsIxR+xX3
 FpcTNdd6LsmvFwDd+NSR9iQPWHJCkimjVUVKn4tWyFiuKrW9y4kH+nQ5PoT/3O4f

Hi Adrian,

John Paul Adrian Glaubitz wrote:
> I just uploaded a 6.16.3 Debian kernel package with:
>
> - all patches by Michael Karcher to fix copy_{to,from}_user
> - the patch by Anthony Yznaga to fix HugeTLB support on sun4u
> - support for transparent huge pages disabled
>
> Packages are available here:https://people.debian.org/~glaubitz/sparc64/
>
> Please test and report back!

a bit old news now, but yesterday I tested this kernel (I saw there is a 
new one... will test that too) and it installs and boots fine for me on 
a Fire T2000
It works with a "warm reboot" too.

I was able to compile on all 32 core, use git, do some apt-get upgrades. 
I surely stressed CPU, Disk and Ethernet decently. No evident issues found.
Of course, not testing of multi-day long running stability.

Riccardo
