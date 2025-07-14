Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CD72AE6A;
	Mon, 14 Jul 2025 11:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752492419; cv=none; b=p5hOJtFr2/b8UvnAg61J/LBiC3hEVvtQN2eSbXeSoguDTDQqm3DC2y/1sv15ijbid8EfZPK9JyYL6VVYLLUFJlaCqqT1hJkPhgT3EBajV0yK6xYElOiQyjmlvXbE8yUOBXcs1ORPiPr9klHPt21+qFCpWOjkPXGiHs/+T5Ksl6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752492419; c=relaxed/simple;
	bh=/4V95CRtfbd/3O7RgqJEB1XdYsfeImRWko5hB5hEltE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HFlwiwRopSsVoZvVlRHg2sb4GS3r4N78Qc8w/FrxgFPAqJQ2qhtyTFl1psPehuWRxNPKUvlYgCDC3o+MkwGTAHcd+4X8y142Ky7Ts5jyNyMDEyogA8WnXc7rsIgDPcT1y+qycwFk4+PrHLruv1AYiPcTcJvFYZLXZBAstTg6dHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=g2ZtJ112; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="g2ZtJ112"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=d604JCr+fm0Ij6WyXxetKyt8k0KrVJKxNemJmU49p14=; b=g2ZtJ1124DPZBAOM3nJiLASX+m
	p/KqTe/dMJJLYMrQP/UyVoi7kSO0HgPDjLRXeh4oDx/M/z7mlPyfVwSEW6bN85ZUttQWWDkzFvlUt
	q94yGdSt5zLYu7aayK4uvHr2/JsoyS+1d+CbTxrkWHgWGAEs+HPuD9lUJ25M+pWDr+RtQ+ameJS6c
	Nmq8DYaThGAv4GJ+fSkkZL7y35Bs89OTSZfW1BOH5W0F83aUtQb7I/gSSRfWJ85fSxZ1S3q4oMPyd
	9EevVZgMOJsQu7XjFycIBzs5c5gF+bJvR21FQTQ3OkNWndl/Nai95sUqZspGzSmw9YOc0yysj2kA0
	szIxmIEw==;
Received: from 179-125-75-212-dinamico.pombonet.net.br ([179.125.75.212] helo=quatroqueijos.cascardo.eti.br)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1ubHKS-00GOGq-M3; Mon, 14 Jul 2025 13:26:41 +0200
Date: Mon, 14 Jul 2025 08:26:34 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>, linux-kernel@vger.kernel.org,
	linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
	Zijun Hu <zijun.hu@oss.qualcomm.com>
Subject: Re: [PATCH v5 5/8] char: misc: Fix kunit test case
 miscdev_test_dynamic_reentry() failure
Message-ID: <aHTpaoI8IfkSKm3O@quatroqueijos.cascardo.eti.br>
References: <20250710-rfc_miscdev-v5-0-b3940297db16@oss.qualcomm.com>
 <20250710-rfc_miscdev-v5-5-b3940297db16@oss.qualcomm.com>
 <aHADQWaYsjK5EYsN@quatroqueijos.cascardo.eti.br>
 <8a0bfdc6-5edb-4ca0-b142-067eb94ef57f@icloud.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a0bfdc6-5edb-4ca0-b142-067eb94ef57f@icloud.com>

On Mon, Jul 14, 2025 at 09:02:09AM +0800, Zijun Hu wrote:
> On 2025/7/11 02:15, Thadeu Lima de Souza Cascardo wrote:
> > Adding a failing test and then fixing the code does not seem the best way
> > to justify this change. I would rather add the fix with a proper
> > justification and then add the test.
> >
> may need to only correct commit message. the order about unit test and
> fix may be right as last reply.
> 
> > On the other hand, I have found real cases where this might happen, some by
> > code inspection only, but I also managed to reproduce the issue here,
> > where:
> > 
> > 1) wmi/dell-smbios registered minor 122, acpi_thermal_rel registered minor
> > 123.
> > 2) unbind "int3400 thermal" driver from its device, this will unregister
> > acpi_thermal_rel
> > 3) remove dell_smbios module
> > 4) reinstall dell_smbios module, now wmi/dell-smbios is using misc 123
> > 5) bind the device to "int3400 thermal" driver again, acpi_thermal_rel
> > fails to register
> > 
> 
> above issue should not happen with current char-misc tree since fixed
> minor have no such reentry issue:
> 
> for any fixed minor fixed_A in range [0, 255): ".minor = fixed_A" ->
> registered -> ".minor = fixed_A" -> de-registered -> ".minor = fixed_A"
> , namely, for fixed minor, it is always un-changed about registering
> and de-registering.
> 

I am running an older tree, where the misc range is still below 128, but
notice those numbers are in the dynamic range. Those two drivers are using
the dynamic misc. I am just showing that what you are trying to fix here is
a real issue. And, below, I suggested a paragraph in the commit message
mentioning it.

Cascardo.

> 
> > I think we have a few options to fix these bugs:
> > 
> > 1) Apply your suggested fix.
> > 2) Fix all the buggy drivers.
> > 3) Change API and have the minor be a misc_register parameter.
> > 
> > The advantage of your option is that it is simple and contained and easy to
> > backport.
> > 
> > Changing API would require changing a lot of code and hard to backport, but
> > I find it less error-prone than requiring the minor member to be reset, if
> > we end up deciding about fixing the drivers.
> > 
> > As for fixing individual drivers, one helpful feature is applying your
> > previous patch [1], but perhaps with stronger message, maybe a WARN_ON.
> > 
> > [1] char: misc: Disallow registering miscdevice whose minor > MISC_DYNAMIC_MINOR
> > 
> > I am leaning towards your suggested fix, but with different wording, and
> > before adding the test case.
> > 
> > Something like:
> > 
> > Some drivers may reuse the miscdevice structure after they are
> > deregistered. If the intention is to allocate a dynamic minor, if the minor
> > number is not reset to MISC_DYNAMIC_MINOR before calling misc_register, it
> > will try to register a previously dynamically allocated minor number, which
> > may have been registered by a different driver.
> > 
> 
> let me correct commit message based on this suggestions.
> thank you.
> 
> > One such case is the acpi_thermal_rel misc device, registered by the
> > int3400 thermal driver. If the device is unbound from the driver and later
> > bound, if there was another dynamic misc device registered in between, it
> > would fail to register the acpi_thermal_rel misc device. Other drivers
> > behave similarly.
> > 
> > Instead of fixing all the drivers, just reset the minor member to
> > MISC_DYNAMIC_MINOR when calling misc_deregister in case it was a
> > dynamically allocated minor number.
> 
