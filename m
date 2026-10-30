Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.165
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793351014;
	b=3BwI5rFrL6KkXqhzmZT+awSG6khKmmFnkSarS+XfAqJBd0zYR1N0jEi9nyfj0s2Q4+nM
	 UctA8lz9UrLwl6F0OtdSJOKoGSr8dwhl0W/jaMyotdfTzZUjkVu8FjSOYNDocbVdmTHY5
	 v9UHUwlyRfPuN4kf+O/t7WlyOB6wuciu6zhaIwOi6lJYJCEtxsmgY4BGT8H/HeuIpPfqc
	 v8TtEH5Hi+y1mecfi2SUFg7yABXtV1QZuJ6H/me1iRZO/kw+xmPYoljppo3JFXJ6hTDNO
	 gJSvQi2+Rz3DbQcp2hshHQ/xt2itunNC9qc6KB53WaYkpLrIWBim3OiUQyXrLoPbFsQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793351014;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=BNkcCp20/jKyyfDBh5bxEy/pRQFxvOWB8jsdYNcW3Y0=;
	b=KV1MyuV2FlXpBx/ZxsVeSoi9tF7J82yMj1bI9wfCp/a/gakBfaY55HdTqGEbL4H1I9O2
	 WPh+b//ruSyjKtO20boogUBAZes4BAhvRBWZDE0XVZl+OwdVxuByeYIMlqGA93/Q5whKv
	 k5IZvS79B/Ghvfyl+xDH7uYdGlQihuEbysFCW/o+k0/5AxBhhp5Sc38ksrrxD0Uc/elIk
	 +czOkefIzuK++ekWv58ijutZD0w4HSJ2h3/tCspPtxXZxsFK2+bmWPDcrNhqyVh/CzHPb
	 C+2I9S/jf1A1ZTL9MOjuPibzuvGXbAX5Zppov5ywytg2dKK/qr7d0cTk+QcsRmsqm4g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outer-limits.org;
	spf=pass smtp.mailfrom=outer-limits.org;
	dkim=pass header.d=outer-limits.org header.i=@outer-limits.org header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=MGwYypQf;
	dkim=pass header.d=outer-limits.org header.i=@outer-limits.org header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=qoRvl8+I;
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.165
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F405606A31A;
	Fri, 30 Oct 2026 09:03:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F405606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=outer-limits.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outer-limits.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outer-limits.org header.i=@outer-limits.org header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=MGwYypQf;
	dkim=pass header.d=outer-limits.org header.i=@outer-limits.org header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=qoRvl8+I
ARC-Seal: i=1; a=rsa-sha256; t=1793351004; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Xsfj/1yqRIDzHHztz84JGUVUyb6rrnzFJovMTPP744Yo7qRFzWDuFBO1XMUllwUwUj
    rhFM/JESYH+3r52v8haKsiZOsjwiFx9wp8omWSMdkT3LcNPqUqBGyBukyCxMbZ1dgxMO
    ctT8g1I17Le/CjH2mXjURhazMrmIKamQg0T9IwIESUhhrdA4xX/isE8Zl2VaZrvV332d
    L41NWytJDpXr7REcqibV9hHJP9bjcTDsbyrYzq3bQqYCNgUOJiUmmR4SGwwxi3XKnygj
    iAHGp4k0H25U0GhI6jjQT5VY78LigfeEEE9TVKvOT9gHDklXHYz4Vh9VvTmCTAo4uCSx
    Ynnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1793351004;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=BNkcCp20/jKyyfDBh5bxEy/pRQFxvOWB8jsdYNcW3Y0=;
    b=gpbICJz9LVUW18p/WOCwUZ+lQaMQoWHw8QB0I+Q+bh2yEKjWHRdAGfLtnrS5+hIA3I
    lxatoVAzhdZKcele4+eXRq2dM/EuEjYh+Y6c2PjvcDeOdNJiL4kCNsP3aVCc+BIVkRZ7
    84gOkSZo6dlGENfRFewxNd3SZbkUY6xvkVxWH9t91SiMOaQVvlxaIrIttkeoGt5khMDf
    fVsiN+yvD+48R5S8QH1N6IQ2uJT9WkLit2notJWsGx0qlRKj91Qzo0Wkfx2svjx7rhak
    qN/N0xqBKsKm4NS/8tabkqgMIwMuFnPPqs7ddnLKFr6130aCnYpBbrwzUt9TOTqKCLyJ
    0l7w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1793351004;
    s=strato-dkim-0002; d=outer-limits.org;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=BNkcCp20/jKyyfDBh5bxEy/pRQFxvOWB8jsdYNcW3Y0=;
    b=MGwYypQfelnm82RsqMQAyDSEabTMSK1HEavLMkDHj26lGS9qjy04jlywAHqUemt/OO
    B1PfbxhAWw5K+xqq+cSWA6iLxLyeAM2YxvmiSmZR5NOP+HfHthMk/K1wHO3D038vfJ0k
    TwZa+r/x8BxlA/zqnKKhcfGSiLe0JRDhwqoXOa31rzfnN+9+8daH2y8HPzv9S/ch1w/1
    OLKd90Zh7Fpq4YOyIDXnerLstTnB06durwXRXaa1GVi3D8UedF8bpPVrkHlnNc6rdQTi
    2LY6+eQC4dNQdQeyyXvINCSlY58xRL7B98V1Luxv/9c0titiHa/a0Odv9JvHai5ye/7k
    Ax9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1793351004;
    s=strato-dkim-0003; d=outer-limits.org;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=BNkcCp20/jKyyfDBh5bxEy/pRQFxvOWB8jsdYNcW3Y0=;
    b=qoRvl8+I+3sbbtb7jIKtxX9i3QAli0sHWwvIIoQWCy+E2tVabQmkLeJ17eMuALADEs
    Gm8QRGjYuy2mm+n1j6CQ==
X-RZG-AUTH: ":JnkIfEGmW/AMJS6HttH4FbRVwc4dHlPLCp4e/IoHo8zEMMHAgwTfqBFXdk1Z4tK2c3m3zwosfchN4xKAr09Q9TjYzlH0J0wOOKeu6fc="
Received: from [IPV6:2a01:e0a:db7:f20:3321:36c8:177b:1eb0]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id J82cde29U93N7cZ
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 30 Oct 2026 10:03:23 +0100 (CET)
Message-ID: <82307061-8bbb-4e42-89cf-cb0b5ab1442f@outer-limits.org>
Date: Fri, 30 Oct 2026 10:03:23 +0100
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sparc: Remove IO memcpy and memset from sparc code
To: Arnd Bergmann <arnd@arndb.de>, "David S . Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261029145309.132218-1-julian@outer-limits.org>
 <e26b3c92-5213-44f3-8914-5ee8fb2d662a@app.fastmail.com>
Content-Language: en-US
From: Julian Vetter <julian@outer-limits.org>
Autocrypt: addr=julian@outer-limits.org; keydata=
 xjMEaLvwgxYJKwYBBAHaRw8BAQdA6u9Gv9DAWoEq0Jh+krJQqvgA9crvjYIJ1zL38JLsdOLN
 J0p1bGlhbiBWZXR0ZXIgPGp1bGlhbkBvdXRlci1saW1pdHMub3JnPsKTBBMWCgA7FiEEKsxf
 M6APqlFEwlRheMhx4x8L9BsFAmi78IMCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQeMhx4x8L9Bv4PAEAirijszkHGYvhggZvlSx20Pumm2rCol4OzlxO5BcFRMQBAP+PvG0d
 H4/6nomybCtCDS2rHLv8mA1O4Zn/f073zGUJzjgEaLvwgxIKKwYBBAGXVQEFAQEHQNJXxAh6
 JmVPz+Tw8W+SQ9nMlNV6KD8l0uLlSV/s1f0BAwEIB8J4BBgWCgAgFiEEKsxfM6APqlFEwlRh
 eMhx4x8L9BsFAmi78IMCGwwACgkQeMhx4x8L9BvCRQEA6rFFo2ZiAMR6vT5iJvdWQpkqh1NH
 XmyCC2h0RIqIEJQA/iAKZBD9h6RVoLScco+nlA+mppdkrg5lb2pvJpENMfQJ
In-Reply-To: <e26b3c92-5213-44f3-8914-5ee8fb2d662a@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/29/26 16:13, Arnd Bergmann wrote:
> On Thu, Oct 29, 2026, at 15:53, Julian Vetter wrote:
>> Remove the IO memcpy and memset from sparc specific code and fall back
>> to the implementations from lib/iomem_copy.c. They use word accesses if
>> the buffers are aligned and only fall back to byte accesses for
>> potentially unaligned parts of a buffer, while the sparc versions always
>> use byte-wise readb()/writeb() accesses. Other architectures, such as
>> arm64, csky, loongarch and parisc, have already been converted to the
>> generic implementation.
>>
>> This does not drop any memory barriers. The sparc versions don't use
>> mb(), and the rmb()/wmb() implied by readb()/writeb() on sparc32 and
>> sparc64 are only compiler barriers.
> 
> Hi Julian,
> 
> I suspect the sparc64 patch is wrong because the generic
> code relies on __raw_readq()/__raw_readl() to produce
> native-endian data, while the sparc64 version looks like
> they work on little-endian data the same way as readq()/readl().
> 
> Do you know if the PCI host bridge on sparc64 does an implicit
> byte swap for memory space? If it does, the __raw_ accessors
> have to flip swap the data another time for this to work.
> 
>        Arnd

Hello Arnd,
thank you for your reply! I'm not sure, but to me it seems unlikely that 
the PCI host bridge swaps. On sparc64 readl()/readq() use the flag 
ASI_PHYS_BYPASS_EC_E_L, so they work on little-endian data. The CPU does 
the byte swap here. The __raw_*() accessors use ASI_PHYS_BYPASS_EC_E, 
which does not swap (which are used in lib/io_memcpy.c as well), so they 
return the data in address order. If the PCI host bridge also swapped, 
readl() would return double-swapped values, no?

And other I/O functions, e.g., readsl()/writesl() and 
ioread32_rep()/iowrite32_rep() end up in insl()/outsl() in 
arch/sparc/lib/PeeCeeI.c, which copy buffers with 
__raw_readl()/__raw_writel(). And __ioread32_copy()/__iowrite32_copy() 
in lib/iomap_copy.c use the __raw_ accessors on sparc64 as well.

But that's just from me looking at the code and compiling the 
sparc32_defconfig and sparc64_defconfig. I have no sparc platform, so 
can't test it. Maybe some sparc expert can comment.

Julian
