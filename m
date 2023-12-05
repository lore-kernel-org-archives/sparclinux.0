Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="Fxt0WOFX";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="qqHqwA8r"
Received: from mailrelay1-1.pub.mailoutpod2-cph3.one.com (mailrelay1-1.pub.mailoutpod2-cph3.one.com [46.30.211.176])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C19D5F
	for <sparclinux@vger.kernel.org>; Tue,  5 Dec 2023 10:06:12 -0800 (PST)
X-HalOne-ID: d2ae00db-9398-11ee-a753-2b733b0ff8f0
Received: from mailrelay3.pub.mailoutpod3-cph3.one.com (unknown [104.37.34.40])
	by mailrelay1 (Halon) with ESMTPS
	id d2ae00db-9398-11ee-a753-2b733b0ff8f0;
	Tue, 05 Dec 2023 18:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=rsa2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=jFI98HwhO4hmbxgSb3qnNvZUZ1OS5V5LFFKPecRy/Y8=;
	b=Fxt0WOFXWCj+DKrEtsLfl4uA12sBbEV2cG+eQ3bIaFUjWvAZxFQPYj4fZDgOIcH0oNryeXxEAQlla
	 sQ47Qil9Qk4OgCrnhifaEa431Q8QJdoyCgt0Cf4JjRJvMgCfyE5+zaZMmqZi6K6MtZHKGEq9Yl0BGp
	 w2DW4zkBjep+Pxu3iwetTTsZdSj2goZ889Hhb38TJcHSblRA0V7Vhm8NLQxurzoGXvqYgnSrrOpZXI
	 wel7VxKUMaKX3rDXVww+YWnKtb+n00H1um8jMhhpK3MsdoiQDwsiMr4bl0HwWIRn9J8ZSRoJZUCfa0
	 OPsam5sHpvuqrgNxmyqtjwU16LockyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=ed2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=jFI98HwhO4hmbxgSb3qnNvZUZ1OS5V5LFFKPecRy/Y8=;
	b=qqHqwA8rmmSXyY2Eh3bTvUE7XO15S3A1qCL+7x4/a4Gv5yW1VON9Rs5ysCHLZgNETtSzqpOrqRLfN
	 2xnEUUjBw==
X-HalOne-ID: d1669999-9398-11ee-8046-85e425223685
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
	by mailrelay3 (Halon) with ESMTPSA
	id d1669999-9398-11ee-8046-85e425223685;
	Tue, 05 Dec 2023 18:05:07 +0000 (UTC)
Date: Tue, 5 Dec 2023 19:05:06 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	"David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] sparc: Use $(kecho) to announce kernel images being ready
Message-ID: <20231205180506.GA242352@ravnborg.org>
References: <20230713075235.2164609-1-u.kleine-koenig@pengutronix.de>
 <20230713145536.GA5300@ravnborg.org>
 <20231204110512.wz6qfsah632bcuh5@pengutronix.de>
 <add3c37a-08ef-41e1-b717-091d9bffd66a@app.fastmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <add3c37a-08ef-41e1-b717-091d9bffd66a@app.fastmail.com>

Hi Arnd.

On Mon, Dec 04, 2023 at 02:06:02PM +0100, Arnd Bergmann wrote:
> I would also
> suggest raising the minimum SPARC32 level to that of
> leon3 (SPARCv8e with CAS), which is what glibc requires
> anyway for futex().

Agreed, it is long time since I got any indications that people
actually use these old machines.
The sparc32 machines I have, have not been powered up for several years
now, and they were only used to test new kernels on anyway.

I sent out a small patch series to do more or less what you suggested
maybe one year ago. Back then the resistance was only from nostalgic
people (like myself) and no real users.

If you or anyone moves forward removing the non-leon sparc32 support
then starting new would be the best approach, I do not think it makes
sense to dig up my old patch set.

	Sam
