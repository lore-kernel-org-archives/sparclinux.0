Received: from mailrelay6-1.pub.mailoutpod2-cph3.one.com (mailrelay6-1.pub.mailoutpod2-cph3.one.com [46.30.211.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED4913CA85
	for <sparclinux@vger.kernel.org>; Tue, 23 Apr 2024 17:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713893628; cv=none; b=lu+kluT41B2E+XvHdH0/peGizBJXLqPasHFgg6MvJz3e9z52BQxfOk8nf7z8vGBDmPuASzhyJyQFvXX7kbawq12leQW5Bfhe2CkQX/BWRXUMrIspHA9rhXSEZWkFIS8xCCawqIUtFbvpQABEo+RPoKbVqhFWihJrcJKQZmjEIAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713893628; c=relaxed/simple;
	bh=9pjnF/sPtJO+LvWkr3X+fDnCjrIy+zY6WcPdCHL1znE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f54tONnERUBlAF2zrBW+pencUXetGkyEXHgR/td7NobHUopJs3egx83DfZ+iL0UaBgtgbyxDN92IdHVEEfmoai7cl42y7icq4Gq6Sz7r1jq22NP07xGNN9SWUWPW0GE0+7pa+RhFFb6kfS0lR0TkLz0CGYzCQkd+/13fF9UL8D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org; spf=none smtp.mailfrom=ravnborg.org; dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=DBPJ/FxH; dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=bi2wmK5d; arc=none smtp.client-ip=46.30.211.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="DBPJ/FxH";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="bi2wmK5d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=rsa1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=nmviYWlePXoCTNoL8uSMyNJyymgrWXMrhVfEOl91VNk=;
	b=DBPJ/FxHGN7LZz/lQwGoM3czNIekdth+G6EpzOp8tp6+noiZ1JDunl/AZQW7XV0eHttKF+SQ5KrTJ
	 aXiOIMguZw0fr3MzVsuwLXsq/zl0NDBXwOE8vfGgEf8jGwCWIiBrwWvE20UbAh6gKAf1DzVaCGniMM
	 RoaRifInqY8ER1RRMYCrOugAelCILEK0c/zCiloA+WWfRY+BkcM+2pJmw3WfOfDIHz16vKGWZSnuVk
	 WbwoAfcNLygUX4u22pIpm48+aZIcqIFaJZs164rK0+uGsZlJnzf4hA/0YtRtXLWlVZDZbO+Z/1dvgu
	 CIm7mHiAPfEFFXzHGKk9bG7Qx3LwP+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=ed1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=nmviYWlePXoCTNoL8uSMyNJyymgrWXMrhVfEOl91VNk=;
	b=bi2wmK5dXvsDnj398Vd8zkDcpaiRqWPqOj8Zhffn+JtA+0KH+m+aT8DHmqeODIcPCHT8snKI3ZSSx
	 jtWIS4+Dw==
X-HalOne-ID: 73280bfb-0197-11ef-867a-f528319a6ef4
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
	by mailrelay6.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id 73280bfb-0197-11ef-867a-f528319a6ef4;
	Tue, 23 Apr 2024 17:32:35 +0000 (UTC)
Date: Tue, 23 Apr 2024 19:32:26 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Dawei Li <dawei.li@shingroup.cn>
Cc: davem@davemloft.net, andreas@gaisler.com, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/6] sparc/init: Remove on-stack cpumask var
Message-ID: <20240423173226.GB903763@ravnborg.org>
References: <20240423083043.3735921-1-dawei.li@shingroup.cn>
 <20240423083043.3735921-6-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423083043.3735921-6-dawei.li@shingroup.cn>

Hi Dawei.

On Tue, Apr 23, 2024 at 04:30:42PM +0800, Dawei Li wrote:
> In general it's preferable to avoid placing cpumasks on the stack, as
> for large values of NR_CPUS these can consume significant amounts of
> stack space and make stack overflows more likely.
> 
> Since the cpumask var resides in __init function, which means it's free
> of any concurrenct access, it can be safely marked with static to get
> rid of allocation on stack.
> 
> Signed-off-by: Dawei Li <dawei.li@shingroup.cn>

I am not convinced this patch is the right approach, and I am not sure
it is worth trying to fix it.
This patch adds complexity, where the other patches simplified code.
I recommend to drop this, we can re-visit if this turns out to be a real
problem.

	Sam
