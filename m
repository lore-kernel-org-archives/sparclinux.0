Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031A11DDD1;
	Thu, 10 Jul 2025 18:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752171356; cv=none; b=YTog66vNrlAbTZIMdAH1liI8DlCwzdPlnEoaLJuWcuMRHNP+mPQUU7wGYoxqqPbDFjv+W1YXeHChNU0z3T0+6XM2fQqpcJFQofdEXZ+ffoMMd8H5z719wHaPKglVXuynV1rDAWI6x3w6HzXSoDZTiUGjjgOPzT7eJmju3o+S/LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752171356; c=relaxed/simple;
	bh=9inaX+3610y3kgvqwT80kU2cH9rsrTcWoX6dbe+5BTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lNyLoSd2SyfRV17m4ngQbQmyhgzJgGQ5HT/c85RsxRTInD5BXbObFS1ZifeEK0Jm7NrVqAhWZQzqorIIgauxhMeT1vvYLEurolnjWbDxsM8Km2hiZU2zQcwR4KQh4RO/93L+WtnYui4/RjoPSGeRBl0ukdyXZv2sagtwHiQv4hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=O9I09H/X; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="O9I09H/X"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=lLWXUQzhV/Fw+wxvfrB+u3B5fxF8uh6fzjF4UfnLCxs=; b=O9I09H/XBJz6uY2MCYzpAt/Ri0
	23D770vfAO7fYlc2J6HBzHsKPsbNhoDZu/FW9uXXTQfmUKz6r6QGy/gLHwKEHb2SjntNTo6PzNC51
	PqySP9LTj5NU3FgCJ/dduD+Jzyor5ClBoFfRbS9YPJOktqkKBEK4aKvA2CzuoHToEWMiUWlcu/ViW
	MFxF73dIavMnoYU8vm6lZHusp9ojHdfuekRFTZMAQitA5ZaXpSy0VvCFYn9Rd2dHVU/982FGToP77
	WtXcbnmkAfDpFJ6w4XJnpkerHf4pOc8xYicn4U2cAj9uKWoeE8+0X4/uxSRfUdmpgnnhQNUGgHnZH
	SykyZgwA==;
Received: from 179-125-86-110-dinamico.pombonet.net.br ([179.125.86.110] helo=quatroqueijos.cascardo.eti.br)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uZvo0-00F33z-QZ; Thu, 10 Jul 2025 20:15:37 +0200
Date: Thu, 10 Jul 2025 15:15:29 -0300
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
Message-ID: <aHADQWaYsjK5EYsN@quatroqueijos.cascardo.eti.br>
References: <20250710-rfc_miscdev-v5-0-b3940297db16@oss.qualcomm.com>
 <20250710-rfc_miscdev-v5-5-b3940297db16@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710-rfc_miscdev-v5-5-b3940297db16@oss.qualcomm.com>

On Thu, Jul 10, 2025 at 07:56:48PM +0800, Zijun Hu wrote:
> From: Zijun Hu <zijun.hu@oss.qualcomm.com>
> 
> misc_deregister() frees dynamic minor @misc->minor but does not
> reset it to macro MISC_DYNAMIC_MINOR, so cause kunit test case
> miscdev_test_dynamic_reentry() failure:
> 
> Invalid fixed minor 257 for miscdevice 'miscdyn_a'
> \#miscdev_test_dynamic_reentry: ASSERTION FAILED at misc_minor_kunit.c:639
> Expected ret == 0, but
> ret == -22 (0xffffffffffffffea)
> [FAILED] miscdev_test_dynamic_reentry
> 
> Fix by resetting @misc->minor to MISC_DYNAMIC_MINOR in misc_deregister()
> as error handling of misc_register() does.
> 

Adding a failing test and then fixing the code does not seem the best way
to justify this change. I would rather add the fix with a proper
justification and then add the test.

On the other hand, I have found real cases where this might happen, some by
code inspection only, but I also managed to reproduce the issue here,
where:

1) wmi/dell-smbios registered minor 122, acpi_thermal_rel registered minor
123.
2) unbind "int3400 thermal" driver from its device, this will unregister
acpi_thermal_rel
3) remove dell_smbios module
4) reinstall dell_smbios module, now wmi/dell-smbios is using misc 123
5) bind the device to "int3400 thermal" driver again, acpi_thermal_rel
fails to register

I think we have a few options to fix these bugs:

1) Apply your suggested fix.
2) Fix all the buggy drivers.
3) Change API and have the minor be a misc_register parameter.

The advantage of your option is that it is simple and contained and easy to
backport.

Changing API would require changing a lot of code and hard to backport, but
I find it less error-prone than requiring the minor member to be reset, if
we end up deciding about fixing the drivers.

As for fixing individual drivers, one helpful feature is applying your
previous patch [1], but perhaps with stronger message, maybe a WARN_ON.

[1] char: misc: Disallow registering miscdevice whose minor > MISC_DYNAMIC_MINOR

I am leaning towards your suggested fix, but with different wording, and
before adding the test case.

Something like:

Some drivers may reuse the miscdevice structure after they are
deregistered. If the intention is to allocate a dynamic minor, if the minor
number is not reset to MISC_DYNAMIC_MINOR before calling misc_register, it
will try to register a previously dynamically allocated minor number, which
may have been registered by a different driver.

One such case is the acpi_thermal_rel misc device, registered by the
int3400 thermal driver. If the device is unbound from the driver and later
bound, if there was another dynamic misc device registered in between, it
would fail to register the acpi_thermal_rel misc device. Other drivers
behave similarly.

Instead of fixing all the drivers, just reset the minor member to
MISC_DYNAMIC_MINOR when calling misc_deregister in case it was a
dynamically allocated minor number.

> Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
> ---
>  drivers/char/misc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/char/misc.c b/drivers/char/misc.c
> index b8e66466184fa21fb66d968db7950e0b5669ac43..96ed343cf5c8509a09855020049a9af82a3ede95 100644
> --- a/drivers/char/misc.c
> +++ b/drivers/char/misc.c
> @@ -288,6 +288,8 @@ void misc_deregister(struct miscdevice *misc)
>  	list_del(&misc->list);
>  	device_destroy(&misc_class, MKDEV(MISC_MAJOR, misc->minor));
>  	misc_minor_free(misc->minor);
> +	if (misc->minor > MISC_DYNAMIC_MINOR)
> +		misc->minor = MISC_DYNAMIC_MINOR;
>  	mutex_unlock(&misc_mtx);
>  }
>  EXPORT_SYMBOL(misc_deregister);
> 
> -- 
> 2.34.1
> 
