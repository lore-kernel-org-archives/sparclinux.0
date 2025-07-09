Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44ABA35962;
	Wed,  9 Jul 2025 13:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752066631; cv=none; b=iOq2jn/u8OcnBcgPgNclp9+aTGg279dVS7Am1oMKh3PaV7IW8mrTPKQRz2MW/izr/htKkPXnThuYtVpf2v3LIiko/KBVfbMfmvwgt4vgdOVnNPjvUYElTKurJjuy7sZ0A548U7p93jlgygcyFlZhbaJ+u5Ibz+3lhSe9kgYkcZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752066631; c=relaxed/simple;
	bh=7Jt7O1pR5EpPW0k2UzAVTXavUdczRi2h2HTT7FBhDJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l4BcriDUVruCdljCEf1qI5pxUXV0nDLAqX+au45CP0YGvmDun7r2zHyvVJGY/FaCmSvet1kz7PRsrSIpA/ZtA2B/fMWjM3KNJhmBSKmEPYbwrsffWPt83dhsTj15zhdieiXTV/y7IPDxdwiY34+d5IVVXKMPoi5he8up1MD+pyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oEpzwmbi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oEpzwmbi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C034C4CEEF;
	Wed,  9 Jul 2025 13:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752066630;
	bh=7Jt7O1pR5EpPW0k2UzAVTXavUdczRi2h2HTT7FBhDJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oEpzwmbi9HZ1new6EewN01Vxu1knb9ECd/WhjoQQ4sR5rbYxZgHCbSzRX0dk+aUIP
	 mL9REFDq6VfVE08TiudY6UgRRngiydHmb59BrRncAmCVXrzMm092lNN0nKvxHLrEnR
	 kdQrdjVOU+3GkXgILA6QZGIxrTDIGzdNzf20MeDg=
Date: Wed, 9 Jul 2025 15:10:26 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
	linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
	sparclinux@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>
Subject: Re: [PATCH v4 5/8] char: misc: Make registering miscdevice reentry
 who wants dynamic minor
Message-ID: <2025070948-habitable-figment-d1aa@gregkh>
References: <20250704-rfc_miscdev-v4-0-b48986112d6a@oss.qualcomm.com>
 <20250704-rfc_miscdev-v4-5-b48986112d6a@oss.qualcomm.com>
 <2025070658-brought-shakable-935e@gregkh>
 <961b53a1-9c30-48ad-becf-81590b27464b@icloud.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <961b53a1-9c30-48ad-becf-81590b27464b@icloud.com>

On Wed, Jul 09, 2025 at 08:41:36PM +0800, Zijun Hu wrote:
> On 2025/7/6 16:55, Greg Kroah-Hartman wrote:
> >> | Invalid fixed minor 257 for miscdevice 'miscdyn_a'
> >> | #miscdev_test_dynamic_reentry: ASSERTION FAILED at misc_minor_kunit.c:639
> >> | Expected ret == 0, but
> >> | ret == -22 (0xffffffffffffffea)
> >> | [FAILED] miscdev_test_dynamic_reentry
> >>
> >> misc_register()/misc_deregister() are sometimes invoked by driver's
> >> probe()/remove() separately, which has reentry requirement.
> > What do you mean?  Why is it required that this is reentrant?  What
> > in-kernel drivers require this?
> > 
> 
> miscdevice APIs are sometimes used by the following way, "drv_probe()->
> drv_remove()->drv_probe()" is possible, so "misc_register()->
> misc_deregister()->misc_register()" is possible and considered by
> previous patch's test case, which needs to register misc_dev again
> without any reinitialization, namely, reentry.
> 
> actually, several in-kernel codes have such usages.
> 
> static struct miscdevice misc_dev = {
> 	...
> 		.minor = MISC_DYNAMIC_MINOR,
> 	...
> };
> 
> int drv_probe() {
> ...
>     // static misc_dev is not initialized before registering.
> 	misc_register(&misc_dev);
> ...
> }
> 
> void drv_remove() {
> 	...
> 	misc_deregister(&misc_dev);
> 	...
> }
> 
> struct device_driver driver = {
> 	.probe = drv_probe,
> 	.remove = drv_remove,
> };
> 
> >> Fix by resetting @misc->minor to MISC_DYNAMIC_MINOR in misc_deregister()
> >> as error handling of misc_register() does.
> >>
> >> Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
> >> ---
> >>  drivers/char/misc.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/drivers/char/misc.c b/drivers/char/misc.c
> >> index b8e66466184fa21fb66d968db7950e0b5669ac43..96ed343cf5c8509a09855020049a9af82a3ede95 100644
> >> --- a/drivers/char/misc.c
> >> +++ b/drivers/char/misc.c
> >> @@ -288,6 +288,8 @@ void misc_deregister(struct miscdevice *misc)
> >>  	list_del(&misc->list);
> >>  	device_destroy(&misc_class, MKDEV(MISC_MAJOR, misc->minor));
> >>  	misc_minor_free(misc->minor);
> >> +	if (misc->minor > MISC_DYNAMIC_MINOR)
> >> +		misc->minor = MISC_DYNAMIC_MINOR;
> >>  	mutex_unlock(&misc_mtx);
> > misc is being unregistered here, so why are you changing the minor
> > field?  It's now invalid as it is not registered, so this value should
> > never be relied on at all, neither is anything else in this structure.
> 
> reset its minor code is to register it again without re-initialization
> successfully
> 
> the other members are handed by misc_deregister() properly and don't
> effect re-registering.

Then we are getting lucky, let's clear out all the fields we modified
and later rely on as this feels very fragile.

thanks,

greg k-h
